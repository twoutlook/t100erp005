#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi310.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000056
#+ 
#+ Filename...: azzi310
#+ Description: 自定義查詢維護作業
#+ Creator....: 02286(2015-05-12 14:25:08)
#+ Modifier...: 02286(2015-07-08 17:14:10) -SD/PR- 02286
 
{</section>}
 
{<section id="azzi310.global" >}
#應用 t01 樣板自動產生(Version:39)
#+ Modifier...: No.150924-00005#1   2015/9/24   chenjpa  调整打印格式
#                                                        1.打印:总和结果没有显示
#                                                        2.打印结果数据格式须右对齐
#                                                        3.打印:小计显示顺序有问题
#+ Modifier...: No.151016-00016#1   2015/10/16  chenjpa   修改参数设置
#+ Modifier...: No.151116-00008#1   2015/11/16  chenjpa   修改客制码的赋值方式
#+ Modifier...: No.151214-00004#1   2015/12/14  chenjpa   增加解析含有case when/decode/nvl关键字的sql
#+ Modifier...: No.151214-00004#1   2015/12/15  chenjpa   修正一个sql一个表多次使用问题
#+ Modifier...: No.151214-00004#1   2015/12/16  chenjpa   修正汇出excel内容被截断
#+ Modifier...: No.160318-00005#55  2016/03/31  pengxin  修正azzi902重复定义之错误讯息
#+ Modifier...: No.160727-00019#26  2016/08/05  By 08742  系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                                        Mod   azzi310_sum2_tmp--> azzi310_tmp01 
#+ Modifier...: No.160711-00011#1   2016/07/11   chenjpa  修正无法解析带算术运算符的栏位  
#+ Modifier...: No.160721-00005#1   2016/07/25   chenjpa  修正自定义栏位无法汇总的问题
#+ Modifier...: No.160805-00010#1   2016/08/05   chenjpa  1.aooi920调用azzi310提供接口，连续多次调用但是传的报表ID不一样，弹出qbe界面是一样
#                                                        2.视图名字超过15个字符会被截断
#+ Modifier...: No.160523-00002#1   2016/05/23   chenjpa  新增塞选视图view数据
#+ Modifier...: No.160523-00002#2   2016/06/15   chenjpa  新增串查
#+ Modifier...: No.160822-00021#1   2016/08/22   chenjpa  修改重新解析sql,保留单身原设定好的的数据
#+ Modifier...: No.160825-00014#1   2016/08/25   chenjpa  修改表头和表尾的位置
#+ Modifier...: No.160830-00018#1   2016/08/30   chenjpa  将自定义报表汇出excelhtml格式改成xml格式
#+ Modifier...: No.160901-00030#1   2016/09/01   chenjpa  增加串查传多个参数
#+ Modifier...: No.161121-00024#1   2016/11/21   chenjpa  增加qbe窗口显示顺序设置
#+ Modifier...: No.161122-00035#1   2016/11/22   chenjpa  新增状态下多次点击解析sql，报错：insert into gzidl_t 违反唯一的限制.限制名称
#+ Modifier...: No.161123-00013#1   2016/11/23   chenjpa  qbe开窗不支持timestamp类型查询
#+ Modifier...: No.161124-00042#1   2016/11/24   chenjpa  补单161121-00024
#+ Modifier...: No.161125-00024#1   2016/11/28   chenjpa  修改azzi310后续动作：取消自动增加ent部分，改成提示用户的方式
#+ Modifier...: No.161202-00026#1   2016/12/02   chenjpa  群主栏位下设置汇总栏位且群主栏位和qbe栏位有重合，打印会闪出。单号#160721-00005#1和单号160822-00021#1遗留问题
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT FGL adz_sadzp190_tbls 
IMPORT FGL adz_sadzp190_db
IMPORT FGL adz_sadzp190
IMPORT com
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS

   DEFINE g_ze767     LIKE gzze_t.gzze003
   DEFINE g_ze768     LIKE gzze_t.gzze003
   DEFINE g_gzze00    LIKE gzze_t.gzze003
   DEFINE g_gzze01    LIKE gzze_t.gzze003
   DEFINE g_gzze02    LIKE gzze_t.gzze003
   DEFINE g_gzze03    LIKE gzze_t.gzze003
   DEFINE g_gzze04    LIKE gzze_t.gzze003
   DEFINE g_gzze06    LIKE gzze_t.gzze003
   DEFINE g_gzze07    LIKE gzze_t.gzze003
   
 
   DEFINE g_tab DYNAMIC ARRAY OF RECORD
       tabname       LIKE dzea_t.dzea001,
       tabnamec     LIKE dzea_t.dzea002,
       tabalias    LIKE dzgc_t.dzgc007
         END RECORD
   DEFINE g_tab_cnt   LIKE type_t.num5
 
END GLOBALS
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_gzia_m        RECORD
       gzia001 LIKE gzia_t.gzia001, 
   gzia002 LIKE gzia_t.gzia002, 
   gzial003 LIKE gzial_t.gzial003, 
   gzia003 LIKE gzia_t.gzia003, 
   gzia005 LIKE gzia_t.gzia005, 
   gzia004 LIKE gzia_t.gzia004, 
   gzia006 LIKE gzia_t.gzia006, 
   gziastus LIKE gzia_t.gziastus, 
   gziaownid LIKE gzia_t.gziaownid, 
   gziaownid_desc LIKE type_t.chr80, 
   gziaowndp LIKE gzia_t.gziaowndp, 
   gziaowndp_desc LIKE type_t.chr80, 
   gziacrtid LIKE gzia_t.gziacrtid, 
   gziacrtid_desc LIKE type_t.chr80, 
   gziacrtdp LIKE gzia_t.gziacrtdp, 
   gziacrtdp_desc LIKE type_t.chr80, 
   gziacrtdt LIKE gzia_t.gziacrtdt, 
   gziamodid LIKE gzia_t.gziamodid, 
   gziamodid_desc LIKE type_t.chr80, 
   gziamoddt LIKE gzia_t.gziamoddt, 
   groupname LIKE type_t.chr500, 
   sumyname1 LIKE type_t.chr500, 
   comb_sumy LIKE type_t.chr500, 
   s_global_var LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzib_d        RECORD
       gzib002 LIKE gzib_t.gzib002, 
   gzib003 LIKE gzib_t.gzib003, 
   gzib002_desc LIKE type_t.chr500, 
   gzib005 LIKE gzib_t.gzib005, 
   gzib006 LIKE gzib_t.gzib006, 
   gzib004 LIKE gzib_t.gzib004
       END RECORD
PRIVATE TYPE type_g_gzib2_d RECORD
       gzie002 LIKE gzie_t.gzie002, 
   gzie003 LIKE gzie_t.gzie003, 
   gzie005 LIKE gzie_t.gzie005
       END RECORD
PRIVATE TYPE type_g_gzib3_d RECORD
       gzid002 LIKE gzid_t.gzid002, 
   gzid003 LIKE gzid_t.gzid003,
   gzig002 LIKE gzig_t.gzig002,   #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题,gzig002存储的是真实表名,gzid003存储的是别名
   gzid004 LIKE gzid_t.gzid004, 
   gzidl004 LIKE type_t.chr500, 
   gzid005 LIKE gzid_t.gzid005, 
   gzid006 LIKE gzid_t.gzid006, 
   gzid007 LIKE gzid_t.gzid007, 
   gzid018 LIKE gzid_t.gzid018,   #161121-00024#1 add
   gzid008 LIKE gzid_t.gzid008, 
   gzid009 LIKE gzid_t.gzid009, 
   gzid014 LIKE gzid_t.gzid014,  #160523-00002#2 add
   gzid015 LIKE gzid_t.gzid015,  #160523-00002#2 add
   gzid017 LIKE gzid_t.gzid017,  #160901-00030#1 add
   gzid010 LIKE gzid_t.gzid010, 
   gzid011 LIKE gzid_t.gzid011, 
   gzid012 LIKE gzid_t.gzid012
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gzia001 LIKE gzia_t.gzia001
       END RECORD
       
#模組變數(Module Variables)
DEFINE g_gzia_m          type_g_gzia_m
DEFINE g_gzia_m_t        type_g_gzia_m
DEFINE g_gzia_m_o        type_g_gzia_m
DEFINE g_gzia_m_mask_o   type_g_gzia_m #轉換遮罩前資料
DEFINE g_gzia_m_mask_n   type_g_gzia_m #轉換遮罩後資料
 
   DEFINE g_gzia001_t LIKE gzia_t.gzia001
 
 
DEFINE g_gzib_d          DYNAMIC ARRAY OF type_g_gzib_d
DEFINE g_gzib_d_t        type_g_gzib_d
DEFINE g_gzib_d_o        type_g_gzib_d
DEFINE g_gzib_d_mask_o   DYNAMIC ARRAY OF type_g_gzib_d #轉換遮罩前資料
DEFINE g_gzib_d_mask_n   DYNAMIC ARRAY OF type_g_gzib_d #轉換遮罩後資料
DEFINE g_gzib2_d          DYNAMIC ARRAY OF type_g_gzib2_d
DEFINE g_gzib2_d_t        type_g_gzib2_d
DEFINE g_gzib2_d_o        type_g_gzib2_d
DEFINE g_gzib2_d_mask_o   DYNAMIC ARRAY OF type_g_gzib2_d #轉換遮罩前資料
DEFINE g_gzib2_d_mask_n   DYNAMIC ARRAY OF type_g_gzib2_d #轉換遮罩後資料
DEFINE g_gzib3_d          DYNAMIC ARRAY OF type_g_gzib3_d
DEFINE g_gzib3_d_t        type_g_gzib3_d
DEFINE g_gzib3_d_o        type_g_gzib3_d
DEFINE g_gzib3_d_mask_o   DYNAMIC ARRAY OF type_g_gzib3_d #轉換遮罩前資料
DEFINE g_gzib3_d_mask_n   DYNAMIC ARRAY OF type_g_gzib3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      gzial001 LIKE gzial_t.gzial001,
      gzial003 LIKE gzial_t.gzial003
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
 
#add-point:自定義模組變數(Module Variable)

#type 宣告
 TYPE type_table1_d RECORD
   tab1_01 LIKE dzea_t.dzea001,  #Table
   tab1_02 LIKE type_t.chr20,    #Alias
   tab1_03 LIKE type_t.chr1,     #join type
   tab1_04 LIKE type_t.chr1000,  #连结字段
   tab1_05 LIKE type_t.chr1000   #被连结字段
   END RECORD

 TYPE type_table2_d RECORD
   tab2_01 LIKE type_t.chr20,    #table alias
   tab2_02 LIKE dzeb_t.dzeb002,  #column
   tab2_03 LIKE type_t.chr20     #alias
   END RECORD

 TYPE type_table3_d RECORD
   tab3_01 LIKE type_t.chr20,    #alias
   tab3_02 LIKE dzeb_t.dzeb002,  #column
   tab3_03 LIKE type_t.chr1,     #比较运算符
   tab3_04 LIKE type_t.chr100,   #条件值
   tab3_05 LIKE type_t.chr20,    #alias
   tab3_06 LIKE dzeb_t.dzeb002,  #column
   tab3_07 LIKE type_t.chr1,     #比较运算符
   tab3_09 LIKE type_t.chr1,     #(
   tab3_10 LIKE type_t.chr1      #)
   END RECORD

 TYPE type_table4_d RECORD
   tab4_01 LIKE type_t.chr20,
   tab4_02 LIKE dzeb_t.dzeb002,
   tab4_03 LIKE type_t.chr1,
   tab4_04 LIKE type_t.chr100,
   tab4_05 LIKE type_t.chr20,
   tab4_06 LIKE dzeb_t.dzeb002,
   tab4_07 LIKE type_t.chr1,
   tab4_09 LIKE type_t.chr1,
   tab4_10 LIKE type_t.chr1
   END RECORD

 TYPE T_OBJECT_LIST RECORD 
   OBJECT_NAME   LIKE type_t.chr30,
   OBJECT_DESC   LIKE type_t.chr100 
   END RECORD
                          
TYPE T_OBJECT_LIST2 RECORD
   ALIAS         LIKE type_t.chr30,
   OBJECT_NAME   LIKE type_t.chr30,
   OBJECT_DESC   LIKE type_t.chr100 
END RECORD

DEFINE g_detail_idx3         LIKE type_t.num5              #table3目前所在笔数
DEFINE g_detail_idx4         LIKE type_t.num5              #table4目前所在笔数
DEFINE g_rec_b2              LIKE type_t.num5
DEFINE g_rec_b3              LIKE type_t.num5
DEFINE g_rec_b4              LIKE type_t.num5
DEFINE g_table1_d            DYNAMIC ARRAY OF type_table1_d
DEFINE g_table2_d            DYNAMIC ARRAY OF type_table2_d
DEFINE g_table3_d            DYNAMIC ARRAY OF type_table3_d
DEFINE g_table4_d            DYNAMIC ARRAY OF type_table4_d
DEFINE g_checkbox1           LIKE type_t.chr1
DEFINE g_checkbox2           LIKE type_t.chr1
DEFINE g_checkbox3           LIKE type_t.chr1
DEFINE g_textedit1           STRING
DEFINE g_type                LIKE type_t.chr10
DEFINE g_return              STRING
   
DEFINE   g_groupname LIKE type_t.chr500, 
         g_sumyname1 LIKE type_t.chr500, 
         g_comb_sumy LIKE type_t.chr500, 
         g_global_var          STRING

DEFINE g_detail_multi_table_t    RECORD
   gzidl001 LIKE gzidl_t.gzidl001,
   gzidl002 LIKE gzidl_t.gzidl002,
   gzidl003 LIKE gzidl_t.gzidl003,
   gzidl004 LIKE gzidl_t.gzidl004
END RECORD

DEFINE l_rep_ac              LIKE type_t.num5   
DEFINE g_rep_upd_tag         LIKE type_t.num5
DEFINE g_before_input_done   LIKE type_t.num5

DEFINE tok                  base.StringTokenizer
DEFINE g_sqlcmd             STRING

 type type_g_gzib_d1   RECORD
             gzib002         LIKE gzib_t.gzib002, 
             gzib003         LIKE gzib_t.gzib003, 
             paging          LIKE type_t.chr1,
             group           LIKE type_t.chr1,
             sort            LIKE type_t.chr1
END RECORD 

# type type_g_groupsel          RECORD
#          gzib002            LIKE gzib_t.gzib002,
#          gzib003            LIKE gzib_t.gzib003,  #避免排序錯誤, 序號值必須抓出, 但不顯示
#          name               LIKE dzebl_t.dzebl003,
#          group              LIKE type_t.chr1,
#          sort               LIKE type_t.chr1,
#          paging             LIKE type_t.chr1
#                             END RECORD
                             
DEFINE g_gzib_d1    type_g_gzib_d1

#UI變數
DEFINE gdig_curr             ui.Dialog                  

#群組頁簽 - (左上)樹狀欄位清單
DEFINE g_grouplist      DYNAMIC ARRAY OF RECORD
          groupname       STRING,
          groupid         LIKE gzid_t.gzid004,   
          grouppid        LIKE gzid_t.gzid003,
          groupexp        LIKE type_t.num5,
          groupisnode     LIKE type_t.num5,
          groupalias      STRING                    #151214-00004#2 add   #增加资料表别名的信息，解决一表多用问题
              END RECORD
#群組頁簽 - (右)已挑選欄位清單 
#DEFINE g_groupsel  DYNAMIC ARRAY OF type_g_groupsel
#DEFINE g_groupsel_t   type_g_groupsel
 
 # 彙總頁簽 - (左)樹狀欄位清單                            
DEFINE g_sumylist1      DYNAMIC ARRAY OF RECORD
          sumyname1       STRING,
          sumyid1         LIKE gzid_t.gzid004,
          sumypid1        LIKE gzid_t.gzid003,
          sumyexp1        LIKE type_t.num5,
          sumyisnode1     LIKE type_t.num5
          #sumyalias1      LIKE dzgc_t.dzgc007         
END RECORD
                        
# 彙總頁簽 - (右)樹狀欄位清單
DEFINE g_sumylist2      DYNAMIC ARRAY OF RECORD
          sumyname2       STRING,
          sumyid2         LIKE gzid_t.gzid004,
          sumypid2        LIKE gzid_t.gzid003,
          sumyexp2        LIKE type_t.num5,
          sumyisnode2     LIKE type_t.num5,
          sumytype2       LIKE gzgg_t.gzgg010,
          sumypidseq2     LIKE type_t.num5     #父順序
         # sumyalias2      LIKE dzgc_t.dzgc007   ##140606 add
END RECORD  


DEFINE g_tab DYNAMIC ARRAY OF RECORD
       tabname       LIKE dzea_t.dzea001,
       tabnamec     LIKE dzea_t.dzea002,
       #tabalias    LIKE dzgc_t.dzgc007     
       tabalias    LIKE gzig_t.gzig003,       #151214-00004#01 mod
       views       LIKE type_t.chr1          #160523-00002#1 add
END RECORD
DEFINE g_tab_cnt   LIKE type_t.num5

DEFINE g_tabs      STRING
DEFINE g_parsql    STRING

DEFINE g_feld DYNAMIC ARRAY OF RECORD
       tabname     LIKE dzeb_t.dzeb001,
       feldname    LIKE gzid_t.gzid004,       #160901-00030#1 mod dzeb002->gzid004
       feldnamec   LIKE dzeb_t.dzeb003,
       feldtype    LIKE dzeb_t.dzeb007,
       feldlen     LIKE gztd_t.gztd010,        #画面宽度
       feldpreci   LIKE type_t.chr10,           #小数位数
       feldalias   LIKE gzid_t.gzid004,       #160901-00030#1 mod dzgc007->gzid016
       feldprop    LIKE gztd_t.gztd001         #栏位属性
END RECORD             
 
DEFINE g_max_count      LIKE type_t.num10      #151016-00016#1 add
DEFINE g_gzia006_t      LIKE gzia_t.gzia006
DEFINE g_chk_sql        LIKE type_t.chr1
DEFINE g_action_t       STRING
DEFINE g_gzib_d_idx     LIKE type_t.num5     
DEFINE g_grouplist_idx    LIKE type_t.num5    
DEFINE g_gzib3_d_idx       LIKE type_t.num5    
DEFINE g_gzib2_d_idx     LIKE type_t.num5    
DEFINE g_sumylist1_idx    LIKE type_t.num5   
DEFINE g_sumylist2_idx    LIKE type_t.num5  
DEFINE g_sum_idx          LIKE type_t.num5  
DEFINE g_execmd           STRING
DEFINE g_args             DYNAMIC ARRAY OF LIKE type_t.chr10
DEFINE g_argcnt           LIKE type_t.num5
DEFINE g_gzia001_module      LIKE gzza_t.gzza003
DEFINE g_insert_flag      LIKE type_t.chr5
DEFINE g_upd_flag         LIKE type_t.chr1
CONSTANT cs_side_left  STRING = "LEFT"
CONSTANT cs_side_right STRING = "RIGHT"
CONSTANT cs_null_value STRING = "!@#"
DEFINE g_parse_flag       LIKE type_t.chr1   #161122-00035#1 add
#test-
DEFINE g_input     RECORD
          gzia001      LIKE gzia_t.gzia001,
          gziaownid    LIKE gzia_t.gziaownid,
          gzia005      LIKE gzia_t.gzia005 
              END RECORD
#test-
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi310.main" >}
#應用 a26 樣板自動產生(Version:4)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define
 DEFINE   l_argv           ARRAY[9] OF STRING     #所有外部參數
  #test
   DEFINE w                               ui.Window
   DEFINE twindow                         om.DomNode
   DEFINE lst_table                       om.NodeList
   DEFINE n_table                         om.DomNode 
   DEFINE lst_value                       om.NodeList
   DEFINE n_value                        om.DomNode 
   DEFINE lfrm_curr       ui.Form
   DEFINE ln_tmp        om.DomNode
   #test
   #end add-point   
   #add-point:main段define(客製用)
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
   LET g_gzia_m.gzia001 =g_argv[01]
#       LET l_argv[1]=g_argv[02]
#       LET l_argv[2]=g_argv[03]
#       LET l_argv[3]=g_argv[04]
#       LET l_argv[4]=g_argv[05]
#       LET l_argv[5]=g_argv[06]
#       LET l_argv[6]=g_argv[07]
#       LET l_argv[7]=g_argv[08]
#       LET l_argv[8]=g_argv[09]
#       LET l_argv[9]=g_argv[10]
#   DISPLAY "1:",g_argv[01]
#   DISPLAY "2:",g_argv[02]
#   DISPLAY "3:",g_argv[03]
#   DISPLAY "4:",g_argv[04]
#   DISPLAY "5:",g_argv[05]
#   DISPLAY "6:",g_argv[06]
#   DISPLAY "7:",g_argv[07]
#   DISPLAY "8:",g_argv[08]
#   DISPLAY "9:",g_argv[09]
#   DISPLAY "10:",g_argv[10]
 
#      LET g_wc= azzi310_01_get_JsonCondition("aapr001") #test
#      DISPLAY g_wc
#      LET l_ac=azzi310_01_get_record_number("aapr001",g_wc)
#      DISPLAY "l_ac",l_ac
#      CALL cl_ap_exitprogram("0")
      
   
   IF NOT cl_null(g_gzia_m.gzia001) AND ( g_argv[01] <>'p_addview' OR cl_null(g_argv[01])) THEN
   
           OPEN WINDOW w_azzi310 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
       CALL cl_ui_init()
       CLOSE WINDOW w_azzi310
       CALL azzi310_cmdrun()
       CALL cl_ap_exitprogram("0")
#       EXIT PROGRAM
   END IF
   
   LET g_ze767=cl_getmsg('azz-00767',g_dlang)
   LET g_ze768=cl_getmsg('azz-00768',g_dlang)      
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT gzia001,gzia002,'',gzia003,gzia005,gzia004,gzia006,gziastus,gziaownid, 
       '',gziaowndp,'',gziacrtid,'',gziacrtdp,'',gziacrtdt,gziamodid,'',gziamoddt,'','','',''", 
                      " FROM gzia_t",
                      " WHERE gzia001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.gzia001,t0.gzia002,t0.gzia003,t0.gzia005,t0.gzia004,t0.gzia006,t0.gziastus, 
       t0.gziaownid,t0.gziaowndp,t0.gziacrtid,t0.gziacrtdp,t0.gziacrtdt,t0.gziamodid,t0.gziamoddt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM gzia_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.gziaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.gziaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.gziacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.gziacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.gziamodid  ",
 
               " WHERE  t0.gzia001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE azzi310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi310 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi310_init()   
 
      #進入選單 Menu (="N")
      CALL azzi310_ui_dialog() 
      
      #add-point:畫面關閉前
 #test-
       LET w = ui.Window.getCurrent()
       LET twindow = w.getNode()
       LET lst_table = twindow.selectByTagName("Table")
       LET n_table = lst_table.item(6)
       LET lst_value = n_table.selectByTagName("ValueList")
       LET n_value = lst_value.item(4)
       LET lfrm_curr = w.getForm()
       LET ln_tmp = lfrm_curr.findNode("Table","s_detail3")
       #test-
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi310
      
   END IF 
   
   CLOSE azzi310_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="azzi310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi310_init()
   #add-point:init段define
 
   #end add-point    
   #add-point:init段define(客製用)
   
   #end add-point    
 
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('gziastus','17','N,Y')
 
      CALL cl_set_combo_scc('gzib006','128') 
   CALL cl_set_combo_scc('gzid005','191') 
   CALL cl_set_combo_scc('gzid010','174') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
  
   
   CALL cl_set_combo_scc('comb_sumy','142')
   CALL azzi310_create_temptable()
   LET g_gzze00=cl_getmsg('azz-00800',g_dlang)
   LET g_gzze01=cl_getmsg('azz-00801',g_dlang)     
   LET g_gzze02=cl_getmsg('azz-00802',g_dlang)
#   LET g_gzze03=cl_getmsg('azz-00803',g_dlang)    #160318-00005#55 mark
   LET g_gzze03=cl_getmsg('asf-00086',g_dlang)     #160318-00005#55 add
#   LET g_gzze04=cl_getmsg('azz-00804',g_dlang)    #160318-00005#55 mark
   LET g_gzze04=cl_getmsg('axc-00376',g_dlang)     #160318-00005#55 add
   LET g_gzze06=cl_getmsg('azz-00924',g_dlang)
   LET g_gzze07=cl_getmsg('azz-00928',g_dlang)
   
   CALL cl_get_para(g_enterprise,g_site,"A-SYS-0054") RETURNING g_max_count  #151016-00016#1 add
   #end add-point
   
   #初始化搜尋條件
   CALL azzi310_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi310.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi310_ui_dialog()
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   #add-point:ui_dialog段define

   #end add-point
   #add-point:ui_dialog段define(客製用)

   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:2)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL azzi310_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzia_m.* TO NULL
         CALL g_gzib_d.clear()
         CALL g_gzib2_d.clear()
         CALL g_gzib3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi310_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
     
         DISPLAY ARRAY g_gzib_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_gzib2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #add-point:page2自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_gzib3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #add-point:page3自定義行為
             #CALL DIALOG.setArrayAttributes("s_detail3", g_detail3_attr) #test-
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為
 
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array
     DISPLAY ARRAY g_grouplist TO s_grouplist.* ATTRIBUTES(COUNT=g_grouplist.getLength())
              BEFORE ROW
               #顯示單身筆數
               CALL azzi310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_grouplist")
               LET g_detail_idx = l_ac

               #add-point:page2, before row動作

               #end add-point

            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_grouplist")
               LET g_current_page = 1
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #add-point:page1自定義行為

               #end add-point

            #自訂ACTION(detail_show,page_1)


            #add-point:page1自定義行為

            #end add-point

      END DISPLAY
      
#       DISPLAY ARRAY g_groupsel TO s_groupsel.* ATTRIBUTES(COUNT=g_groupsel.getLength())
#              BEFORE ROW
#               #顯示單身筆數
#               CALL azzi310_idx_chk()
#               LET l_ac = DIALOG.getCurrentRow("s_groupsel")
#               LET g_detail_idx = l_ac
#
#               #add-point:page1, before row動作
#
#               #end add-point
#
#            BEFORE DISPLAY
#               #如果一直都在單身1則控制筆數位置
#               IF g_loc = 'm' THEN
#                  CALL FGL_SET_ARR_CURR(g_detail_idx)
#               END IF
#               LET g_loc = 'm'
#               LET l_ac = DIALOG.getCurrentRow("s_groupsel")
#               LET g_current_page = 1
#               #顯示單身筆數
#               CALL azzi310_idx_chk()
#               #add-point:page2自定義行為
#
#               #end add-point
#
#            #自訂ACTION(detail_show,page_1)
#
#
#            #add-point:page1自定義行為
#
#            #end add-point
#
#      END DISPLAY
#
      DISPLAY ARRAY g_sumylist1 TO s_sumylist1.* ATTRIBUTES(COUNT=g_sumylist1.getLength())
              BEFORE ROW
               #顯示單身筆數
               CALL azzi310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_sumylist1")
               LET g_detail_idx = l_ac

               #add-point:page2, before row動作

               #end add-point

            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_sumylist1")
               LET g_current_page = 2
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #add-point:page2自定義行為

               #end add-point

            #自訂ACTION(detail_show,page_2)


            #add-point:page2自定義行為

            #end add-point

      END DISPLAY


 DISPLAY ARRAY g_sumylist2 TO s_sumylist2.* ATTRIBUTES(COUNT=g_sumylist2.getLength())
              BEFORE ROW
               #顯示單身筆數
               CALL azzi310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_sumylist2")
               LET g_detail_idx = l_ac

               #add-point:page2, before row動作

               #end add-point

            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_sumylist2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL azzi310_idx_chk()
               #add-point:page2自定義行為

               #end add-point

            #自訂ACTION(detail_show,page_2)


            #add-point:page2自定義行為

            #end add-point

      END DISPLAY

#  DISPLAY ARRAY g_gzielist TO s_gzielist.* ATTRIBUTES(COUNT=g_gzielist.getLength())
#              BEFORE ROW
#               #顯示單身筆數
#               CALL azzi310_idx_chk()
#               LET l_ac = DIALOG.getCurrentRow("s_gzielist")
#               LET g_detail_idx = l_ac
#
#               #add-point:page3, before row動作
#
#               #end add-point
#
#            BEFORE DISPLAY
#               #如果一直都在單身1則控制筆數位置
#               IF g_loc = 'm' THEN
#                  CALL FGL_SET_ARR_CURR(g_detail_idx)
#               END IF
#               LET g_loc = 'm'
#               LET l_ac = DIALOG.getCurrentRow("s_gzielist")
#               LET g_current_page = 3
#               #顯示單身筆數
#               CALL azzi310_idx_chk()
#               #add-point:page2自定義行為
#
#               #end add-point
#
#            #自訂ACTION(detail_show,page_3)
#
#
#            #add-point:page3自定義行為
#
#            #end add-point
#
#      END DISPLAY      
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            #CALL DIALOG.setArrayAttributes("s_detail3", g_detail3_attr) #test-
            CALL azzi310_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL azzi310_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi310_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL azzi310_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2
            CALL g_curr_diag.setActionActive("statechange", FALSE)
            CALL g_curr_diag.setActionActive("queryplansel", FALSE)
            CALL g_curr_diag.setActionActive("qbe_select", FALSE)
            CALL g_curr_diag.setActionActive("exporttoexcel", FALSE)
            CALL g_curr_diag.setActionActive("mainhidden", FALSE)
            CALL g_curr_diag.setActionActive("related_document", FALSE)            
            
            
            CALL g_curr_diag.setActionActive("controls", FALSE)
            
            CALL g_curr_diag.setActionActive("sqlverify", FALSE)       
            CALL g_curr_diag.setActionActive("sqledit", FALSE)
            CALL g_curr_diag.setActionActive("sqlbuilder", FALSE)

            CALL g_curr_diag.setActionActive("groupup", FALSE)       
            CALL g_curr_diag.setActionActive("groupadd", FALSE)       
            CALL g_curr_diag.setActionActive("groupdel", FALSE)       
            CALL g_curr_diag.setActionActive("groupdown", FALSE)       

            CALL g_curr_diag.setActionActive("sumyadd", FALSE)
            CALL g_curr_diag.setActionActive("sumydel", FALSE)

            CALL g_curr_diag.setActionActive("argup", FALSE)
            CALL g_curr_diag.setActionActive("argdown", FALSE)

            CALL g_curr_diag.setActionActive("qbdup", FALSE)
            CALL g_curr_diag.setActionActive("qbedown", FALSE)
            
            CALL g_curr_diag.setActionActive("sqltest", FALSE)
            CALL g_curr_diag.setActionActive("agendum", FALSE)
            CALL g_curr_diag.setActionActive("followup", FALSE)                
            #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL azzi310_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL azzi310_set_act_visible()   
            CALL azzi310_set_act_no_visible()
            IF NOT (g_gzia_m.gzia001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " ",
                                  " gzia001 = '", g_gzia_m.gzia001, "' "
 
               #填到對應位置
               CALL azzi310_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gzia_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzib_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzie_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gzid_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL azzi310_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gzia_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzib_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzie_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gzid_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi310_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi310_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi310_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi310_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi310_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi310_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi310_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi310_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi310_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi310_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi310_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi310_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_gzib_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gzib2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_gzib3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel
#                   LET g_export_node[1] = base.typeInfo.create(g_gzib3_d)
#                   LET g_export_id[1]   = "s_detail3"
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION groupup
#            LET g_action_choice="groupup"
#            IF cl_auth_chk_act("groupup") THEN
               
               #add-point:ON ACTION groupup
               
               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi310_modify()
               #add-point:ON ACTION modify
      
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi310_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION qbdup
#            LET g_action_choice="qbdup"
#            IF cl_auth_chk_act("qbdup") THEN
               
               #add-point:ON ACTION qbdup

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION argup
#            LET g_action_choice="argup"
#            IF cl_auth_chk_act("argup") THEN
               
               #add-point:ON ACTION argup

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION groupadd
#            LET g_action_choice="groupadd"
#            IF cl_auth_chk_act("groupadd") THEN
               
               #add-point:ON ACTION groupadd
                 
               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION groupdown
#            LET g_action_choice="groupdown"
#            IF cl_auth_chk_act("groupdown") THEN
               
               #add-point:ON ACTION groupdown

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi310_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION groupdel
#            LET g_action_choice="groupdel"
#            IF cl_auth_chk_act("groupdel") THEN
               
               #add-point:ON ACTION groupdel
          
               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi310_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
              CALL azzi310_out("V","") #160523-00002#2 增加参数"V","" --传人json参数 --huanyuan
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi310_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION sqlbuilder
#            LET g_action_choice="sqlbuilder"
#            IF cl_auth_chk_act("sqlbuilder") THEN
               
               #add-point:ON ACTION sqlbuilder

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION sumydel
#            LET g_action_choice="sumydel"
#            IF cl_auth_chk_act("sumydel") THEN
               
               #add-point:ON ACTION sumydel

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION argdown
#            LET g_action_choice="argdown"
#            IF cl_auth_chk_act("argdown") THEN
               
               #add-point:ON ACTION argdown

               #END add-point
#               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION qbedown
#            LET g_action_choice="qbedown"
#            IF cl_auth_chk_act("qbedown") THEN
               
               #add-point:ON ACTION qbedown

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi310_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION sqledit
#            LET g_action_choice="sqledit"
#            IF cl_auth_chk_act("sqledit") THEN
               
               #add-point:ON ACTION sqledit

               #END add-point
#               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION sqlverify
#            LET g_action_choice="sqlverify"
#            IF cl_auth_chk_act("sqlverify") THEN
               
               #add-point:ON ACTION sqlverify

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION sumyadd
#            LET g_action_choice="sumyadd"
#            IF cl_auth_chk_act("sumyadd") THEN
               
               #add-point:ON ACTION sumyadd

               #END add-point
               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION sqltest
#            LET g_action_choice="sqltest"
#            IF cl_auth_chk_act("sqltest") THEN
               
               #add-point:ON ACTION sqltest

               #END add-point
               
#            END IF
 
 
 
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL azzi310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi310_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi310_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
        ON ACTION page_gp                #修改程序框架-增
           LET g_current_page=1
           
         ON ACTION page_sumy
           LET g_current_page=2
           
         ON ACTION page_arg
           LET g_current_page=3
           
        ON ACTION page_qbe
           LET g_current_page=4
        
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前

         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="azzi310.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi310_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   
   #end add-point   
   #add-point:browser_fill段define(客製用)
   
   #end add-point   
   
   #add-point:browser_fill段動作開始前
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE gzia001 ",
                      " FROM gzia_t ",
                      " ",
                      " LEFT JOIN gzib_t ON gzia001 = gzib001 ", "  ",
                      #add-point:browser_fill段sql(gzib_t1)
                      
                      #end add-point
                      " LEFT JOIN gzie_t ON gzia001 = gzie001", "  ",
                      #add-point:browser_fill段sql(gzie_t1)
                      
                      #end add-point
 
                      " LEFT JOIN gzid_t ON gzia001 = gzid001", "  ",
                      #add-point:browser_fill段sql(gzid_t1)
                      
                      #end add-point
 
 
 
                      " LEFT JOIN gzial_t ON gzia001 = gzial001 AND gzial002 = '",g_dlang,"' ", 
                      " ", 
                      " WHERE   ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzia_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE gzia001 ",
                      " FROM gzia_t ", 
                      "  ",
                      "  LEFT JOIN gzial_t ON gzia001 = gzial001 AND gzial002 = '",g_dlang,"' ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzia_t")
   END IF
   
   #add-point:browser_fill,cnt wc
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_gzia_m.* TO NULL
      CALL g_gzib_d.clear()        
      CALL g_gzib2_d.clear() 
      CALL g_gzib3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzia001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   LET g_sql = " SELECT DISTINCT t0.gziastus,t0.gzia001 ",
               " FROM gzia_t t0",
               "  ",
               "  LEFT JOIN gzib_t ON gzia001 = gzib001 ", "  ", 
               #add-point:browser_fill段sql(gzib_t1)
               
               #end add-point
               "  LEFT JOIN gzie_t ON gzia001 = gzie001", "  ", 
               #add-point:browser_fill段sql(gzie_t1)
               
               #end add-point
 
               "  LEFT JOIN gzid_t ON gzia001 = gzid001", "  ", 
               #add-point:browser_fill段sql(gzid_t1)
               
               #end add-point
 
 
 
               "  ",
               
               " LEFT JOIN gzial_t ON gzia001 = gzial001 AND gzial002 = '",g_dlang,"' ",
               " WHERE  ",l_wc," AND ",l_wc2, cl_sql_add_filter("gzia_t")
   #add-point:browser_fill,sql wc
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY gzia001 ",g_order
 
   #add-point:browser_fill,before_prepare
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzia_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor
   
   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzia001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:browser_fill段reference
      
      #end add-point
  
  
            #應用 a24 樣板自動產生(Version:2)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_gzia001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi310_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   #add-point:ui_headershow段define(客製用)
   
   #end add-point    
   
   LET g_gzia_m.gzia001 = g_browser[g_current_idx].b_gzia001   
 
   EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003, 
       g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp, 
       g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt, 
       g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp_desc, 
       g_gzia_m.gziamodid_desc
   CALL azzi310_gzia_t_mask()
   CALL azzi310_show()
      
END FUNCTION
 
{</section>}
 
{<section id="azzi310.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi310_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   #add-point:ui_detailshow段define(客製用)
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi310_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   #add-point:ui_browser_refresh段define(客製用)
   
   #end add-point    
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzia001 = g_gzia_m.gzia001 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi310_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define

   #end add-point    
   #add-point:cs段define(客製用)

   #end add-point    
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_gzia_m.* TO NULL
   CALL g_gzib_d.clear()        
   CALL g_gzib2_d.clear() 
   CALL g_gzib3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   
   CALL g_grouplist.clear()
   CALL g_sumylist1.clear()
   CALL g_sumylist2.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzia001,gzia002,gzial003,gzia003,gzia005,gzia004,gzia006,gziastus,gziaownid, 
          gziaowndp,gziacrtid,gziacrtdp,gziacrtdt,gziamodid,gziamoddt,groupname,sumyname1,comb_sumy, 
          s_global_var
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
               CALL cl_show_fld_cont()
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:2)
         #共用欄位查詢處理  
         ##----<<gziacrtdt>>----
         AFTER FIELD gziacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gziamoddt>>----
         AFTER FIELD gziamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gziacnfdt>>----
         
         #----<<gziapstdt>>----
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.gzia001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia001
            #add-point:ON ACTION controlp INFIELD gzia001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzia001  #顯示到畫面上
            NEXT FIELD gzia001                     #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia001
            #add-point:BEFORE FIELD gzia001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia001
            
            #add-point:AFTER FIELD gzia001

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia002
            #add-point:BEFORE FIELD gzia002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia002
            
            #add-point:AFTER FIELD gzia002

            #END add-point
            
 
         #Ctrlp:construct.c.gzia002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia002
            #add-point:ON ACTION controlp INFIELD gzia002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzial003
            #add-point:BEFORE FIELD gzial003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzial003
            
            #add-point:AFTER FIELD gzial003

            #END add-point
            
 
         #Ctrlp:construct.c.gzial003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzial003
            #add-point:ON ACTION controlp INFIELD gzial003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia003
            #add-point:BEFORE FIELD gzia003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia003
            
            #add-point:AFTER FIELD gzia003

            #END add-point
            
 
         #Ctrlp:construct.c.gzia003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia003
            #add-point:ON ACTION controlp INFIELD gzia003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia005
            #add-point:BEFORE FIELD gzia005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia005
            
            #add-point:AFTER FIELD gzia005
 
            #END add-point
            
 
         #Ctrlp:construct.c.gzia005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia005
            #add-point:ON ACTION controlp INFIELD gzia005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia004
            #add-point:BEFORE FIELD gzia004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia004
            
            #add-point:AFTER FIELD gzia004

            #END add-point
            
 
         #Ctrlp:construct.c.gzia004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia004
            #add-point:ON ACTION controlp INFIELD gzia004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia006
            #add-point:BEFORE FIELD gzia006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia006
            
            #add-point:AFTER FIELD gzia006

            #END add-point
            
 
         #Ctrlp:construct.c.gzia006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia006
            #add-point:ON ACTION controlp INFIELD gzia006

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziastus
            #add-point:BEFORE FIELD gziastus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziastus
            
            #add-point:AFTER FIELD gziastus

            #END add-point
            
 
         #Ctrlp:construct.c.gziastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziastus
            #add-point:ON ACTION controlp INFIELD gziastus

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziaownid
            #add-point:BEFORE FIELD gziaownid

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziaownid
            
            #add-point:AFTER FIELD gziaownid

            #END add-point
            
 
         #Ctrlp:construct.c.gziaownid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziaownid
            #add-point:ON ACTION controlp INFIELD gziaownid

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziaowndp
            #add-point:BEFORE FIELD gziaowndp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziaowndp
            
            #add-point:AFTER FIELD gziaowndp

            #END add-point
            
 
         #Ctrlp:construct.c.gziaowndp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziaowndp
            #add-point:ON ACTION controlp INFIELD gziaowndp

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziacrtid
            #add-point:BEFORE FIELD gziacrtid

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziacrtid
            
            #add-point:AFTER FIELD gziacrtid

            #END add-point
            
 
         #Ctrlp:construct.c.gziacrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziacrtid
            #add-point:ON ACTION controlp INFIELD gziacrtid

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziacrtdp
            #add-point:BEFORE FIELD gziacrtdp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziacrtdp
            
            #add-point:AFTER FIELD gziacrtdp

            #END add-point
            
 
         #Ctrlp:construct.c.gziacrtdp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziacrtdp
            #add-point:ON ACTION controlp INFIELD gziacrtdp

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziacrtdt
            #add-point:BEFORE FIELD gziacrtdt

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziamodid
            #add-point:BEFORE FIELD gziamodid

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziamodid
            
            #add-point:AFTER FIELD gziamodid

            #END add-point
            
 
         #Ctrlp:construct.c.gziamodid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziamodid
            #add-point:ON ACTION controlp INFIELD gziamodid

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziamoddt
            #add-point:BEFORE FIELD gziamoddt

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD groupname
            #add-point:BEFORE FIELD groupname

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD groupname
            
            #add-point:AFTER FIELD groupname

            #END add-point
            
 
         #Ctrlp:construct.c.groupname
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD groupname
            #add-point:ON ACTION controlp INFIELD groupname

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sumyname1
            #add-point:BEFORE FIELD sumyname1

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sumyname1
            
            #add-point:AFTER FIELD sumyname1

            #END add-point
            
 
         #Ctrlp:construct.c.sumyname1
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sumyname1
            #add-point:ON ACTION controlp INFIELD sumyname1

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD comb_sumy
            #add-point:BEFORE FIELD comb_sumy

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD comb_sumy
            
            #add-point:AFTER FIELD comb_sumy

            #END add-point
            
 
         #Ctrlp:construct.c.comb_sumy
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD comb_sumy
            #add-point:ON ACTION controlp INFIELD comb_sumy

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD s_global_var
            #add-point:BEFORE FIELD s_global_var

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD s_global_var
            
            #add-point:AFTER FIELD s_global_var

            #END add-point
            
 
         #Ctrlp:construct.c.s_global_var
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD s_global_var
            #add-point:ON ACTION controlp INFIELD s_global_var

            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
#      CONSTRUCT g_wc2_table1 ON gzib002,gzib003,gzib005,gzib006,gzib004
#           FROM s_detail1[1].gzib002,s_detail1[1].gzib003,s_detail1[1].gzib005,s_detail1[1].gzib006, 
#               s_detail1[1].gzib004
                      
#         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzib002
            #add-point:BEFORE FIELD gzib002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzib002
            
            #add-point:AFTER FIELD gzib002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzib002
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzib002
            #add-point:ON ACTION controlp INFIELD gzib002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzib003
            #add-point:BEFORE FIELD gzib003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzib003
            
            #add-point:AFTER FIELD gzib003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzib003
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzib003
            #add-point:ON ACTION controlp INFIELD gzib003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzib005
            #add-point:BEFORE FIELD gzib005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzib005
            
            #add-point:AFTER FIELD gzib005

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzib005
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzib005
            #add-point:ON ACTION controlp INFIELD gzib005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzib006
            #add-point:BEFORE FIELD gzib006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzib006
            
            #add-point:AFTER FIELD gzib006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzib006
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzib006
            #add-point:ON ACTION controlp INFIELD gzib006

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzib004
            #add-point:BEFORE FIELD gzib004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzib004
            
            #add-point:AFTER FIELD gzib004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzib004
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzib004
            #add-point:ON ACTION controlp INFIELD gzib004

            #END add-point
 
   
       
#      END CONSTRUCT
      
#      CONSTRUCT g_wc2_table2 ON gzie002,gzie003,gzie005
#           FROM s_detail2[1].gzie002,s_detail2[1].gzie003,s_detail2[1].gzie005
                      
#         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzie002
            #add-point:BEFORE FIELD gzie002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzie002
            
            #add-point:AFTER FIELD gzie002

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzie002
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzie002
            #add-point:ON ACTION controlp INFIELD gzie002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzie003
            #add-point:BEFORE FIELD gzie003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzie003
            
            #add-point:AFTER FIELD gzie003

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzie003
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzie003
            #add-point:ON ACTION controlp INFIELD gzie003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzie005
            #add-point:BEFORE FIELD gzie005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzie005
            
            #add-point:AFTER FIELD gzie005

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzie005
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzie005
            #add-point:ON ACTION controlp INFIELD gzie005

            #END add-point
 
   
       
#      END CONSTRUCT
 
#      CONSTRUCT g_wc2_table3 ON gzid002,gzid003,gzid004,gzid005,gzid006,gzid007,gzid008,gzid009,gzid010, 
#          gzid011,gzid012
#           FROM s_detail3[1].gzid002,s_detail3[1].gzid003,s_detail3[1].gzid004,s_detail3[1].gzid005, 
#               s_detail3[1].gzid006,s_detail3[1].gzid007,s_detail3[1].gzid008,s_detail3[1].gzid009,s_detail3[1].gzid010, 
#               s_detail3[1].gzid011,s_detail3[1].gzid012
#                      
#         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid002
            #add-point:BEFORE FIELD gzid002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid002
            
            #add-point:AFTER FIELD gzid002

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid002
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid002
            #add-point:ON ACTION controlp INFIELD gzid002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid003
            #add-point:BEFORE FIELD gzid003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid003
            
            #add-point:AFTER FIELD gzid003

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid003
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid003
            #add-point:ON ACTION controlp INFIELD gzid003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid004
            #add-point:BEFORE FIELD gzid004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid004
            
            #add-point:AFTER FIELD gzid004

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid004
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid004
            #add-point:ON ACTION controlp INFIELD gzid004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid005
            #add-point:BEFORE FIELD gzid005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid005
            
            #add-point:AFTER FIELD gzid005

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid005
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid005
            #add-point:ON ACTION controlp INFIELD gzid005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid006
            #add-point:BEFORE FIELD gzid006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid006
            
            #add-point:AFTER FIELD gzid006

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid006
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid006
            #add-point:ON ACTION controlp INFIELD gzid006

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid007
            #add-point:BEFORE FIELD gzid007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid007
            
            #add-point:AFTER FIELD gzid007

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid007
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid007
            #add-point:ON ACTION controlp INFIELD gzid007

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid008
            #add-point:BEFORE FIELD gzid008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid008
            
            #add-point:AFTER FIELD gzid008

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid008
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid008
            #add-point:ON ACTION controlp INFIELD gzid008

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid009
            #add-point:BEFORE FIELD gzid009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid009
            
            #add-point:AFTER FIELD gzid009

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid009
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid009
            #add-point:ON ACTION controlp INFIELD gzid009

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid010
            #add-point:BEFORE FIELD gzid010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid010
            
            #add-point:AFTER FIELD gzid010

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid010
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid010
            #add-point:ON ACTION controlp INFIELD gzid010

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid011
            #add-point:BEFORE FIELD gzid011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid011
            
            #add-point:AFTER FIELD gzid011

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid011
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid011
            #add-point:ON ACTION controlp INFIELD gzid011

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
#         BEFORE FIELD gzid012
            #add-point:BEFORE FIELD gzid012

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
#         AFTER FIELD gzid012
            
            #add-point:AFTER FIELD gzid012

            #END add-point
            
 
         #Ctrlp:construct.c.page3.gzid012
         #應用 a03 樣板自動產生(Version:2)
#         ON ACTION controlp INFIELD gzid012
            #add-point:ON ACTION controlp INFIELD gzid012

            #END add-point
 
   
       
#      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)

      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "gzia_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gzib_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gzie_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "gzid_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前

   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi310_query()
   DEFINE ls_wc STRING
   #add-point:query段define

   #end add-point   
   #add-point:query段define(客製用)

   #end add-point   
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_gzib_d.clear()
   CALL g_gzib2_d.clear()
   CALL g_gzib3_d.clear()
 
   
   #add-point:query段other
  
   CALL g_grouplist.clear()
   CALL g_sumylist1.clear()
   CALL g_sumylist2.clear()
   CALL g_tab.clear() 
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL azzi310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi310_browser_fill("")
      CALL azzi310_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   #CALL FGL_SET_ARR_CURR(1)   #导致不停查询宕掉
   CALL azzi310_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL azzi310_fetch("F") 
      #顯示單身筆數
      CALL azzi310_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi310_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point    
   #add-point:fetch段define(客製用)

   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            #CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_gzia_m.gzia001 = g_browser[g_current_idx].b_gzia001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003, 
       g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp, 
       g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt, 
       g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp_desc, 
       g_gzia_m.gziamodid_desc
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi310_set_act_visible()   
   CALL azzi310_set_act_no_visible()
   
   #add-point:fetch段action控制

   #end add-point  
   
   
   
   #add-point:fetch結束前

   #end add-point
   
   #保存單頭舊值
   LET g_gzia_m_t.* = g_gzia_m.*
   LET g_gzia_m_o.* = g_gzia_m.*
   
   LET g_data_owner = g_gzia_m.gziaownid      
   LET g_data_dept  = g_gzia_m.gziaowndp
   
   #重新顯示
   CALL azzi310_default()   
   CALL azzi310_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi310_insert()
   #add-point:insert段define

   #end add-point    
   #add-point:insert段define(客製用)

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gzib_d.clear()   
   CALL g_gzib2_d.clear()  
   CALL g_gzib3_d.clear()  
 
 
   INITIALIZE g_gzia_m.* LIKE gzia_t.*             #DEFAULT 設定
   
   LET g_gzia001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before

   CALL g_grouplist.clear()
   CALL g_sumylist1.clear()
   CALL g_sumylist2.clear()
   CALL g_tab.clear()
   LET g_tab_cnt=0
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_gzia_m.gziaownid = g_user
      LET g_gzia_m.gziaowndp = g_dept
      LET g_gzia_m.gziacrtid = g_user
      LET g_gzia_m.gziacrtdp = g_dept 
      LET g_gzia_m.gziacrtdt = cl_get_current()
      LET g_gzia_m.gziamodid = g_user
      LET g_gzia_m.gziamoddt = cl_get_current()
      LET g_gzia_m.gziastus = 'Y'
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值
      LET g_gzia_m.gzia002='N'
      LET g_gzia_m.gzia003='s'         #151116-00008#1 mod 'N'->'s'
      LET g_gzia_m.gzia004='N'
      LET g_gzia_m.gzia005=1000
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gzia_m_t.* = g_gzia_m.*
      LET g_gzia_m_o.* = g_gzia_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzia_m.gziastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
    
      CALL azzi310_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gzia_m.* TO NULL
         INITIALIZE g_gzib_d TO NULL
         INITIALIZE g_gzib2_d TO NULL
         INITIALIZE g_gzib3_d TO NULL
 
         #add-point:取消新增後
          INITIALIZE g_tab TO NULL
         #end add-point 
         CALL azzi310_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gzib_d.clear()
      #CALL g_gzib2_d.clear()
      #CALL g_gzib3_d.clear()
 
 
      LET g_rec_b = 0
      CALL azzi310_save()
      CALL s_transaction_end('Y','0')
      IF NOT INT_FLAG AND g_upd_flag='Y' THEN
          CALL azzi310_gen_include_4gl()
          LET g_upd_flag='Y'
       END IF
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi310_set_act_visible()   
   CALL azzi310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzia001 = '", g_gzia_m.gzia001, "' "
 
                      
   #add-point:組合新增資料的條件後

   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE azzi310_cl
   
   CALL azzi310_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003, 
       g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp, 
       g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt, 
       g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp_desc, 
       g_gzia_m.gziamodid_desc
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
       g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaownid_desc, 
       g_gzia_m.gziaowndp,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp, 
       g_gzia_m.gziacrtdp_desc,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamodid_desc,g_gzia_m.gziamoddt, 
       g_gzia_m.groupname,g_gzia_m.sumyname1,g_gzia_m.comb_sumy,g_gzia_m.s_global_var
   
   #add-point:新增結束後
   
   #end add-point 
   
   #功能已完成,通報訊息中心
   CALL azzi310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi310_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define

   #end add-point    
   #add-point:modify段define(客製用)

   #end add-point    
   
   #保存單頭舊值
   LET g_gzia_m_t.* = g_gzia_m.*
   LET g_gzia_m_o.* = g_gzia_m.*
   
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gzia001_t = g_gzia_m.gzia001
 
   CALL s_transaction_begin()
   
   OPEN azzi310_cl USING g_gzia_m.gzia001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003, 
       g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp, 
       g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt, 
       g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp_desc, 
       g_gzia_m.gziamodid_desc
   
   #檢查是否允許此動作
   IF NOT azzi310_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   
   
   #add-point:modify段show之前

   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL azzi310_show()
   #add-point:modify段show之後

   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_gzia001_t = g_gzia_m.gzia001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gzia_m.gziamodid = g_user 
LET g_gzia_m.gziamoddt = cl_get_current()
LET g_gzia_m.gziamodid_desc = cl_get_username(g_gzia_m.gziamodid)
      
      #add-point:modify段修改前

      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      CALL azzi310_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後

      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gzia_t SET (gziamodid,gziamoddt) = (g_gzia_m.gziamodid,g_gzia_m.gziamoddt)
          WHERE  gzia001 = g_gzia001_t
          
         CALL azzi310_save()
      END IF
    
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzia_m.* = g_gzia_m_t.*
         CALL azzi310_default() #修改程序框架
         CALL azzi310_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gzia_m.gzia001 != g_gzia001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前

         #end add-point
         
         #更新單身key值
         UPDATE gzib_t SET gzib001 = g_gzia_m.gzia001
 
          WHERE  gzib001 = g_gzia001_t
 
            
         #add-point:單身fk修改中

         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzib_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzib_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後

         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前

         #end add-point
         
         UPDATE gzie_t
            SET gzie001 = g_gzia_m.gzia001
 
          WHERE 
                gzie001 = g_gzia001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzie_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzie_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後

         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前

         #end add-point
         
         UPDATE gzid_t
            SET gzid001 = g_gzia_m.gzia001
 
          WHERE 
                gzid001 = g_gzia001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzid_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzid_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後

         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
 
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi310_set_act_visible()   
   CALL azzi310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzia001 = '", g_gzia_m.gzia001, "' "
 
   #填到對應位置
   CALL azzi310_browser_fill("")
 
   CLOSE azzi310_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi310_msgcentre_notify('modify')
 
END FUNCTION   
 
{</section>}
 
{<section id="azzi310.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi310_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define
   DEFINE lc_cmd       STRING
   DEFINE dnd          ui.DragDrop
   DEFINE ls_area      STRING   #DRAGANDDROP起動區塊(用來判斷不能丟入非法區塊)
   DEFINE ls_str       STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_start     LIKE type_t.num5
   DEFINE li_end       LIKE type_t.num5
   DEFINE ls_sql       STRING
   DEFINE li_linesize  LIKE type_t.num5
   DEFINE li_pagesize  LIKE type_t.num5
   DEFINE ls_filename  STRING
   DEFINE li_rowcount  LIKE type_t.num5
   DEFINE ls_result    STRING
   DEFINE l_seq        LIKE type_t.num5
   DEFINE lc_type2           DYNAMIC ARRAY OF RECORD
            gzib001          LIKE gzib_t.gzib001,
            id2              LIKE type_t.chr20,
            pid2             LIKE type_t.chr20,
            idseq2           LIKE type_t.num5,         #欄位順序
            pidseq2          LIKE type_t.num5,         #區塊順序
            pidtype2         LIKE type_t.chr1         #單頭/單身
            END RECORD
   DEFINE l_paging_cnt LIKE type_t.num5               ##140606 add   
   DEFINE ls_err_msg         STRING                   ##140612 add
   DEFINE lc_gztd012         STRING
   DEFINE l_gztd012          LIKE gztd_t.gztd012
   DEFINE l_arg              LIKE type_t.num5         #140804 add
   DEFINE ls_sql1            STRING                   #1050126 add
   DEFINE l_sql              STRING
   
   #160926-00005#1 .3 add(s)
   DEFINE l_in_row           LIKE type_t.chr1
   DEFINE l_change_row       LIKE type_t.chr1
   #160926-00005#1 .3 add(e)
   #end add-point  
   #add-point:input段define(客製用)

   #end add-point  
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
       g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaownid_desc, 
       g_gzia_m.gziaowndp,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp, 
       g_gzia_m.gziacrtdp_desc,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamodid_desc,g_gzia_m.gziamoddt, 
       g_gzia_m.groupname,g_gzia_m.sumyname1,g_gzia_m.comb_sumy,g_gzia_m.s_global_var
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
  
   #end add-point 
   LET g_forupd_sql = "SELECT gzib002,gzib003,gzib005,gzib006,gzib004 FROM gzib_t WHERE gzib001=? AND  
       gzib002=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi310_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT gzie002,gzie003,gzie005 FROM gzie_t WHERE gzie001=? AND gzie002=? FOR  
       UPDATE"
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi310_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql

   #end add-point  
   #160901-00030#1mod add->gzid017   
   #161121-00024#1mod add->gzid018
   LET g_forupd_sql = "SELECT gzid002,gzid003,gzid004,gzid005,gzid006,gzid007,gzid018,NVL(gzid008,'N'),gzid009,gzid010, 
       gzid011,NVL(gzid012,'N'),NVL(gzid014,'N'),gzid015,gzid017 FROM gzid_t WHERE gzid001=? AND gzid002=? FOR UPDATE"  #160523-00002#2 add gzid014,gzid015 160901-00030#1 add gzid017
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi310_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql

   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi310_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL azzi310_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
       g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.groupname,g_gzia_m.sumyname1,g_gzia_m.comb_sumy 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前
       LET l_allow_insert=false
       LET l_allow_delete=true
       LET g_upd_flag='N'
       CALL cl_show_fld_cont()
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi310.input.head" >}
      #單頭段
#      INPUT BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
#          g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.groupname,g_gzia_m.sumyname1, 
#          g_gzia_m.comb_sumy 
       
      INPUT BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
          g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus
         
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF  NOT cl_null(g_gzia_m.gzia001) THEN 
                  CALL n_gzial(g_gzia_m.gzia001) 
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_gzia_m.gzia001
                  CALL ap_ref_array2(g_ref_fields," SELECT gzial003 FROM gzial_t WHERE gzial001 = ? AND gzial002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_gzia_m.gzial003 = g_rtn_fields[1]          
                  DISPLAY BY NAME g_gzia_m.gzial003
               END IF  
               #END add-point
            END IF
 
        ON ACTION sqledit                       #修改程序框架-添加
        #160926-00005#1 add(s)
           IF  p_cmd ='a' AND NOT cl_null(g_gzia_m.gzia001) THEN  
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzia_t WHERE "||"gzia001 = '"||g_gzia_m.gzia001 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
              END IF                  
           END IF
         #160926-00005#1 add(e)
           IF g_gzia_m.gzia005 <1 OR g_gzia_m.gzia005 >g_max_count THEN     #151016-00016#1 mod 5000->g_max_count
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'azz-00923'
              LET g_errparam.extend =''
              LET g_errparam.replace[1]=g_max_count
              LET g_errparam.popup = false
              CALL cl_err()
              NEXT FIELD gzia005
            END IF
           LET g_gzia006_t=g_gzia_m.gzia006
           LET g_action_choice="sqledit"
            IF cl_auth_chk_act("sqledit") THEN              
               CALL azzi310_set_entry(p_cmd)   
               NEXT FIELD gzia006
            END IF
 
         ON ACTION sqlverify
          #IF g_gzia_m.gzia006 != g_gzia_m_t.gzia006 OR g_gzia_m_t.gzia006 IS NULL THEN
            #161122-00035#1 add(s)
            IF p_cmd="a" AND g_action_choice="sqlverify" THEN
               LET g_parse_flag="u"
            END IF
            #161122-00035#1 add(e)
            
            LET g_action_choice="sqlverify"
            
            IF cl_auth_chk_act("sqlverify") THEN                           
               IF NOT azzi310_sqlverify(g_gzia_m.gzia006) THEN
                   LET g_chk_sql="N"
                   NEXT FIELD gzia006
               END IF
               LET g_chk_sql="Y"
               
               LET g_gzia006_t=g_gzia_m.gzia006
               CALL azzi310_parse_sqltable(p_cmd)
               CALL azzi310_parse_sql(p_cmd)
               IF p_cmd="a" THEN #160822-00021#1 mod
                  CALL azzi310_sumy2_default()
               END IF
               CASE g_current_page
                    WHEN 1  
                      CALL azzi310_grouplist_b_fill()
                      CALL azzi310_gziblist_b_fill()                    
                     WHEN 2
                       CALL azzi310_sumy1_b_fill()
                       CALL azzi310_sumy2_b_fill()
                     WHEN 3
                       CALL azzi310_gzielist_b_fill()
                     WHEN 4
                       CALL azzi310_gzidlist_b_fill() 
               END CASE   
              DISPLAY BY NAME g_gzia_m.gzia006               
            END IF
        # END IF
            
         ON ACTION sqlbuilder
          IF g_gzia_m.gzia005 <1 OR g_gzia_m.gzia005 >g_max_count THEN     #151016-00016#1 mod 5000->g_max_count
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'azz-00923'
              LET g_errparam.extend =''
              LET g_errparam.replace[1]=g_max_count
              LET g_errparam.popup = false
              CALL cl_err()
              NEXT FIELD gzia005
            END IF           
           LET g_gzia006_t=g_gzia_m.gzia006
            LET g_action_choice="sqlbuilder"
            IF cl_auth_chk_act("sqlbuilder") THEN  
               CALL sadzp190_rtn(g_prog) returning g_textedit1               
#               CALL azzi310_sqlbuilder()  
                IF NOT cl_null(g_textedit1) THEN
                   LET g_gzia_m.gzia006=g_textedit1
                END IF                   
            END IF
     
     
         BEFORE INPUT
            LET g_parse_flag="a" #161122-00035#1 add
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN azzi310_cl USING g_gzia_m.gzia001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi310_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE azzi310_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_gzia006_t=g_gzia_m.gzia006
            LET g_master_multi_table_t.gzial001 = g_gzia_m.gzia001
           LET g_master_multi_table_t.gzial003 = g_gzia_m.gzial003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.gzial001 = ''
               LET g_master_multi_table_t.gzial003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL azzi310_set_entry(p_cmd)
            #add-point:資料輸入前

            #end add-point
            CALL azzi310_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia001
            #add-point:BEFORE FIELD gzia001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia001
            
            #add-point:AFTER FIELD gzia001
          IF  NOT cl_null(g_gzia_m.gzia001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzia_m.gzia001 != g_gzia001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzia_t WHERE "||"gzia001 = '"||g_gzia_m.gzia001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia001
            #add-point:ON CHANGE gzia001

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia002
            #add-point:BEFORE FIELD gzia002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia002
            
            #add-point:AFTER FIELD gzia002

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia002
            #add-point:ON CHANGE gzia002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzial003
            #add-point:BEFORE FIELD gzial003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzial003
            
            #add-point:AFTER FIELD gzial003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzial003
            #add-point:ON CHANGE gzial003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia003
            #add-point:BEFORE FIELD gzia003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia003
            
            #add-point:AFTER FIELD gzia003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia003
            #add-point:ON CHANGE gzia003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia005
            #add-point:BEFORE FIELD gzia005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia005
            
            #add-point:AFTER FIELD gzia005
            IF g_gzia_m.gzia005 <1 OR g_gzia_m.gzia005 >g_max_count THEN    #151016-00016#1 mod 5000->g_max_count
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'azz-00923'
              LET g_errparam.extend =''
              LET g_errparam.replace[1]=g_max_count
              LET g_errparam.popup = false
              CALL cl_err()
              NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia005
            #add-point:ON CHANGE gzia005
            IF g_gzia_m.gzia005 <1 OR g_gzia_m.gzia005 >g_max_count THEN         #151016-00016#1 mod 5000->g_max_count
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'azz-00923'
              LET g_errparam.extend =''
              LET g_errparam.replace[1]=g_max_count
              LET g_errparam.popup = false
              CALL cl_err()
              NEXT FIELD CURRENT
            END IF
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia004
            #add-point:BEFORE FIELD gzia004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia004
            
            #add-point:AFTER FIELD gzia004

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia004
            #add-point:ON CHANGE gzia004

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia006
            #add-point:BEFORE FIELD gzia006
            IF cl_null(g_gzia_m.gzia001) THEN
               NEXT FIELD gzia001
            END IF
            LET g_gzia006_t=g_gzia_m.gzia006            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia006
            
            #add-point:AFTER FIELD gzia006
         #  IF g_action_choice !="sqlverify" AND (g_gzia_m.gzia006 != g_gzia_m_t.gzia006 OR g_gzia_m_t.gzia006 is NULL) 
            IF g_action_choice !="sqlverify" AND (g_gzia_m.gzia006 !=g_gzia006_t OR g_gzia006_t is NULL) 
           THEN
              INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend = "" 
              LET g_errparam.code   = "azz-00920" 
              LET g_errparam.popup  = FALSE
              CALL cl_err()
              NEXT FIELD CURRENT 
           END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia006
            #add-point:ON CHANGE gzia006

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gziastus
            #add-point:BEFORE FIELD gziastus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gziastus
            
            #add-point:AFTER FIELD gziastus
            IF cl_null(g_gzia_m.gzia006) THEN
                NEXT FIELD CURRENT
            END IF 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gziastus
            #add-point:ON CHANGE gziastus

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD groupname
            #add-point:BEFORE FIELD groupname

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD groupname
            
            #add-point:AFTER FIELD groupname

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE groupname
            #add-point:ON CHANGE groupname

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sumyname1
            #add-point:BEFORE FIELD sumyname1

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sumyname1
            
            #add-point:AFTER FIELD sumyname1

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE sumyname1
            #add-point:ON CHANGE sumyname1

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD comb_sumy
            #add-point:BEFORE FIELD comb_sumy

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD comb_sumy
            
            #add-point:AFTER FIELD comb_sumy

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE comb_sumy
            #add-point:ON CHANGE comb_sumy

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.gzia001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia001
            #add-point:ON ACTION controlp INFIELD gzia001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzia_m.gzia001
            CALL q_gzza001_5()                                #呼叫開窗

            LET g_gzia_m.gzia001 = g_qryparam.return1              

            #DISPLAY g_gzia_m.gzia001 TO gzia001              #

            NEXT FIELD gzia001                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.gzia002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia002
            #add-point:ON ACTION controlp INFIELD gzia002

            #END add-point
 
         #Ctrlp:input.c.gzial003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzial003
            #add-point:ON ACTION controlp INFIELD gzial003

            #END add-point
 
         #Ctrlp:input.c.gzia003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia003
            #add-point:ON ACTION controlp INFIELD gzia003

            #END add-point
 
         #Ctrlp:input.c.gzia005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia005
            #add-point:ON ACTION controlp INFIELD gzia005

            #END add-point
 
         #Ctrlp:input.c.gzia004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia004
            #add-point:ON ACTION controlp INFIELD gzia004

            #END add-point
 
         #Ctrlp:input.c.gzia006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia006
            #add-point:ON ACTION controlp INFIELD gzia006

            #END add-point
 
         #Ctrlp:input.c.gziastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gziastus
            #add-point:ON ACTION controlp INFIELD gziastus

            #END add-point
 
         #Ctrlp:input.c.groupname
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD groupname
            #add-point:ON ACTION controlp INFIELD groupname

            #END add-point
 
         #Ctrlp:input.c.sumyname1
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sumyname1
            #add-point:ON ACTION controlp INFIELD sumyname1

            #END add-point
 
         #Ctrlp:input.c.comb_sumy
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD comb_sumy
            #add-point:ON ACTION controlp INFIELD comb_sumy

            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gzia_m.gzia001
                        
            #add-point:單頭INPUT後
            IF g_gzia_m.gzia005 <1 OR g_gzia_m.gzia005 >g_max_count THEN            #151016-00016#1 mod 5000->g_max_count
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'azz-00923'
              LET g_errparam.extend =''
              LET g_errparam.replace[1]=g_max_count
              LET g_errparam.popup = false
              CALL cl_err()
              NEXT FIELD gzia005
            END IF
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
                IF g_gzia_m.gzia003 is NULL THEN
                   LET g_gzia_m.gzia003='N'
                END IF
               #end add-point
               
               INSERT INTO gzia_t (gzia001,gzia002,gzia003,gzia005,gzia004,gzia006,gziastus,gziaownid, 
                   gziaowndp,gziacrtid,gziacrtdp,gziacrtdt,gziamodid,gziamoddt)
               VALUES (g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003,g_gzia_m.gzia005,g_gzia_m.gzia004, 
                   g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp,g_gzia_m.gziacrtid, 
                   g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gzia_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中

               #end add-point
               
               
         INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gzia_m.gzia001 = g_master_multi_table_t.gzial001 AND
         g_gzia_m.gzial003 = g_master_multi_table_t.gzial003  THEN
         ELSE 
            LET l_var_keys[01] = g_gzia_m.gzia001
            LET l_field_keys[01] = 'gzial001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzial001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzial002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzia_m.gzial003
            LET l_fields[01] = 'gzial003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzial_t')
         END IF 
 
               
               #add-point:單頭新增後

               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi310_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL azzi310_b_fill()
                  CALL azzi310_b_fill2('0')
               END IF
               
               #add-point:單頭新增後

               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
                IF g_gzia_m.gzia003 is NULL THEN
                   LET g_gzia_m.gzia003='N'
                END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi310_gzia_t_mask_restore('restore_mask_o')
               
               UPDATE gzia_t SET (gzia001,gzia002,gzia003,gzia005,gzia004,gzia006,gziastus,gziaownid, 
                   gziaowndp,gziacrtid,gziacrtdp,gziacrtdt,gziamodid,gziamoddt) = (g_gzia_m.gzia001, 
                   g_gzia_m.gzia002,g_gzia_m.gzia003,g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006, 
                   g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp,g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp, 
                   g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt)
                WHERE  gzia001 = g_gzia001_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzia_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中

               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gzia_m.gzia001 = g_master_multi_table_t.gzial001 AND
         g_gzia_m.gzial003 = g_master_multi_table_t.gzial003  THEN
         ELSE 
            LET l_var_keys[01] = g_gzia_m.gzia001
            LET l_field_keys[01] = 'gzial001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzial001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzial002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzia_m.gzial003
            LET l_fields[01] = 'gzial003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzial_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL azzi310_gzia_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gzia_m_t)
               LET g_log2 = util.JSON.stringify(g_gzia_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後

               #end add-point
            END IF
            
            LET g_gzia001_t = g_gzia_m.gzia001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="azzi310.input.body" >}
      #Page1左边树结构--修改框架加
     DISPLAY ARRAY g_grouplist TO s_grouplist.* ATTRIBUTES(COUNT=g_grouplist.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_grouplist", 1)
            CALL azzi310_set_action_active_by_datasize("s_grouplist", "groupadd")
         BEFORE ROW
            LET g_grouplist_idx = DIALOG.getCurrentRow("s_grouplist")
            #是Table的話, 不給多選
            IF g_grouplist[g_grouplist_idx].groupisnode THEN
               CALL DIALOG.setSelectionMode("s_grouplist", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_grouplist", 1)
            END IF
         #功能鍵方式增加
         ON ACTION groupadd
            CALL azzi310_maintain_gzib(g_grouplist_idx, "add")
      END DISPLAY 
      
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzib_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
          ON ACTION groupdel
           CALL azzi310_maintain_gzib(g_gzib_d_idx, "del")
           #若刪除最後一筆, 則需手動讓指標跳到正確位置
           IF g_gzib_d_idx > g_gzib_d.getLength() THEN
              CALL DIALOG.setCurrentRow("s_detail1", g_gzib_d.getLength())
              LET g_gzib_d_idx = DIALOG.getCurrentRow("s_detail1")
              LET l_ac = ARR_CURR()
           END IF
               CALL azzi310_set_seqaction_active("s_detail1", "up_groupseq", "down_groupseq",g_gzib_d[g_gzib_d_idx].gzib003) #160926-00005#1 .3mod,增加第四个参数
               CALL azzi310_set_action_active_by_datasize("s_detail1", "del_group")
     
           
         ON ACTION groupup
             CALL azzi310_move_up_down("s_detail1", "up")
             LET g_gzib_d_idx = DIALOG.getCurrentRow("s_detail1")
             LET l_ac = ARR_CURR()
           
          ON ACTION groupdown
             CALL azzi310_move_up_down("s_detail1", "down")
             LET g_gzib_d_idx = DIALOG.getCurrentRow("s_detail1")
             LET l_ac = ARR_CURR()
         
         BEFORE INPUT
            #add-point:資料輸入前
            CALL azzi310_set_seqaction_active("s_detail1", "groupup", "groupdown",'')
            CALL azzi310_set_action_active_by_datasize("s_detail1", "groupdel")
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzib_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gzib_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2
            #LET g_gzib_d_idx = DIALOG.getCurrentRow("s_detail1")
            LET g_gzib_d_idx = ARR_CURR()
            CALL azzi310_set_seqaction_active("s_detail1", "groupup", "groupdown",g_gzib_d[g_gzib_d_idx].gzib003) #160926-00005#1 .3mod,增加第四个参数
            CALL azzi310_set_action_active_by_datasize("s_detail1", "groupdel")
            #LET g_gzib_d_t.*=g_gzib_d[g_gzib_d_idx].*
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN azzi310_cl USING g_gzia_m.gzia001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi310_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE azzi310_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_gzib_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzib_d[l_ac].gzib002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzib_d_t.* = g_gzib_d[l_ac].*  #BACKUP
               LET g_gzib_d_o.* = g_gzib_d[l_ac].*  #BACKUP
               CALL azzi310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL azzi310_set_no_entry_b(l_cmd)
               IF NOT azzi310_lock_b("gzib_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi310_bcl INTO g_gzib_d[l_ac].gzib002,g_gzib_d[l_ac].gzib003,g_gzib_d[l_ac].gzib005, 
                      g_gzib_d[l_ac].gzib006,g_gzib_d[l_ac].gzib004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzib_d_t.gzib002 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzib_d_mask_o[l_ac].* =  g_gzib_d[l_ac].*
                  CALL azzi310_gzib_t_mask()
                  LET g_gzib_d_mask_n[l_ac].* =  g_gzib_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzib_d[l_ac].* TO NULL 
            INITIALIZE g_gzib_d_t.* TO NULL 
            INITIALIZE g_gzib_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份

            #end add-point
            LET g_gzib_d_t.* = g_gzib_d[l_ac].*     #新輸入資料
            LET g_gzib_d_o.* = g_gzib_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL azzi310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzib_d[li_reproduce_target].* = g_gzib_d[li_reproduce].*
 
               LET g_gzib_d[li_reproduce_target].gzib002 = NULL
 
            END IF
            
            #add-point:modify段before insert

            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM gzib_t 
             WHERE  gzib001 = g_gzia_m.gzia001
 
               AND gzib002 = g_gzib_d[l_ac].gzib002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzia_m.gzia001
               LET gs_keys[2] = g_gzib_d[g_detail_idx].gzib002
               CALL azzi310_insert_b('gzib_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_gzib_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzib_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi310_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d)

               #end add-point
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前

               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_gzia_m.gzia001
 
               LET gs_keys[gs_keys.getLength()+1] = g_gzib_d_t.gzib002
 
            
               #刪除同層單身
               IF NOT azzi310_delete_b('gzib_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi310_key_delete_b(gs_keys,'gzib_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身刪除中

               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi310_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後

               #end add-point
               LET l_count = g_gzib_d.getLength()
               
               #add-point:單身刪除後(<>d)

               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzib_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzib002
            #add-point:BEFORE FIELD gzib002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzib002
            
            #add-point:AFTER FIELD gzib002
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzib002
            #add-point:ON CHANGE gzib002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzib003
            #add-point:BEFORE FIELD gzib003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzib003
            
            #add-point:AFTER FIELD gzib003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzib003
            #add-point:ON CHANGE gzib003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzib005
            #add-point:BEFORE FIELD gzib005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzib005
            
            #add-point:AFTER FIELD gzib005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzib005
            #add-point:ON CHANGE gzib005

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzib006
            #add-point:BEFORE FIELD gzib006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzib006
            
            #add-point:AFTER FIELD gzib006

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzib006
            #add-point:ON CHANGE gzib006
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzib004
            #add-point:BEFORE FIELD gzib004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzib004
            
            #add-point:AFTER FIELD gzib004

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzib004
            #add-point:ON CHANGE gzib004
         #如果未勾选群组，不可跳页
          LET g_gzib_d_idx=l_ac
          IF g_gzib_d[g_gzib_d_idx].gzib005 = 'N' THEN
              INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = "azz-00780"         #增加群组不可跳页
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET g_gzib_d[g_gzib_d_idx].gzib004 ="N"
          END IF         
           #增加跳頁判斷 只能一個跳頁 (s)
          IF g_gzib_d[g_gzib_d_idx].gzib004 = 'Y' THEN 
            SELECT count(gzib004) INTO l_paging_cnt FROM gzib_t
            WHERE gzib001 = g_gzia_m.gzia001 
              AND paging ='Y'
            IF l_paging_cnt > 0 THEN  #已有設定跳頁
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00308"
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET g_gzib_d[g_gzib_d_idx].gzib004 ="N"
            #ELSE 
            #   CALL azzi310_maintain_gzib(g_gzib_d_idx, "upd")
            END IF          
          END IF
            #END add-point 
 
 
                  #Ctrlp:input.c.page1.gzib002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzib002
            #add-point:ON ACTION controlp INFIELD gzib002

            #END add-point
 
         #Ctrlp:input.c.page1.gzib003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzib003
            #add-point:ON ACTION controlp INFIELD gzib003

            #END add-point
 
         #Ctrlp:input.c.page1.gzib005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzib005
            #add-point:ON ACTION controlp INFIELD gzib005

            #END add-point
 
         #Ctrlp:input.c.page1.gzib006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzib006
            #add-point:ON ACTION controlp INFIELD gzib006

            #END add-point
 
         #Ctrlp:input.c.page1.gzib004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzib004
            #add-point:ON ACTION controlp INFIELD gzib004

            #END add-point
 
 
 
         ON ROW CHANGE
            LET l_in_row='N' #160926-00005#1 .3 add(e)
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_gzib_d[l_ac].* = g_gzib_d_t.*
               CLOSE azzi310_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzib_d[l_ac].gzib002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzib_d[l_ac].* = g_gzib_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL azzi310_gzib_t_mask_restore('restore_mask_o')
      
               UPDATE gzib_t SET (gzib001,gzib002,gzib003,gzib005,gzib006,gzib004) = (g_gzia_m.gzia001, 
                   g_gzib_d[l_ac].gzib002,g_gzib_d[l_ac].gzib003,g_gzib_d[l_ac].gzib005,g_gzib_d[l_ac].gzib006, 
                   g_gzib_d[l_ac].gzib004)
                WHERE  gzib001 = g_gzia_m.gzia001 
 
                  AND gzib002 = g_gzib_d_t.gzib002 #項次   
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzib_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzib_d[l_ac].* = g_gzib_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzib_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_gzib_d[l_ac].* = g_gzib_d_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzia_m.gzia001
               LET gs_keys_bak[1] = g_gzia001_t
               LET gs_keys[2] = g_gzib_d[g_detail_idx].gzib002
               LET gs_keys_bak[2] = g_gzib_d_t.gzib002
               CALL azzi310_update_b('gzib_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL azzi310_gzib_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gzib_d[g_detail_idx].gzib002 = g_gzib_d_t.gzib002 
 
                  ) THEN
                  LET gs_keys[01] = g_gzia_m.gzia001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzib_d_t.gzib002
 
                  CALL azzi310_key_update_b(gs_keys,'gzib_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzia_m),util.JSON.stringify(g_gzib_d_t)
               LET g_log2 = util.JSON.stringify(g_gzia_m),util.JSON.stringify(g_gzib_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
#             IF g_gzib_d[g_gzib_d_idx].gzib004!=g_gzib_d_t.gzib004
#                OR g_gzib_d[g_gzib_d_idx].gzib005!=g_gzib_d_t.gzib005
#                OR g_gzib_d[g_gzib_d_idx].gzib006!=g_gzib_d_t.gzib006 THEN
#                CALL azzi310_maintain_gzib(g_gzib_d_idx, "upd")
#             END IF
            #end add-point
            CALL azzi310_unlock_b("gzib_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2

            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_gzib_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzib_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
       INPUT g_comb_sumy FROM comb_sumy ATTRIBUTES(WITHOUT DEFAULTS)
         ON CHANGE comb_sumy
           IF g_sumylist2_idx>0 THEN 
            CALL azzi310_maintain_sumylist(g_sumylist2_idx, '', "upd")
         END IF 
            
       END INPUT
      
      
       #Page2左边树状结构-修改框架增加
       DISPLAY ARRAY g_sumylist1 TO s_sumylist1.* ATTRIBUTES(COUNT=g_sumylist1.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_sumylist1", 1)
            CALL azzi310_set_action_active_by_datasize("s_sumylist1", "sumyadd")
            CALL azzi310_set_action_active_by_datasize("s_sumylist2","sumydel")
         BEFORE ROW
            LET g_sumylist1_idx = DIALOG.getCurrentRow("s_sumylist1")
            #是Table的話, 不給多選
            IF g_sumylist1[g_sumylist1_idx].sumyisnode1 THEN
               CALL DIALOG.setSelectionMode("s_sumylist1", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_sumylist1", 1)
            END IF
         #140127 拖拉 add-(S)
         ON DRAG_START(dnd)
            IF azzi310_check_sumy_repeat(DIALOG.getCurrentRow("s_sumylist1")) THEN
               CALL dnd.setOperation(NULL)
            ELSE
               LET ls_area = "s_sumylist1"
            END IF
 
         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL
 
         #拖拉方式刪除, 啟動動作在s_sumylist2
         ON DROP(dnd)
            IF ls_area = "s_sumylist2" THEN
               CALL dnd.dropInternal()
               CALL azzi310_maintain_sumylist(DIALOG.getCurrentRow("s_sumylist2"), '', "del")
               #CALL azzi310_refresh_seq("s_sumylist2")               
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL azzi310_set_action_active_by_datasize("s_sumylist2", "sumydel")
            END IF
         
            
         #功能鍵方式增加
         ON ACTION sumyadd
            ##增加至彙總樹狀2
            CALL azzi310_maintain_sumylist(g_sumylist1_idx,'', "add")
      END DISPLAY
      
       #Page3右边树状结构-修改框架增加
       DISPLAY ARRAY g_sumylist2 TO s_sumylist2.* ATTRIBUTES(COUNT=g_sumylist2.getLength())
      
         BEFORE DISPLAY
            LET g_sumylist2_idx = DIALOG.getCurrentRow("s_sumylist2") 
            IF g_sumylist2[g_sumylist2_idx].sumyisnode2 THEN 
               CALL DIALOG.setSelectionMode("s_sumylist2", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_sumylist2", 1)
            END IF         
            CALL azzi310_set_action_active_by_datasize("s_sumylist2", "sumydel")    
                    
         BEFORE ROW
            LET g_sumylist2_idx = DIALOG.getCurrentRow("s_sumylist2") 
            IF g_sumylist2[g_sumylist2_idx].sumyisnode2 THEN 
               CALL DIALOG.setSelectionMode("s_sumylist2", 0)
               LET g_comb_sumy=""
            ELSE
               CALL DIALOG.setSelectionMode("s_sumylist2", 1)
               LET g_comb_sumy=g_sumylist2[g_sumylist2_idx].sumytype2
            END IF
            CALL azzi310_set_action_active_by_datasize("s_sumylist2", "sumydel")          
                
          
         ##140127 拖拉-(s)
         #拖拉方式增加, 結束動作在s_sumylist2的ON DROP
         ON DRAG_START(dnd)
            IF azzi310_check_sumy_repeat(DIALOG.getCurrentRow("s_sumylist2")) THEN
               CALL dnd.setOperation(NULL)
            ELSE
               LET ls_area = "s_sumylist2"
            END IF
 
         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL
 
         #拖拉方式刪除, 啟動動作在s_sumylist1
         ON DROP(dnd)
            IF ls_area = "s_sumylist1" THEN
               CALL dnd.dropInternal()
               CALL azzi310_maintain_sumylist(DIALOG.getCurrentRow("s_sumylist2"), '', "add")
               #CALL azzi310_refresh_seq("s_sumylist2")               
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL azzi310_set_action_active_by_datasize("s_sumylist2", "sumydel")
            END IF
         
         AFTER ROW      
             DISPLAY 1         
            
         ON ACTION sumydel
            CALL azzi310_maintain_sumylist(g_sumylist2_idx, '', "del")
            #CALL azzi310_refresh_seq("s_sumylist2")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_sumylist2_idx > g_sumylist2.getLength() THEN
               CALL DIALOG.setCurrentRow("s_sumylist2", g_sumylist2.getLength())
               LET g_sumylist2_idx = DIALOG.getCurrentRow("s_sumylist2")
            END IF
            CALL azzi310_set_action_active_by_datasize("s_sumylist2", "sumydel")
      END DISPLAY 
      
      #Page3
      INPUT ARRAY g_gzib2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
       ON ACTION argup
            CALL azzi310_move_up_down("s_detail2", "up")
            LET g_gzib2_d_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = ARR_CURR()
        
        ON ACTION argdown
            CALL azzi310_move_up_down("s_detail2", "down")
            LET g_gzib2_d_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = ARR_CURR()  
         
         BEFORE INPUT
            #add-point:資料輸入前

            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzib2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gzib2_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzib2_d[l_ac].* TO NULL 
            INITIALIZE g_gzib2_d_t.* TO NULL 
            INITIALIZE g_gzib2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份

            #end add-point
            LET g_gzib2_d_t.* = g_gzib2_d[l_ac].*     #新輸入資料
            LET g_gzib2_d_o.* = g_gzib2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL azzi310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzib2_d[li_reproduce_target].* = g_gzib2_d[li_reproduce].*
 
               LET g_gzib2_d[li_reproduce_target].gzie002 = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW     
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2            
            CALL azzi310_set_seqaction_active("s_detail2", "argup", "argdown",g_gzib2_d[l_ac].gzie002)   #160926-00005#1 .3
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN azzi310_cl USING g_gzia_m.gzia001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi310_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE azzi310_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_gzib2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzib2_d[l_ac].gzie002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzib2_d_t.* = g_gzib2_d[l_ac].*  #BACKUP
               LET g_gzib2_d_o.* = g_gzib2_d[l_ac].*  #BACKUP
               CALL azzi310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL azzi310_set_no_entry_b(l_cmd)
               IF NOT azzi310_lock_b("gzie_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi310_bcl2 INTO g_gzib2_d[l_ac].gzie002,g_gzib2_d[l_ac].gzie003,g_gzib2_d[l_ac].gzie005 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzib2_d_mask_o[l_ac].* =  g_gzib2_d[l_ac].*
                  CALL azzi310_gzie_t_mask()
                  LET g_gzib2_d_mask_n[l_ac].* =  g_gzib2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d)

               #end add-point
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前

               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_gzia_m.gzia001
               LET gs_keys[gs_keys.getLength()+1] = g_gzib2_d_t.gzie002
            
               #刪除同層單身
               IF NOT azzi310_delete_b('gzie_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi310_key_delete_b(gs_keys,'gzie_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身2刪除中

               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi310_bcl
               LET g_rec_b = g_rec_b-1
               
               #add-point:單身2刪除後

               #end add-point
               LET l_count = g_gzib_d.getLength()
               
               #add-point:單身刪除後(<>d)

               #end add-point
            END IF 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzib2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM gzie_t 
             WHERE  gzie001 = g_gzia_m.gzia001
               AND gzie002 = g_gzib2_d[l_ac].gzie002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzia_m.gzia001
               LET gs_keys[2] = g_gzib2_d[g_detail_idx].gzie002
               CALL azzi310_insert_b('gzie_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_gzib_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzie_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi310_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_gzib2_d[l_ac].* = g_gzib2_d_t.*
               CLOSE azzi310_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzib2_d[l_ac].* = g_gzib2_d_t.*
            ELSE
               #add-point:單身page2修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL azzi310_gzie_t_mask_restore('restore_mask_o')
                              
               UPDATE gzie_t SET (gzie001,gzie002,gzie003,gzie005) = (g_gzia_m.gzia001,g_gzib2_d[l_ac].gzie002, 
                   g_gzib2_d[l_ac].gzie003,g_gzib2_d[l_ac].gzie005) #自訂欄位頁簽
                WHERE  gzie001 = g_gzia_m.gzia001
                  AND gzie002 = g_gzib2_d_t.gzie002 #項次 
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzie_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzib2_d[l_ac].* = g_gzib2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzie_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzib2_d[l_ac].* = g_gzib2_d_t.*
                  OTHERWISE
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzia_m.gzia001
               LET gs_keys_bak[1] = g_gzia001_t
               LET gs_keys[2] = g_gzib2_d[g_detail_idx].gzie002
               LET gs_keys_bak[2] = g_gzib2_d_t.gzie002
               CALL azzi310_update_b('gzie_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi310_gzie_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gzib2_d[g_detail_idx].gzie002 = g_gzib2_d_t.gzie002 
                  ) THEN
                  LET gs_keys[01] = g_gzia_m.gzia001
                  LET gs_keys[gs_keys.getLength()+1] = g_gzib2_d_t.gzie002
                  CALL azzi310_key_update_b(gs_keys,'gzie_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzia_m),util.JSON.stringify(g_gzib2_d_t)
               LET g_log2 = util.JSON.stringify(g_gzia_m),util.JSON.stringify(g_gzib2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後

               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzie002
            #add-point:BEFORE FIELD gzie002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzie002
            
            #add-point:AFTER FIELD gzie002
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzie002
            #add-point:ON CHANGE gzie002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzie003
            #add-point:BEFORE FIELD gzie003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzie003
            
            #add-point:AFTER FIELD gzie003
 IF  NOT cl_null(g_gzia_m.gzia001) AND NOT cl_null(g_gzib2_d[l_ac].gzie003)  THEN
               IF  p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_gzia_m.gzia001 != g_gzia_m_t.gzia001 OR g_gzib2_d[l_ac].gzie003 != g_gzib2_d_t.gzie003 OR g_gzib2_d_t.gzie003 IS NULL)) THEN   
                  CALL azzi310_chk_gzie003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gzib2_d[l_ac].gzie003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gzib2_d[l_ac].gzie003 = g_gzib2_d_t.gzie003
                     NEXT FIELD gzie003
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzie003
            #add-point:ON CHANGE gzie003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzie005
            #add-point:BEFORE FIELD gzie005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzie005
            
            #add-point:AFTER FIELD gzie005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzie005
            #add-point:ON CHANGE gzie005
            #LET g_gzib2_d_idx = DIALOG.getCurrentRow("s_detail2")
#            IF g_gzib2_d_t.gzie005 != g_gzib2_d[l_ac].gzie005 THEN
#                CALL azzi310_maintain_gzie(l_ac)
#                LET g_gzib2_d_t.*=g_gzib2_d[l_ac].*
#            END IF
            #END add-point 
 
 
                  #Ctrlp:input.c.page2.gzie002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzie002
            #add-point:ON ACTION controlp INFIELD gzie002

            #END add-point
 
         #Ctrlp:input.c.page2.gzie003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzie003
            #add-point:ON ACTION controlp INFIELD gzie003

            #END add-point
 
         #Ctrlp:input.c.page2.gzie005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzie005
            #add-point:ON ACTION controlp INFIELD gzie005

            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row
 
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzib2_d[l_ac].* = g_gzib2_d_t.*
               END IF
               CLOSE azzi310_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL azzi310_unlock_b("gzie_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_gzib2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzib2_d.getLength()+1
 
      END INPUT
      
      #160926-00005#1 .3 add(s)
     
#          ON ACTION qbeup
#            IF l_in_row='Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   ='azz-01158' 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               NEXT FIELD CURRENT
#            END IF
#            CALL azzi310_move_up_down("s_detail3", "up")
#           LET l_ac = ARR_CURR()
#           LET g_gzib3_d_idx = DIALOG.getCurrentRow("s_detail3")
#            
#         ON ACTION qbedown
#            IF l_in_row='Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   ='azz-01158' 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#                NEXT FIELD CURRENT
#            END IF
#            CALL azzi310_move_up_down("s_detail3", "down")
#            LET l_ac = ARR_CURR()
#            LET g_gzib3_d_idx = DIALOG.getCurrentRow("s_detail3")
       
      #160926-00005#1 .3 add(e)
      
      INPUT ARRAY g_gzib3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
        ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN 
             
               IF  NOT cl_null(g_gzib3_d[l_ac].gzid002)THEN 
                  CALL n_gzidl(g_gzia_m.gzia001,g_gzib3_d[l_ac].gzid002) 
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_gzia_m.gzia001
                  LET g_ref_fields[2]=g_gzib3_d[l_ac].gzid002
                  CALL ap_ref_array2(g_ref_fields," SELECT gzidl004 FROM gzidl_t WHERE gzidl001 = ? AND gzidl002 = ? AND gzidl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_gzib3_d[l_ac].gzidl004 = g_rtn_fields[1]
                  DISPLAY BY NAME g_gzib3_d[l_ac].gzidl004
               END IF   
               
            END IF
           IF g_chk_sql="Y" THEN
              LET g_action_choice="sqlverify"
           END IF
           
          ON ACTION qbeup
          #160926-00005#1 .3 add(s)
          IF g_gzib3_d_t.* <> g_gzib3_d[l_ac].* AND l_change_row='N' THEN         
            IF l_in_row='Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   ='azz-01158' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF                
         END IF 
         #160926-00005#1 .3 add(e)
            CALL azzi310_move_up_down("s_detail3", "up")
           LET l_ac = ARR_CURR()
           LET g_gzib3_d_idx = DIALOG.getCurrentRow("s_detail3")
      
         ON ACTION qbedown
         #160926-00005#1 .3 add(s)
         IF g_gzib3_d_t.* <> g_gzib3_d[l_ac].*  AND l_change_row='N' THEN
            IF l_in_row='Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   ='azz-01158' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
        END IF
      #160926-00005#1 .3 add(e)        
            CALL azzi310_move_up_down("s_detail3", "down")
            LET l_ac = ARR_CURR()
            LET g_gzib3_d_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_change_row='Y'
          
         ON ACTION data_replace_setting
             IF azzi310_03(g_gzia_m.gzia001,g_gzib3_d[l_ac].gzid002) THEN     #暂时mark
                 LET g_gzib3_d[l_ac].gzid012 = 'Y'
             ELSE
                 LET g_gzib3_d[l_ac].gzid012 = 'N'           
              END IF
             DISPLAY BY NAME g_gzib3_d[l_ac].gzid012
             
             
         BEFORE INPUT
            #add-point:資料輸入前
            #160926-00005#1 .3 add(s) 
           LET l_in_row='N' 
           LET l_change_row='N'
           #160926-00005#1 .3 add(e) 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzib3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gzib3_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzib3_d[l_ac].* TO NULL 
            INITIALIZE g_gzib3_d_t.* TO NULL 
            INITIALIZE g_gzib3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            LET g_gzib3_d[l_ac].gzid006 = "0"
            LET g_gzib3_d[l_ac].gzid007 = "0"
 
            #add-point:modify段before備份

            #end add-point
            LET g_gzib3_d_t.* = g_gzib3_d[l_ac].*     #新輸入資料
            LET g_gzib3_d_o.* = g_gzib3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL azzi310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzib3_d[li_reproduce_target].* = g_gzib3_d[li_reproduce].*
 
               LET g_gzib3_d[li_reproduce_target].gzid002 = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW     
            #add-point:modify段before row2
            LET l_change_row='N'
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3             
            CALL azzi310_set_seqaction_active("s_detail3", "qbeup", "qbedown",g_gzib3_d[l_ac].gzid007) #160926-00005#1 .3 add
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN azzi310_cl USING g_gzia_m.gzia001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi310_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE azzi310_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_gzib3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzib3_d[l_ac].gzid002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzib3_d_t.* = g_gzib3_d[l_ac].*  #BACKUP
               LET g_gzib3_d_o.* = g_gzib3_d[l_ac].*  #BACKUP
               CALL azzi310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               LET g_detail_multi_table_t.gzidl001 = g_gzia_m.gzia001
               LET g_detail_multi_table_t.gzidl002 = g_gzib3_d[l_ac].gzid002
               LET g_detail_multi_table_t.gzidl003 = g_dlang
               LET g_detail_multi_table_t.gzidl004 = g_gzib3_d[l_ac].gzidl004
               #end add-point  
               CALL azzi310_set_no_entry_b(l_cmd)
               IF NOT azzi310_lock_b("gzid_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
               #160901-00030#1mod add->gzid017   
               #161121-00024#1 add-> gzid018
                  FETCH azzi310_bcl3 INTO g_gzib3_d[l_ac].gzid002,g_gzib3_d[l_ac].gzid003,g_gzib3_d[l_ac].gzid004, 
                      g_gzib3_d[l_ac].gzid005,g_gzib3_d[l_ac].gzid006,g_gzib3_d[l_ac].gzid007,g_gzib3_d[l_ac].gzid018,g_gzib3_d[l_ac].gzid008, 
                      g_gzib3_d[l_ac].gzid009,g_gzib3_d[l_ac].gzid010,g_gzib3_d[l_ac].gzid011,g_gzib3_d[l_ac].gzid012 
                      ,g_gzib3_d[l_ac].gzid014,g_gzib3_d[l_ac].gzid015,g_gzib3_d[l_ac].gzid017 #160523-00002#2 add 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzib3_d_mask_o[l_ac].* =  g_gzib3_d[l_ac].*
                  CALL azzi310_gzid_t_mask()
                  LET g_gzib3_d_mask_n[l_ac].* =  g_gzib3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()                 
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            LET l_in_row='Y' #160926-00005#1 .3 add(e)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d)

               #end add-point
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前

               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_gzia_m.gzia001
               LET gs_keys[gs_keys.getLength()+1] = g_gzib3_d_t.gzid002
            
               #刪除同層單身
               IF NOT azzi310_delete_b('gzid_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi310_key_delete_b(gs_keys,'gzid_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身3刪除中

               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi310_bcl
               LET g_rec_b = g_rec_b-1
               
               #add-point:單身3刪除後

               #end add-point
               LET l_count = g_gzib_d.getLength()
               
               #add-point:單身刪除後(<>d)

               #end add-point
            END IF 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzib3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM gzid_t 
             WHERE  gzid001 = g_gzia_m.gzia001
               AND gzid002 = g_gzib3_d[l_ac].gzid002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzia_m.gzia001
               LET gs_keys[2] = g_gzib3_d[g_detail_idx].gzid002
               CALL azzi310_insert_b('gzid_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_gzib_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzid_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi310_b_fill()
               #資料多語言用-增/改
             INITIALIZE l_var_keys TO NULL
               INITIALIZE l_field_keys TO NULL
               INITIALIZE l_vars TO NULL
               INITIALIZE l_fields TO NULL
               INITIALIZE l_var_keys_bak TO NULL
               IF g_gzia_m.gzia001 = g_detail_multi_table_t.gzidl001 AND
                  g_gzib3_d[l_ac].gzid002 = g_detail_multi_table_t.gzidl002 AND
                  g_gzib3_d[l_ac].gzidl004 = g_detail_multi_table_t.gzidl004 THEN
               ELSE
                 LET l_var_keys[01] = g_gzia_m.gzia001
                 LET l_field_keys[01] = 'gzidl001'
                 LET l_var_keys_bak[01] = g_detail_multi_table_t.gzidl001
                 LET l_var_keys[02] = g_gzib3_d[l_ac].gzid002
                 LET l_field_keys[02] = 'gzidl002'
                 LET l_var_keys_bak[02] = g_detail_multi_table_t.gzidl002
                 LET l_var_keys[03] = g_dlang
                 LET l_field_keys[03] = 'gzidl003'
                 LET l_var_keys_bak[03] = g_detail_multi_table_t.gzidl003
                 LET l_vars[01] = g_gzib3_d[l_ac].gzidl004
                 LET l_fields[01] = 'gzidl004'
                CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzidl_t')
               END IF  
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_gzib3_d[l_ac].* = g_gzib3_d_t.*
               CLOSE azzi310_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzib3_d[l_ac].* = g_gzib3_d_t.*
            ELSE
               #add-point:單身page3修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL azzi310_gzid_t_mask_restore('restore_mask_o')
               #160901-00030#1mod add->gzid017       
               #161121-00024#1mod add->gzid018   
               UPDATE gzid_t SET (gzid001,gzid002,gzid003,gzid004,gzid005,gzid006,gzid007,gzid018,gzid008,gzid009, 
                   gzid010,gzid011,gzid012,gzid014,gzid015,gzid017) = (g_gzia_m.gzia001,g_gzib3_d[l_ac].gzid002,g_gzib3_d[l_ac].gzid003, #160523-00002#2 add gzid013,gzid015
                   g_gzib3_d[l_ac].gzid004,g_gzib3_d[l_ac].gzid005,g_gzib3_d[l_ac].gzid006,g_gzib3_d[l_ac].gzid007, g_gzib3_d[l_ac].gzid018,
                   g_gzib3_d[l_ac].gzid008,g_gzib3_d[l_ac].gzid009,g_gzib3_d[l_ac].gzid010,g_gzib3_d[l_ac].gzid011, 
                   g_gzib3_d[l_ac].gzid012,g_gzib3_d[l_ac].gzid014,g_gzib3_d[l_ac].gzid015,g_gzib3_d[l_ac].gzid017) #自訂欄位頁簽  #160523-00002#2 add gzid014,gzid015
                WHERE  gzid001 = g_gzia_m.gzia001
                  AND gzid002 = g_gzib3_d_t.gzid002 #項次 
                  
               #add-point:單身page3修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzid_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzib3_d[l_ac].* = g_gzib3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzid_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzib3_d[l_ac].* = g_gzib3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzia_m.gzia001
               LET gs_keys_bak[1] = g_gzia001_t
               LET gs_keys[2] = g_gzib3_d[g_detail_idx].gzid002
               LET gs_keys_bak[2] = g_gzib3_d_t.gzid002
               CALL azzi310_update_b('gzid_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                 INITIALIZE l_var_keys TO NULL
               INITIALIZE l_field_keys TO NULL
               INITIALIZE l_vars TO NULL
               INITIALIZE l_fields TO NULL
               INITIALIZE l_var_keys_bak TO NULL
               IF g_gzia_m.gzia001 = g_detail_multi_table_t.gzidl001 AND
                  g_gzib3_d[l_ac].gzid002 = g_detail_multi_table_t.gzidl002 AND
                  g_gzib3_d[l_ac].gzidl004 = g_detail_multi_table_t.gzidl004 THEN
               ELSE
                 LET l_var_keys[01] = g_gzia_m.gzia001
                 LET l_field_keys[01] = 'gzidl001'
                 LET l_var_keys_bak[01] = g_detail_multi_table_t.gzidl001
                 LET l_var_keys[02] = g_gzib3_d[l_ac].gzid002
                 LET l_field_keys[02] = 'gzidl002'
                 LET l_var_keys_bak[02] = g_detail_multi_table_t.gzidl002
                 LET l_var_keys[03] = g_dlang
                 LET l_field_keys[03] = 'gzidl003'
                 LET l_var_keys_bak[03] = g_detail_multi_table_t.gzidl003
                 LET l_vars[01] = g_gzib3_d[l_ac].gzidl004
                 LET l_fields[01] = 'gzidl004'
                CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzidl_t')
               END IF     
               
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi310_gzid_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gzib3_d[g_detail_idx].gzid002 = g_gzib3_d_t.gzid002 
                  ) THEN
                  LET gs_keys[01] = g_gzia_m.gzia001
                  LET gs_keys[gs_keys.getLength()+1] = g_gzib3_d_t.gzid002
                  CALL azzi310_key_update_b(gs_keys,'gzid_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzia_m),util.JSON.stringify(g_gzib3_d_t)
               LET g_log2 = util.JSON.stringify(g_gzia_m),util.JSON.stringify(g_gzib3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後

               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid002
            #add-point:BEFORE FIELD gzid002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid002
            
            #add-point:AFTER FIELD gzid002
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid002
            #add-point:ON CHANGE gzid002
 
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid003
            #add-point:BEFORE FIELD gzid003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid003
            
            #add-point:AFTER FIELD gzid003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid003
            #add-point:ON CHANGE gzid003
          
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid004
            #add-point:BEFORE FIELD gzid004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid004
            
            #add-point:AFTER FIELD gzid004
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid004
            #add-point:ON CHANGE gzid004
          
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid005
            #add-point:BEFORE FIELD gzid005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid005
            
            #add-point:AFTER FIELD gzid005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid005
            #add-point:ON CHANGE gzid005
         
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid006
            #add-point:BEFORE FIELD gzid006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid006
            
            #add-point:AFTER FIELD gzid006
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid006
            #add-point:ON CHANGE gzid006
         
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid007
            #add-point:BEFORE FIELD gzid007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid007
            
            #add-point:AFTER FIELD gzid007
         
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid007
            #add-point:ON CHANGE gzid007
         
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid008
            #add-point:BEFORE FIELD gzid008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid008
            
            #add-point:AFTER FIELD gzid008

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid008
            #add-point:ON CHANGE gzid008
             IF g_gzib3_d[l_ac].gzid008 = 'N' THEN 
                LET g_gzib3_d[l_ac].gzid009 = "" 
                DISPLAY BY NAME g_gzib3_d[l_ac].gzid009
             END IF
             CALL azzi310_set_entry_b(l_cmd)
             CALL azzi310_set_no_entry_b(l_cmd)
             
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid009
            #add-point:BEFORE FIELD gzid009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid009
            
            #add-point:AFTER FIELD gzid009
           IF g_gzib3_d[l_ac].gzid009 !=g_gzib3_d_t.gzid009 OR g_gzib3_d_t.gzid009 IS NULL THEN
             #160711-00011#1 mod(s)
             IF g_upd_flag <>'Y' THEN
                IF  NOT cl_chk_exist("v_dzca001_3") THEN #160711-00011#1 mod
             	    NEXT FIELD CURRENT
                END IF
                LET g_upd_flag='Y' 
              END IF
              #160711-00011#1 mod(e)
           END IF
          
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid009
            #add-point:ON CHANGE gzid009
           IF g_gzib3_d[l_ac].gzid009 !=g_gzib3_d_t.gzid009 OR g_gzib3_d_t.gzid009 IS NULL THEN
           LET g_chkparam.arg1 = g_gzib3_d[l_ac].gzid009
            IF  NOT cl_chk_exist("v_dzca001_3") THEN #160711-00011#1 mod
             	 NEXT FIELD CURRENT
            END IF
            LET g_upd_flag='Y' 
         END IF
         
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid010
            #add-point:BEFORE FIELD gzid010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid010
            
            #add-point:AFTER FIELD gzid010

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid010
            #add-point:ON CHANGE gzid010
             IF  g_gzib3_d[l_ac].gzid010 != g_gzib3_d_t.gzid010 OR g_gzib3_d_t.gzid010 is null THEN
                 SELECT gztd012 INTO l_gztd012 FROM gztd_t WHERE gztd001=g_gzib3_d[l_ac].gzid010
                 LET g_gzib3_d[l_ac].gzid011=""
                 IF not cl_null(l_gztd012) THEN
                    LET lc_gztd012=l_gztd012
                    LET g_gzib3_d[l_ac].gzid011 = lc_gztd012.subString(lc_gztd012.getIndexOf(",",1)+1,lc_gztd012.getLength())
                 END IF
             END IF
             CALL azzi310_set_no_entry_b(l_cmd)
             CALL azzi310_set_entry_b(l_cmd)
             
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid011
            #add-point:BEFORE FIELD gzid011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid011
            
            #add-point:AFTER FIELD gzid011

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid011
            #add-point:ON CHANGE gzid011
          
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzid012
            #add-point:BEFORE FIELD gzid012

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzid012
            
            #add-point:AFTER FIELD gzid012
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzid012
            #add-point:ON CHANGE gzid012
           IF g_gzib3_d[l_ac].gzid012 != g_gzib3_d_t.gzid012 OR g_gzib3_d_t.gzid012 IS NULL THEN
               IF g_gzib3_d[l_ac].gzid012 = 'Y' THEN
                  IF azzi310_03(g_gzia_m.gzia001,g_gzib3_d[l_ac].gzid002) THEN     #暂时mark
                     LET g_gzib3_d_t.gzid012 = g_gzib3_d[l_ac].gzid012
                  ELSE
                     LET g_gzib3_d[l_ac].gzid012 = g_gzib3_d_t.gzid012
                     DISPLAY BY NAME g_gzib3_d[l_ac].gzid012
                  END IF
               ELSE 
                  IF cl_ask_confirm('azz-00912') THEN  #已有轉換資料，是否刪除設定資料?
                     DELETE FROM gzif_t
                       WHERE gzif001 = g_gzia_m.gzia001 
                         AND gzif002 = g_gzib3_d[l_ac].gzid002 
                                          
                     IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = 'del gzif_t' 
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE 
                       CALL cl_err()
#                        CALL xx_cl_err3("del","gzif_t",g_gzia_m.gzia001,g_gzib3_d[l_ac].gzid012,SQLCA.sqlcode,"","",0)     
                        NEXT FIELD gzid007
                     END IF
                     LET g_gzib3_d_t.gzid012 = g_gzib3_d[l_ac].gzid012
                  ELSE
                     LET g_gzib3_d[l_ac].gzid012 = g_gzib3_d_t.gzid012
                     DISPLAY BY NAME g_gzib3_d[l_ac].gzid012
                  END IF
               END IF
            END IF
            #160523-00002#2 add(e)
             
            #END add-point 
          
         
          
         BEFORE FIELD gzid014
            #add-point:BEFORE FIELD gzid014
 
            #END add-point
 
         AFTER FIELD gzid014
            
            #add-point:AFTER FIELD gzid014
 
            #END add-point
            
 
         ON CHANGE gzid014
            #add-point:ON CHANGE gzid014
             IF g_gzib3_d[l_ac].gzid014 = 'N' THEN 
                LET g_gzib3_d[l_ac].gzid015 = "" 
                DISPLAY BY NAME g_gzib3_d[l_ac].gzid015
             END IF
             CALL azzi310_set_entry_b(l_cmd)
             CALL azzi310_set_no_entry_b(l_cmd)
             
            #END add-point 
            
 
         BEFORE FIELD gzid015
            #add-point:BEFORE FIELD gzid015
 
            #END add-point
 
         AFTER FIELD gzid015
            
            #add-point:AFTER FIELD gzid015
 
            #END add-point
                  
         ON CHANGE gzid015
            #add-point:ON CHANGE gzid015
           IF g_gzib3_d[l_ac].gzid015 !=g_gzib3_d_t.gzid015 OR g_gzib3_d_t.gzid015 IS NULL THEN
           LET g_chkparam.arg1 = g_gzib3_d[l_ac].gzid015
            IF  NOT cl_chk_exist("v_gzzz001") THEN
             	 NEXT FIELD CURRENT
            END IF    
         END IF
           #160523-00002#2 add(e) 
           
           #END add-point
           
         #160901-00030#1 add(s)  
         BEFORE FIELD gzid017
            #add-point:BEFORE FIELD gzid015
 
            #END add-point
 
         AFTER FIELD gzid017
            
            #add-point:AFTER FIELD gzid015
            IF NOT cl_null(g_gzib3_d[l_ac].gzid017) THEN
               IF g_gzib3_d[l_ac].gzid017 !=g_gzib3_d_t.gzid017 OR g_gzib3_d_t.gzid017 IS NULL THEN
                  IF  NOT azzi310_chk_json(g_gzib3_d[l_ac].gzid017) THEN
                	    NEXT FIELD CURRENT
                  END IF    
               END IF
            END IF
            #END add-point
                  
         ON CHANGE gzid017
            #add-point:ON CHANGE gzid015
           IF NOT cl_null(g_gzib3_d[l_ac].gzid017) THEN
               IF g_gzib3_d[l_ac].gzid017 !=g_gzib3_d_t.gzid017 OR g_gzib3_d_t.gzid017 IS NULL THEN
                  IF  NOT azzi310_chk_json(g_gzib3_d[l_ac].gzid017) THEN
                	    NEXT FIELD CURRENT
                  END IF    
               END IF
            END IF
         #160901-00030#1 add(e) 
                   
                  #Ctrlp:input.c.page3.gzid002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid002
            #add-point:ON ACTION controlp INFIELD gzid002

            #END add-point
 
         #Ctrlp:input.c.page3.gzid003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid003
            #add-point:ON ACTION controlp INFIELD gzid003

            #END add-point
 
         #Ctrlp:input.c.page3.gzid004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid004
            #add-point:ON ACTION controlp INFIELD gzid004

            #END add-point
 
         #Ctrlp:input.c.page3.gzid005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid005
            #add-point:ON ACTION controlp INFIELD gzid005

            #END add-point
 
         #Ctrlp:input.c.page3.gzid006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid006
            #add-point:ON ACTION controlp INFIELD gzid006

            #END add-point
 
         #Ctrlp:input.c.page3.gzid007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid007
            #add-point:ON ACTION controlp INFIELD gzid007

            #END add-point
 
         #Ctrlp:input.c.page3.gzid008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid008
            #add-point:ON ACTION controlp INFIELD gzid008

            #END add-point
 
         #Ctrlp:input.c.page3.gzid009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid009
            #add-point:ON ACTION controlp INFIELD gzid009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzib3_d[l_ac].gzid009
            #CALL q_dzca001_01()                           #呼叫開窗
            CALL q_dzca001_06()                           # 160711-00011#01 mod
            LET g_gzib3_d[l_ac].gzid009=g_qryparam.return1
            IF g_gzib3_d[l_ac].gzid009 !=g_gzib3_d_t.gzid009 OR g_gzib3_d_t.gzid009 IS NULL THEN
               LET g_upd_flag='Y'
            END IF
            DISPLAY g_gzib3_d[l_ac].gzid009 TO gzid009  #顯示到畫面上
            NEXT FIELD gzid009
            
            #END add-point
 
         #Ctrlp:input.c.page3.gzid010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid010
            #add-point:ON ACTION controlp INFIELD gzid010

            #END add-point
 
         #Ctrlp:input.c.page3.gzid011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid011
            #add-point:ON ACTION controlp INFIELD gzid011

            #END add-point
 
         #Ctrlp:input.c.page3.gzid012
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzid012
            #add-point:ON ACTION controlp INFIELD gzid012

            #END add-point
 
        #160523-00002#2 add(s)
         ON ACTION controlp INFIELD gzid015
            #add-point:ON ACTION controlp INFIELD gzid015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzib3_d[l_ac].gzid015
            CALL q_gzzz001_1()                           #呼叫開窗
            LET g_gzib3_d[l_ac].gzid015=g_qryparam.return1
            DISPLAY g_gzib3_d[l_ac].gzid015 TO gzid015 #顯示到畫面上
            NEXT FIELD gzid015
        #160523-00002#2 add(e)
        
         AFTER ROW
            #add-point:單身page3 after_row

            #end add-point
            
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzib3_d[l_ac].* = g_gzib3_d_t.*
               END IF
               CLOSE azzi310_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL azzi310_unlock_b("gzid_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2
             LET l_in_row='N' #160926-00005#1 .3 add(e)
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input 
            LET l_in_row='N' #160926-00005#1 .3 add(e)
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_gzib3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzib3_d.getLength()+1
 
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="azzi310.input.other" >}
      
      #add-point:自定義input

      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog
          LET gdig_curr=ui.Dialog.getCurrent() 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field

            #end add-point  
            NEXT FIELD gzia001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzib002
               WHEN "s_detail2"
                  NEXT FIELD gzie002
               WHEN "s_detail3"
                  NEXT FIELD gzid002
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog

         #end add-point 
 
       #以下4个action通过修改框架增加
        ON ACTION page_gp  
            CALL azzi310_grouplist_b_fill()
            CALL azzi310_gziblist_b_fill()
            LET g_current_page=1
        
        ON ACTION page_sumy
            CALL azzi310_sumy1_b_fill()
            CALL azzi310_sumy2_b_fill()
            LET g_current_page=2
        
        ON ACTION page_arg
            CALL azzi310_gzielist_b_fill()
            LET g_current_page=3
            
        ON ACTION page_qbe
            CALL azzi310_gzidlist_b_fill()
            LET g_current_page=4            
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept 
         #新增或者修改了sql内容，点击确定之前必须先验证sql
       #  IF (g_action_choice !="sqlverify" AND (g_gzia_m.gzia006 != g_gzia_m_t.gzia006 OR g_gzia_m_t.gzia006 is NULL) AND g_chk_sql != "Y")
       # IF (g_action_choice !="sqlverify" AND (g_gzia_m.gzia006 != g_gzia_m_t.gzia006 OR g_gzia_m_t.gzia006 is NULL))          
       # IF (g_action_choice !="sqlverify" AND (g_gzia_m.gzia006 !=g_gzia006_t OR g_gzia006_t is null))       
         IF g_chk_sql="N"         
          THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "" 
             LET g_errparam.code   = "azz-00920" 
             LET g_errparam.popup  = FALSE
             CALL cl_err()
             CONTINUE DIALOG
         END IF
         LET INT_FLAG = FALSE
         LET g_chk_sql=""
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel

         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close

         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit

         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 
   IF NOT INT_FLAG AND g_upd_flag='Y' THEN  
      CALL azzi310_gen_include_4gl()
      LET g_upd_flag='N'
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi310_show()
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define
  
   #end add-point  
   #add-point:show段define(客製用)
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL azzi310_b_fill() #單身填充
      CALL azzi310_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:3)
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL azzi310_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
    INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzia_m.gzia001
   CALL ap_ref_array2(g_ref_fields," SELECT gzial003 FROM gzial_t WHERE gzial001 = ? AND gzial002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzia_m.gzial003 = g_rtn_fields[1]  
   DISPLAY BY NAME g_gzia_m.gzial003 
   #end add-point
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
       g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaownid_desc, 
       g_gzia_m.gziaowndp,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp, 
       g_gzia_m.gziacrtdp_desc,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamodid_desc,g_gzia_m.gziamoddt, 
       g_gzia_m.groupname,g_gzia_m.sumyname1,g_gzia_m.comb_sumy,g_gzia_m.s_global_var
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzia_m.gziastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzib_d.getLength()
      #add-point:show段單身reference
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzib2_d.getLength()
      #add-point:show段單身reference
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gzib3_d.getLength()
      #add-point:show段單身reference
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL azzi310_detail_show()
 
   #add-point:show段之後
    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION azzi310_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
   #add-point:detail_show段define(客製用)
   
   #end add-point  
   
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi310_reproduce()
   DEFINE l_newno     LIKE gzia_t.gzia001 
   DEFINE l_oldno     LIKE gzia_t.gzia001 
 
   DEFINE l_master    RECORD LIKE gzia_t.*
   DEFINE l_detail    RECORD LIKE gzib_t.*
   DEFINE l_detail2    RECORD LIKE gzie_t.*
 
   DEFINE l_detail3    RECORD LIKE gzid_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define
   
   #end add-point   
   #add-point:reproduce段define(客製用)
   
   #end add-point   
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gzia001_t = g_gzia_m.gzia001
 
    
   LET g_gzia_m.gzia001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_gzia_m.gziaownid = g_user
      LET g_gzia_m.gziaowndp = g_dept
      LET g_gzia_m.gziacrtid = g_user
      LET g_gzia_m.gziacrtdp = g_dept 
      LET g_gzia_m.gziacrtdt = cl_get_current()
      LET g_gzia_m.gziamodid = g_user
      LET g_gzia_m.gziamoddt = cl_get_current()
      LET g_gzia_m.gziastus = 'Y'
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzia_m.gziastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
   
   #清空key欄位的desc
   
   
   CALL azzi310_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gzia_m.* TO NULL
      INITIALIZE g_gzib_d TO NULL
      INITIALIZE g_gzib2_d TO NULL
      INITIALIZE g_gzib3_d TO NULL
 
      #add-point:複製取消後
      
      #end add-point
      CALL azzi310_show()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi310_set_act_visible()   
   CALL azzi310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzia001 = '", g_gzia_m.gzia001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
     
   #end add-point
   
   CALL azzi310_idx_chk()
   
   #功能已完成,通報訊息中心
   CALL azzi310_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi310_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzib_t.*
   DEFINE l_detail2    RECORD LIKE gzie_t.*
 
   DEFINE l_detail3    RECORD LIKE gzid_t.*
 
 
 
   #add-point:delete段define

   #end add-point    
   #add-point:delete段define(客製用)

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi310_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE azzi310_detail AS ",
                "SELECT * FROM gzib_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi310_detail SELECT * FROM gzib_t 
                                         WHERE  gzib001 = g_gzia001_t
 
   
   #將key修正為調整後   
   UPDATE azzi310_detail 
      #更新key欄位
      SET gzib001 = g_gzia_m.gzia001
 
      #更新共用欄位
      
 
   #add-point:單身修改前

   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gzib_t SELECT * FROM azzi310_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi310_detail
   
   #add-point:單身複製後1

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi310_detail AS ",
      "SELECT * FROM gzie_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi310_detail SELECT * FROM gzie_t
                                         WHERE  gzie001 = g_gzia001_t
 
 
   #將key修正為調整後   
   UPDATE azzi310_detail SET gzie001 = g_gzia_m.gzia001
 
  
   #將資料塞回原table   
   INSERT INTO gzie_t SELECT * FROM azzi310_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi310_detail
   
   #add-point:單身複製後

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi310_detail AS ",
      "SELECT * FROM gzid_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi310_detail SELECT * FROM gzid_t
                                         WHERE  gzid001 = g_gzia001_t
 
 
   #將key修正為調整後   
   UPDATE azzi310_detail SET gzid001 = g_gzia_m.gzia001
 
  
   #將資料塞回原table   
   INSERT INTO gzid_t SELECT * FROM azzi310_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi310_detail
   
   #add-point:單身複製後
   
   #复制gzif_t
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi310_detail AS ",
      "SELECT * FROM gzif_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi310_detail SELECT * FROM gzif_t
                                         WHERE  gzif001 = g_gzia001_t
 
 
   #將key修正為調整後   
   UPDATE azzi310_detail SET gzif001 = g_gzia_m.gzia001
 
  
   #將資料塞回原table   
   INSERT INTO gzif_t SELECT * FROM azzi310_detail
     #刪除TEMP TABLE
   DROP TABLE azzi310_detail
   
   #复制gzig_t
    #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi310_detail AS ",
      "SELECT * FROM gzig_t "
   PREPARE repro_tbl5 FROM ls_sql
   EXECUTE repro_tbl5
   FREE repro_tbl5
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi310_detail SELECT * FROM gzig_t
                                         WHERE  gzig001 = g_gzia001_t
 
 
   #將key修正為調整後   
   UPDATE azzi310_detail SET gzig001 = g_gzia_m.gzia001
 
  
   #將資料塞回原table   
   INSERT INTO gzig_t SELECT * FROM azzi310_detail
   
   #刪除TEMP TABLE
   DROP TABLE azzi310_detail
   
   #复制单身多语言gzidl_t
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE azzi310_detail AS ",
      "SELECT * FROM gzidl_t "
   PREPARE repro_tbl6 FROM ls_sql
   EXECUTE repro_tbl6
   FREE repro_tbl6
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi310_detail SELECT * FROM gzidl_t
                                         WHERE  gzidl001 = g_gzia001_t
 
 
   #將key修正為調整後   
   UPDATE azzi310_detail SET gzidl001 = g_gzia_m.gzia001
 
  
   #將資料塞回原table   
   INSERT INTO gzidl_t SELECT * FROM azzi310_detail
   
   #刪除TEMP TABLE
   DROP TABLE azzi310_detail
   
   #end add-point
 
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi310_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   #add-point:delete段define(客製用)

   #end add-point     
   
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.gzial001 = g_gzia_m.gzia001
LET g_master_multi_table_t.gzial003 = g_gzia_m.gzial003
 
   
   CALL s_transaction_begin()
 
   OPEN azzi310_cl USING g_gzia_m.gzia001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003, 
       g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp, 
       g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt, 
       g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp_desc, 
       g_gzia_m.gziamodid_desc
   
   #檢查是否允許此動作
   IF NOT azzi310_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   CALL azzi310_show()
   
   #add-point:delete段before ask

   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL azzi310_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
  
  
      #資料備份
      LET g_gzia001_t = g_gzia_m.gzia001
 
 
      DELETE FROM gzia_t
       WHERE  gzia001 = g_gzia_m.gzia001
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gzia_m.gzia001 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後

      #end add-point
  
      #add-point:單身刪除前
    
      #end add-point
      
      DELETE FROM gzib_t
       WHERE  gzib001 = g_gzia_m.gzia001
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzib_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後

      #end add-point
      
            
                                                               
      #add-point:單身刪除前

      #end add-point
      DELETE FROM gzie_t
       WHERE 
             gzie001 = g_gzia_m.gzia001
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzie_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後

      #end add-point
 
      #add-point:單身刪除前
          LET g_detail_multi_table_t.gzidl001 = g_gzia_m.gzia001
      #end add-point
      DELETE FROM gzid_t
       WHERE 
             gzid001 = g_gzia_m.gzia001
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzid_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
       DELETE FROM gzif_t
       WHERE 
             gzif001 = g_gzia_m.gzia001
             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzif_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF   

       DELETE FROM gzig_t
       WHERE 
             gzig001 = g_gzia_m.gzia001
             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzig_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM gzic_t
       WHERE 
             gzic001 = g_gzia_m.gzia001
             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzic_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL azzi310_delete_temptable()
#      CALL azzi310_gen_include_4gl()
      
      #end add-point
 
      
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE azzi310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gzib_d.clear() 
      CALL g_gzib2_d.clear()       
      CALL g_gzib3_d.clear()       
      #清空其他数组--修改程序框架增加
      CALL g_grouplist.clear()
      CALL g_sumylist1.clear()
      CALL g_sumylist2.clear()
      CALL g_tab.clear()
 
     
      CALL azzi310_ui_browser_refresh()  
      #CALL azzi310_ui_headershow()  
      #CALL azzi310_ui_detailshow()
      
      IF g_browser_cnt > 0 THEN 
         #CALL azzi310_browser_fill("")
         CALL azzi310_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
 
      #add-point:多語言刪除

      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.gzial001
   LET l_field_keys[01] = 'gzial001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzial_t')
 
      
      #單身多語言刪除
      
      
 
      
 
 
 
   
      #add-point:多語言刪除
    INITIALIZE l_var_keys_bak TO NULL 
    INITIALIZE l_field_keys   TO NULL 
    LET l_var_keys_bak[01] = g_detail_multi_table_t.gzidl001
    LET l_field_keys[01] = 'gzidl001'
    CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzidl_t')
      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   CLOSE azzi310_cl
 
   #功能已完成,通報訊息中心
   CALL azzi310_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi310_b_fill()
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define
    DEFINE l_gzib_d     type_g_gzib_d #160822-00021#1 add
   #end add-point     
   #add-point:b_fill段define(客製用)

   #end add-point     
 
   CALL g_gzib_d.clear()    #g_gzib_d 單頭及單身 
   CALL g_gzib2_d.clear()
   CALL g_gzib3_d.clear()
 
 
   #add-point:b_fill段sql_before
      CALL g_grouplist.clear()
      CALL g_sumylist1.clear()
      CALL g_sumylist2.clear()
   #end add-point
   
   #判斷是否填充
   IF azzi310_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  UNIQUE gzib002,gzib003,gzib005,gzib006,gzib004  FROM gzib_t",   
                     " INNER JOIN gzia_t ON gzia001 = gzib001 ",
 
                     #"",
                     
                     "",
                     
                     " WHERE gzib001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before

         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
        # LET g_sql = g_sql, " ORDER BY gzib_t.gzib002"   #mark 修改程序框架
         
         #add-point:單身填充控制
         LET g_sql = g_sql, " ORDER BY gzib_t.gzib003"
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi310_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi310_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_gzia_m.gzia001
 #160822-00021#1 mod(s)                                             
#      FOREACH b_fill_cs INTO g_gzib_d[l_ac].gzib002,g_gzib_d[l_ac].gzib003,g_gzib_d[l_ac].gzib005,g_gzib_d[l_ac].gzib006, 
#          g_gzib_d[l_ac].gzib004
      FOREACH b_fill_cs INTO l_gzib_d.gzib002,l_gzib_d.gzib003,l_gzib_d.gzib005,l_gzib_d.gzib006, 
          l_gzib_d.gzib004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
#         IF cl_null(g_gzib_d[l_ac].gzib004) THEN 
#            LET g_gzib_d[l_ac].gzib004 ='N'
#         END IF
         IF cl_null(l_gzib_d.gzib004) THEN 
            LET l_gzib_d.gzib004 ='N'
         END IF
         
#         LET g_sql=" SELECT dzebl003 FROM dzebl_t",   
#                    "  WHERE dzebl001 = '",g_gzib_d[l_ac].gzib002,"' AND dzebl002 = '",g_dlang,"'"                                                    
          LET g_sql=" SELECT dzebl003 FROM dzebl_t",   
                    "  WHERE dzebl001 = '",l_gzib_d.gzib002,"' AND dzebl002 = '",g_dlang,"'"                        
        PREPARE azzi310_l_pb FROM g_sql
         DECLARE b_fill_l_cs CURSOR FOR azzi310_l_pb
         #FOREACH b_fill_l_cs INTO g_gzib_d[l_ac].gzib002_desc
         FOREACH b_fill_l_cs INTO l_gzib_d.gzib002_desc
           IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
           END IF
           EXIT FOREACH
         END FOREACH
         LET g_gzib_d[l_gzib_d.gzib003].*=l_gzib_d.*
 #160822-00021#1 mod(e)            
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #判斷是否填充
   IF azzi310_fill_chk(2) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  UNIQUE gzie002,gzie003,gzie005  FROM gzie_t",   
                     " INNER JOIN gzia_t ON gzia001 = gzie001 ",
 
                     "",
                     
                     
                     " WHERE gzie001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before

         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzie_t.gzie002"
         
         #add-point:單身填充控制

         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi310_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR azzi310_pb2
      END IF
    
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_gzia_m.gzia001
                                               
      FOREACH b_fill_cs2 INTO g_gzib2_d[l_ac].gzie002,g_gzib2_d[l_ac].gzie003,g_gzib2_d[l_ac].gzie005 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF azzi310_fill_chk(3) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
        #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
#         LET g_sql = "SELECT  UNIQUE gzid002,gzid003,gzid004,gzid005,gzid006,gzid007,gzid008,gzid009, 
#             gzid010,gzid011,gzid012  FROM gzid_t",  
         #160901-00030#1mod add->gzid017  
         #160926-00005#1.2 mod add NVL
         #161121-00024#1mod add->gzid018
         LET g_sql = "SELECT  UNIQUE gzid002,gzid003,gzig002,gzid004,gzid005,gzid006,gzid007,gzid018,NVL(gzid008,'N'),gzid009, 
             NVL(gzid014,'N'),gzid015,gzid017,gzid010,gzid011,NVL(gzid012,'N') FROM gzid_t ", #160523-00002#2 add gzid014,gzid015
             #151214-00004#2 mod(e)
                     " INNER JOIN gzia_t ON gzia001 = gzid001 ",
 
                     " LEFT OUTER JOIN gzig_t ON gzig001=gzid001 AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=gzid003 ", #151214-00004#2 add  #增加资料表别名的信息，解决一表多用问题                   
                     
                     " WHERE gzid001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before

         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzid_t.gzid002"
         
         #add-point:單身填充控制

         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi310_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR azzi310_pb3
      END IF
    
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_gzia_m.gzia001
      #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题                                     
#      FOREACH b_fill_cs3 INTO g_gzib3_d[l_ac].gzid002,g_gzib3_d[l_ac].gzid003,g_gzib3_d[l_ac].gzid004,
       FOREACH b_fill_cs3 INTO g_gzib3_d[l_ac].gzid002,g_gzib3_d[l_ac].gzid003,g_gzib3_d[l_ac].gzig002,g_gzib3_d[l_ac].gzid004,
      #151214-00004#2 mod(e) #160901-00030#1mod add->gzid017  
      #161121-00024#1mod add->gzid018      
          g_gzib3_d[l_ac].gzid005,g_gzib3_d[l_ac].gzid006,g_gzib3_d[l_ac].gzid007,g_gzib3_d[l_ac].gzid018,g_gzib3_d[l_ac].gzid008, 
          g_gzib3_d[l_ac].gzid009,g_gzib3_d[l_ac].gzid014,g_gzib3_d[l_ac].gzid015 #160523-00002#2 add gzid014,gzid015   
          ,g_gzib3_d[l_ac].gzid017
          ,g_gzib3_d[l_ac].gzid010,g_gzib3_d[l_ac].gzid011,g_gzib3_d[l_ac].gzid012
                
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
          IF cl_null(g_gzib3_d[l_ac].gzig002) THEN
             LET g_gzib3_d[l_ac].gzig002=g_gzib3_d[l_ac].gzid003
          END IF
         #读入ref值
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] =  g_gzia_m.gzia001
         LET g_ref_fields[2] = g_gzib3_d[l_ac].gzid002
         CALL ap_ref_array2(g_ref_fields," SELECT gzidl004 FROM gzidl_t WHERE gzidl001 = ? AND gzidl002= ? AND gzidl003 = '"||g_lang||"'","") RETURNING g_rtn_fields
         LET g_gzib3_d[l_ac].gzidl004 = g_rtn_fields[1]
#      LET g_sql = "SELECT gzidl004 ",
#                  " FROM  gzidl_t ",
#                  " WHERE gzidl002='",g_gzib3_d[l_ac].gzid002,"' and gzidl003='",g_dlang,"' ",
#                  "   AND gzidl001 = '",g_gzia_m.gzia001,"'"
#         PREPARE azzi310_l_pb3 FROM g_sql
#         DECLARE b_fill_l_cs3 CURSOR FOR azzi310_l_pb3
#         FOREACH b_fill_l_cs3 INTO g_gzib3_d[l_ac].gzidl004
#          IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "FOREACH:" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            EXIT FOREACH
#          END IF
#           EXIT FOREACH
#         END FOREACH
         
        IF g_gzib3_d[l_ac].gzidl004 is NULL THEN
        #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
#   	  	  SELECT dzebl003 INTO g_gzib3_d[l_ac].gzidl004 FROM dzebl_t 
#   	  	   WHERE dzebl001=g_gzib3_d[l_ac].gzid004
#   	  	     AND dzebl000=g_gzib3_d[l_ac].gzid003
#   	  	     AND dzebl002=g_dlang
           #160523-00002#1 mod (s)
   	  	  SELECT dzebl003 INTO g_gzib3_d[l_ac].gzidl004 FROM dzebl_t,gzig_t
   	  	   WHERE dzebl001=g_gzib3_d[l_ac].gzid004
   	  	     AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=g_gzib3_d[l_ac].gzid003
   	  	     AND dzebl002=g_dlang
   	  	     AND gzig001=g_gzia_m.gzia001
#   	  	   WHERE dzebl000=gzig002
#   	  	     AND dzebl001=g_gzib3_d[l_ac].gzid004
#   	  	     AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=g_gzib3_d[l_ac].gzid003
#   	  	     AND dzebl002=g_dlang
#   	  	     AND gzig001=g_gzia_m.gzia001
            #160523-00002#1 mod (e)
   	  	     
   	  	  
   	  	  IF SQLCA.sqlcode AND SQLCA.SQLCODE != 100THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "search gzidl004:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
           END IF
       #151214-00004#2 mod(e)	       
   	  END IF
   	   #LET g_detail3_attr[l_ac].gzid004="blue underline"   #test1
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理
#       CALL azzi310_gzib_b_fill()
#       CALL azzi310_gzie_b_fill()
#       CALL azzi310_gzid_b_fill()
       CALL azzi310_grouplist_b_fill()
       CALL azzi310_sumy1_b_fill()
       CALL azzi310_sumy2_b_fill() 
       
   #end add-point
   
   #CALL g_gzib_d.deleteElement(g_gzib_d.getLength()) #160822-00021# mark
   CALL g_gzib2_d.deleteElement(g_gzib2_d.getLength())
   CALL g_gzib3_d.deleteElement(g_gzib3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE azzi310_pb
   FREE azzi310_pb2
 
   FREE azzi310_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzib_d.getLength()
      LET g_gzib_d_mask_o[l_ac].* =  g_gzib_d[l_ac].*
      CALL azzi310_gzib_t_mask()
      LET g_gzib_d_mask_n[l_ac].* =  g_gzib_d[l_ac].*
   END FOR
   
   LET g_gzib2_d_mask_o.* =  g_gzib2_d.*
   FOR l_ac = 1 TO g_gzib2_d.getLength()
      LET g_gzib2_d_mask_o[l_ac].* =  g_gzib2_d[l_ac].*
      CALL azzi310_gzie_t_mask()
      LET g_gzib2_d_mask_n[l_ac].* =  g_gzib2_d[l_ac].*
   END FOR
   LET g_gzib3_d_mask_o.* =  g_gzib3_d.*
   FOR l_ac = 1 TO g_gzib3_d.getLength()
      LET g_gzib3_d_mask_o[l_ac].* =  g_gzib3_d[l_ac].*
      CALL azzi310_gzid_t_mask()
      LET g_gzib3_d_mask_n[l_ac].* =  g_gzib3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi310_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define
   
   #end add-point     
   #add-point:delete_b段define(客製用)
   
   #end add-point     
 
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM gzib_t
       WHERE 
         gzib001 = ps_keys_bak[1] AND gzib002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gzib_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM gzie_t
       WHERE 
             gzie001 = ps_keys_bak[1] AND gzie002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzie_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_gzib2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM gzid_t
       WHERE 
             gzid001 = ps_keys_bak[1] AND gzid002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzid_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_gzib3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi310_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define

   #end add-point     
   #add-point:insert_b段define(客製用)

   #end add-point     
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO gzib_t
                  (
                   gzib001,
                   gzib002
                   ,gzib003,gzib005,gzib006,gzib004) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzib_d[g_detail_idx].gzib003,g_gzib_d[g_detail_idx].gzib005,g_gzib_d[g_detail_idx].gzib006, 
                       g_gzib_d[g_detail_idx].gzib004)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzib_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gzib_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後

      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO gzie_t
                  (
                   gzie001,
                   gzie002
                   ,gzie003,gzie005) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzib2_d[g_detail_idx].gzie003,g_gzib2_d[g_detail_idx].gzie005)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzie_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_gzib2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO gzid_t
                  (
                   gzid001,
                   gzid002
                   ,gzid003,gzid004,gzid005,gzid006,gzid007,gzid008,gzid009,gzid010,gzid011,gzid012,gzid014,gizd015,gzid017) #160523-00002#2 add gzid014,gzid015
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzib3_d[g_detail_idx].gzid003,g_gzib3_d[g_detail_idx].gzid004,g_gzib3_d[g_detail_idx].gzid005, 
                       g_gzib3_d[g_detail_idx].gzid006,g_gzib3_d[g_detail_idx].gzid007,g_gzib3_d[g_detail_idx].gzid008, 
                       g_gzib3_d[g_detail_idx].gzid009,g_gzib3_d[g_detail_idx].gzid010,g_gzib3_d[g_detail_idx].gzid011, 
                       g_gzib3_d[g_detail_idx].gzid012,g_gzib3_d[g_detail_idx].gzid014,g_gzib3_d[g_detail_idx].gzid015,#160523-00002#2 add gzid014,gzid015
                       g_gzib3_d[g_detail_idx].gzid017) #160901-00030#1mod add->gzid017   
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzid_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_gzib3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other

   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point   
   #add-point:update_b段define(客製用)

   #end add-point   
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzib_t" THEN
      #add-point:update_b段修改前

      #end add-point 
      
      #將遮罩欄位還原
      CALL azzi310_gzib_t_mask_restore('restore_mask_o')
               
      UPDATE gzib_t 
         SET (gzib001,
              gzib002
              ,gzib003,gzib005,gzib006,gzib004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzib_d[g_detail_idx].gzib003,g_gzib_d[g_detail_idx].gzib005,g_gzib_d[g_detail_idx].gzib006, 
                  g_gzib_d[g_detail_idx].gzib004) 
         WHERE  gzib001 = ps_keys_bak[1] AND gzib002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzib_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzib_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi310_gzib_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後

      #end add-point  
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzie_t" THEN
      #add-point:update_b段修改前

      #end add-point  
      
      #將遮罩欄位還原
      CALL azzi310_gzie_t_mask_restore('restore_mask_o')
               
      UPDATE gzie_t 
         SET (gzie001,
              gzie002
              ,gzie003,gzie005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzib2_d[g_detail_idx].gzie003,g_gzib2_d[g_detail_idx].gzie005) 
         WHERE  gzie001 = ps_keys_bak[1] AND gzie002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzie_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzie_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi310_gzie_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後

      #end add-point  
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzid_t" THEN
      #add-point:update_b段修改前

      #end add-point  
      
      #將遮罩欄位還原
      CALL azzi310_gzid_t_mask_restore('restore_mask_o')
               
     #160901-00030#1mod add->gzid017    
     #161121-00024#1mod add->gzid018      
     UPDATE gzid_t 
         SET (gzid001,
              gzid002
              ,gzid003,gzid004,gzid005,gzid006,gzid007,gzid008,gzid009,gzid010,gzid011,gzid012,gzid014,gzid015,gzid017  #160523-00002#2 add gzid014,gzid015
              ,gzid018)
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzib3_d[g_detail_idx].gzid003,g_gzib3_d[g_detail_idx].gzid004,g_gzib3_d[g_detail_idx].gzid005, 
                  g_gzib3_d[g_detail_idx].gzid006,g_gzib3_d[g_detail_idx].gzid007,g_gzib3_d[g_detail_idx].gzid008, 
                  g_gzib3_d[g_detail_idx].gzid009,g_gzib3_d[g_detail_idx].gzid010,g_gzib3_d[g_detail_idx].gzid011, 
                  g_gzib3_d[g_detail_idx].gzid012,g_gzib3_d[g_detail_idx].gzid014,g_gzib3_d[g_detail_idx].gzid015,#160523-00002#2 add gzid014,gzid015
                  g_gzib3_d[g_detail_idx].gzid017,g_gzib3_d[g_detail_idx].gzid018) 
         WHERE  gzid001 = ps_keys_bak[1] AND gzid002 = ps_keys_bak[2]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzid_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzid_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi310_gzid_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後

      #end add-point  
   END IF
 
 
   
 
   
   #add-point:update_b段other

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION azzi310_key_update_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define(客製用)
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi310_key_delete_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define
   
   #end add-point
   #add-point:delete_b段define(客製用)
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi310_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define(客製用)
   
   #end add-point   
    
   #先刷新資料
   #CALL azzi310_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gzib_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN azzi310_bcl USING 
                                       g_gzia_m.gzia001,g_gzib_d[g_detail_idx].gzib002     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi310_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "gzie_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi310_bcl2 USING 
                                             g_gzia_m.gzia001,g_gzib2_d[g_detail_idx].gzie002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi310_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "gzid_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi310_bcl3 USING 
                                             g_gzia_m.gzia001,g_gzib3_d[g_detail_idx].gzid002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi310_bcl3" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi310_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define(客製用)
   
   #end add-point  
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi310_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi310_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi310_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi310_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
   #add-point:set_entry段define(客製用)
   
   #end add-point       
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzia001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   IF g_action_choice="sqledit" THEN
   	  CALL cl_set_comp_entry("gzia006",TRUE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi310_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define(客製用)
   
   #end add-point     
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzia001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制
      CALL cl_set_comp_entry("gzia006",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("",FALSE)
   END IF 
   
   #add-point:set_no_entry段欄位控制後
    IF p_cmd="a" THEN     
       CALL cl_set_comp_entry("gzia006",FALSE)
    END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi310_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define

   #end add-point     
   #add-point:set_entry_b段define(客製用)

   #end add-point     
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制

      #end add-point  
   END IF
   
   #add-point:set_entry_b段
    IF g_gzib3_d[l_ac].gzid008='Y' THEN
       CALL cl_set_comp_entry("gzid009",TRUE)
    END IF
    IF g_gzib3_d[l_ac].gzid010='Z' THEN
       CALL cl_set_comp_entry("gzid011",TRUE)
    END If    
    #160523-00002#2 add(s)
    IF g_gzib3_d[l_ac].gzid014='Y' THEN
       CALL cl_set_comp_entry("gzid015,gzid017",TRUE)
    END IF
    #160523-00002#2 add(e)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi310_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段define(客製用)
   
   #end add-point    
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段
     IF g_gzib3_d[l_ac].gzid008 ='N' OR g_gzib3_d[l_ac].gzid008 IS NULL THEN
       CALL cl_set_comp_entry("gzid009",FALSE)
    END IF 
     #160523-00002#2 add(s)
   IF g_gzib3_d[l_ac].gzid014 ='N' OR g_gzib3_d[l_ac].gzid014 IS NULL THEN
       CALL cl_set_comp_entry("gzid015,gzid017",FALSE)
    END IF 
    #160523-00002#2 add(e)
      CALL cl_set_comp_entry("gzib002,gzib003,gzib002_desc,gzid002,gzid003,gzie002,gzie003,gzid007,gzid011",FALSE)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi310_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段define(客製用)
   
   #end add-point   
   #add-point:set_act_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi310_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段define(客製用)
   
   #end add-point   
   #add-point:set_act_no_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi310_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段define(客製用)
   
   #end add-point   
   #add-point:set_act_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi310_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段define(客製用)
   
   #end add-point   
   #add-point:set_act_no_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi310_default_search()
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define
   #DEFINE ls_js  STRING #test

   #end add-point  
   #add-point:default_search段define(客製用)

   #end add-point  
   
   #add-point:default_search段開始前

   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   #test
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzia001 = '", g_argv[01], "' AND "
   END IF
   #test
#   DISPLAY "arg1:",g_argv[01]
#   LET ls_js = g_argv[01]  #接收傳入的ls_js
#   CALL util.JSON.parse(ls_js,g_input)
#   LET g_gzia_m.gzia001=g_input.gzia001
#   IF NOT cl_null(ls_js) THEN
#      IF NOT cl_null(g_input.gzia001) THEN
#         LET ls_wc=ls_wc," gzia001 = '", g_input.gzia001, "' AND "
#      END IF
#      IF NOT cl_null(g_input.gzia005) THEN
#         LET ls_wc=ls_wc," gzia005 = '", g_input.gzia005, "' AND "
#      END IF
#      IF NOT cl_null(g_input.gziaownid) THEN
#         LET ls_wc=ls_wc," gziaownid = '", g_input.gziaownid, "' AND "
#      END IF
#   END IF
#   DISPLAY "ls_wc:",ls_wc
   #test
   
 
   
   #add-point:default_search段after sql

   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "gzia_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gzib_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gzie_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "gzid_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前

   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.state_change" >}
   #應用 a09 樣板自動產生(Version:12)
#+ 確認碼變更 
PRIVATE FUNCTION azzi310_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   
   #end add-point  
   #add-point:statechange段define(客製用)
   
   #end add-point  
   
   #add-point:statechange段開始前
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN azzi310_cl USING g_gzia_m.gzia001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzia003, 
       g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaowndp, 
       g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamoddt, 
       g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp_desc, 
       g_gzia_m.gziamodid_desc
 
   #檢查是否允許此動作
   IF NOT azzi310_action_chk() THEN
      CLOSE azzi310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
       g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaownid_desc, 
       g_gzia_m.gziaowndp,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp, 
       g_gzia_m.gziacrtdp_desc,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamodid_desc,g_gzia_m.gziamoddt, 
       g_gzia_m.groupname,g_gzia_m.sumyname1,g_gzia_m.comb_sumy,g_gzia_m.s_global_var
 
   CASE g_gzia_m.gziastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gzia_m.gziastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_gzia_m.gziastus = lc_state OR cl_null(lc_state) THEN
      CLOSE azzi310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前
   
   #end add-point
   
   LET g_gzia_m.gziamodid = g_user
   LET g_gzia_m.gziamoddt = cl_get_current()
   LET g_gzia_m.gziastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gzia_t 
      SET (gziastus,gziamodid,gziamoddt) 
        = (g_gzia_m.gziastus,g_gzia_m.gziamodid,g_gzia_m.gziamoddt)     
    WHERE  gzia001 = g_gzia_m.gzia001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE azzi310_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001,g_gzia_m.gzia002, 
          g_gzia_m.gzia003,g_gzia_m.gzia005,g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid, 
          g_gzia_m.gziaowndp,g_gzia_m.gziacrtid,g_gzia_m.gziacrtdp,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid, 
          g_gzia_m.gziamoddt,g_gzia_m.gziaownid_desc,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid_desc, 
          g_gzia_m.gziacrtdp_desc,g_gzia_m.gziamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.gzia002,g_gzia_m.gzial003,g_gzia_m.gzia003,g_gzia_m.gzia005, 
          g_gzia_m.gzia004,g_gzia_m.gzia006,g_gzia_m.gziastus,g_gzia_m.gziaownid,g_gzia_m.gziaownid_desc, 
          g_gzia_m.gziaowndp,g_gzia_m.gziaowndp_desc,g_gzia_m.gziacrtid,g_gzia_m.gziacrtid_desc,g_gzia_m.gziacrtdp, 
          g_gzia_m.gziacrtdp_desc,g_gzia_m.gziacrtdt,g_gzia_m.gziamodid,g_gzia_m.gziamodid_desc,g_gzia_m.gziamoddt, 
          g_gzia_m.groupname,g_gzia_m.sumyname1,g_gzia_m.comb_sumy,g_gzia_m.s_global_var
   END IF
 
   #add-point:stus修改後
   
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
   CLOSE azzi310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi310_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi310_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   #add-point:idx_chk段define(客製用)
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gzib_d.getLength() THEN
         LET g_detail_idx = g_gzib_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzib_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzib_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gzib2_d.getLength() THEN
         LET g_detail_idx = g_gzib2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzib2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzib2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_gzib3_d.getLength() THEN
         LET g_detail_idx = g_gzib3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzib3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzib3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi310_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   #add-point:b_fill2段define(客製用)
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL azzi310_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi310_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   #add-point:fill_chk段define(客製用)
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310.status_show" >}
PRIVATE FUNCTION azzi310_status_show()
   #add-point:status_show段define
   
   #end add-point
   #add-point:status_show段define(客製用)
   
   #end add-point
   
   #add-point:status_show段status_show
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi310.mask_functions" >}
&include "erp/azz/azzi310_mask.4gl"
 
{</section>}
 
{<section id="azzi310.signature" >}
   
 
{</section>}
 
{<section id="azzi310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi310_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzia_m.gzia001
   LET g_pk_array[1].column = 'gzia001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="azzi310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:3)
PRIVATE FUNCTION azzi310_msgcentre_notify(lc_state)
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define
   
   #end add-point
   #add-point:msgcentre_notify段define
   
   #end add-point   
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL azzi310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzia_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION azzi310_action_chk()
   #add-point:action_chk段define
   
   #end add-point
   #add-point:action_chk段define(客製用)
   
   #end add-point
   
   #add-point:action_chk段action_chk
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 以程式方式调用打印入口
# Memo...........:
# Usage..........: CALL azzi310_cmdrun()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150/07/09 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_cmdrun()
   DEFINE   l_str              STRING
   DEFINE   l_p                LIKE type_t.num5
   DEFINE   l_arg              STRING
   DEFINE   l_i                LIKE type_t.num5
   DEFINE   l_argv          DYNAMIC ARRAY OF STRING     #所有外部參數
   DEFINE   l_json_wc       STRING                   #160523-00002#2 add --传人json
   DEFINE   obj             util.JSONObject          #160523-00002#2 add --传人json

       SELECT COUNT(*) INTO l_p FROM gzia_t
         WHERE gzia001 = g_gzia_m.gzia001 
       IF l_p = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend =g_gzia_m.gzia001 
           LET g_errparam.code   = "azz-00913"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN
       END IF
        #160523-00002#2 mark(s)
#       SELECT gzia006,gzia003,gziastus INTO g_gzia_m.gzia006,g_gzia_m.gzia003,g_gzia_m.gziastus FROM gzia_t
#        WHERE gzia001= g_gzia_m.gzia001 
#       IF g_gzia_m.gzia006 IS NULL THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.extend =g_gzia_m.gzia001 
#           LET g_errparam.code   = "azz-00914"
#           LET g_errparam.popup  = TRUE
#           CALL cl_err()
#          RETURN
#       END IF      
        #160523-00002#2 mark(e)
        
       IF NOT CL_NULL(g_argv[02]) THEN
           LET obj = util.JSONObject.parse(g_argv[02])
           LET l_json_wc=obj.get("wc")
           DISPLAY "json wc:", l_json_wc
           IF NOT cl_null(l_json_wc) THEN
              LET l_json_wc=g_argv[02]
           END IF
       END IF
#       LET l_argv[1]=g_argv[02]
#       LET l_argv[2]=g_argv[03]
#       LET l_argv[3]=g_argv[04]
#       LET l_argv[4]=g_argv[05]
#       LET l_argv[5]=g_argv[06]
#       LET l_argv[6]=g_argv[07]
#       LET l_argv[7]=g_argv[08]
#       LET l_argv[8]=g_argv[09]
#       LET l_argv[9]=g_argv[10]
#       LET g_gzia_m.gzia006=azzi310_01_arg_replace(g_gzia_m.gzia006) #160523-00002#2 mark

       CALL azzi310_out("V",l_json_wc) #160523-00002#2 mod 增加参数"V",l_wc --传人json参数, 需要根据json过滤模式还是其他模式决定是否是F还是V 
END FUNCTION

################################################################################
# Descriptions...: 打印输出入口
# Memo...........:
# Usage..........: CALL azzi310_out(p_flag)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/09 By chenjpa
# Modify.........: 2016/06/21 #160523-00002#2 add p_flag,p_wc
################################################################################
PRIVATE FUNCTION azzi310_out(p_flag,p_wc)
  DEFINE p_flag LIKE type_t.chr1 #160523-00002#2 add  --传人json参数
  DEFINE p_wc   STRING           #160523-00002#2 add  --传人json参数
  DEFINE l_str  STRING
   
 
    IF g_gzia_m.gzia001 IS NULL THEN
       RETURN
    END IF
    #160523-00002#2 mark(s)
#    IF g_gzia_m.gziastus ='N' THEN
#       RETURN
#    END IF
   IF cl_null(p_wc) THEN
    LET l_str = g_gzia_m.gzia006
#    IF l_str IS NULL THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = g_browser_cnt
#         LET g_errparam.code   = "azz-00790" 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#       RETURN
#    END IF
    IF l_str.getIndexOf('arg',1) > 0  THEN
       INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = "azz-00791" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
       RETURN 
    END IF
   END IF
  #160523-00002#2 mark(e)
    #CALL azzi310_01(g_gzia_m.gzia001,g_gzia_m.gzia003,l_str,p_flag,p_wc)  #160523-00002#2 add p_flag,p_wc
    CALL azzi310_01(g_gzia_m.gzia001,p_flag,p_wc)#160523-00002#2 mod #传人json
    CALL cl_set_toolbaritem_visible("accept,cancel,home,logistics,personalwork,agendum,insert,modify,delete,reproduce,output,quickprint,query,filter,qbe_select,qbe_save,help,related_document",true)    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_create_temptable (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/09 By chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_create_temptable()

    DROP TABLE azzi310_xabd

    CREATE TEMP TABLE azzi310_xabd(
      xabd001  LIKE type_t.num5,    #序號
      xabd002  LIKE type_t.chr1000, #数据表代号
      xabd003  LIKE type_t.chr1000, #欄位代号(暂存)
      xabd004  LIKE type_t.num5,    #画面宽度     
      xabd005  LIKE type_t.num10,   #欄位小數點長度 
      xabd006  LIKE type_t.chr20,   #欄位資料型態
      xabd007  LIKE type_t.chr10,   #标志位
      xabd008  LIKE type_t.chr1000, #别名 
      xabd009  LIKE type_t.chr1000,  #显示名称
      xabd010 LIKE type_t.chr20  #栏位属性
      ) 
          
#   CREATE TEMP TABLE azzi310_gzia_tmp
#   (
#   dzgastus   VARCHAR(10),
#   gzia001    VARCHAR(20),
#   gzia002    VARCHAR(1),   
#   gzia003    VARCHAR(1),
#   gzia004    VARCHAR(1),
#   gzia005    INTEGER,      
#   gzia006    VARCHAR(2000), 
#   gziaownid  VARCHAR(10),
#   gziaowndp  VARCHAR(10),
#   gziacrtid  VARCHAR(10),
#   gziacrtdp  VARCHAR(10),
#   gziacrtdt  DATE,
#   gziamodid  VARCHAR(10),
#   gziamoddt  DATE
#   );
#      
#   #gzib_t群組明細
#   CREATE TEMP TABLE azzi310_gzib_tmp
#   (
#   gzib001    VARCHAR(20),
#   gzib002    VARCHAR(40),       #栏位
#   gzib003    SMALLINT,          #顺序
#   paging     VARCHAR(1),        #跳页
#   group1     VARCHAR(1),        #群组   
#   sort       VARCHAR(1)         #排序   
#   );
#
#   #gzic_t 汇总
#   CREATE TEMP TABLE azzi310_gzic_tmp
#   (
#   gzic001    VARCHAR(20),   
#   gzic002    SMALLINT,    
#   gzic003    VARCHAR(1),        
#   gzic004    VARCHAR(1),   
#   gzic005    VARCHAR(80),
#   gzic006    VARCHAR(255),
#   gzic007    VARCHAR(1) 
#   );
#
   #彙總已選右邊樹狀明細
  DROP TABLE azzi310_tmp01 #160523-00002#1 add        #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
   CREATE TEMP TABLE azzi310_tmp01                    
   (
    gzic001    VARCHAR(20),    
    gzic002    SMALLINT,
    id2        VARCHAR(20),  #gzic002对应的栏位id(gzid002->gzid004)
    gzic004    VARCHAR(1),   #->'Y',父节点->'N'
    gzic005    SMALLINT,
    pid2       VARCHAR(20),  #gzic005对应的栏位id(gzib003->gzib002)
    type2      VARCHAR(1),    #->gzic003
    pidseq2    SMALLINT,        #判斷是否為節點,1父节点,0子节点
    gzic006    VARCHAR(500),
    gzic007    VARCHAR(1)     #1->栏位名称+计算式,2->计算式 3->隐藏
   );

#   #參數頁籤明細  
#   CREATE TEMP TABLE azzi310_gzie_tmp
#   (
#    gzie001    VARCHAR(20),   
#    gzie002    SMALLINT,
#    gzie003    VARCHAR(60),
#    gzie004    VARCHAR(20),
#    gzie005    VARCHAR(80)    
#   );   
#
#   #qbe开窗查询
#   CREATE TEMP TABLE azzi310_gzid_tmp
#   (
#   gzid001    VARCHAR(20),         #查询单
#   gzid002    SMALLINT,            #序号
#   gzid003    VARCHAR(15),         #资料表代号
#   gzid004    VARCHAR(20),         #栏位代号
#   gzidl004   VARCHAR(500),         #栏位名称
#   gzid005    VARCHAR(1),          #列印显示设定
#   gzid006    INTEGER,             #画面栏位宽度
#   gzid007    INTEGER,             #查询视窗显示顺序
#   gzid008    VARCHAR(1),          #开窗
#   gzid009    VARCHAR(10),         #查询程式代码
#   gzid010    VARCHAR(1),          #栏位属性
#   gzid011    VARCHAR(20),         #币别栏位/小数位
#   gzid012    VARCHAR(1)           #资料转换   
#   );
#   
#   #自定义资料转换
#   CREATE TEMP TABLE azzi310_gzif_tmp
#   (
#   gzif001    VARCHAR(20),
#   gzif002    SMALLINT,
#   gzif003    VARCHAR(1),
#   gzif004    VARCHAR(80),
#   gzif005    VARCHAR(1),
#   gzif006    VARCHAR(80)       
#   );
#151214-00004#1 mod(s)
#   LET g_sql = " SELECT id2,dzebl003,type2,pidseq2 FROM azzi310_sum2_tmp ",    
#               "   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_dlang,"'", 
#               " WHERE gzic001 =? AND pid2 = ? ",                                                                           
#               " ORDER BY pidseq2,id2 "
   LET g_sql = " SELECT id2,gzidl004,type2,pidseq2 FROM azzi310_tmp01 ",      #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
               "   LEFT OUTER JOIN gzidl_t ON gzidl002 = gzic002 AND gzidl003 ='",g_dlang,"' AND gzidl001 = ? ", 
               " WHERE gzic001 =? AND pid2 = ? ",                                                                           
               " ORDER BY pidseq2,id2 "
#151214-00004#1 mod(e)
   PREPARE azzi310_sumy_getid_pre FROM g_sql
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
       #EXIT PROGRAM
   END IF
   DECLARE azzi310_sumy_getid_cs1 CURSOR FOR azzi310_sumy_getid_pre
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_save (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/09 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_save()

  # SELECT COUNT(*) INTO li_cnt FROM gzia_t WHERE gzia001 = g_gzia_m.gzia001                                              
  #                                          
  # IF li_cnt > 0 THEN
  #    LET g_gzia_m.gziamodid = g_user
  #    LET g_gzia_m.gziamoddt = cl_get_current()
  #    UPDATE gzia_t SET gzia002= g_gzia_m.gzia002,gzia003 = g_gzia_m.gzia003,
  #                      gzia004 = g_gzia_m.gzia004, gzia005 = g_gzia_m.gzia005,
  #                      gzia006 = g_gzia_m.gzia006
  #                      gziamodid = g_gzia_m.gziamodid, gziamoddt = g_gzia_m.gziamoddt                               
  #                WHERE gzia001 = g_gzia_m.gzia001                               
  #     
  # ELSE
  #    LET g_gzia_m.gziaownid = g_user
  #    LET g_gzia_m.gziaowndp = g_dept
  #    LET g_gzia_m.gziacrtid = g_user
  #    LET g_gzia_m.gziacrtdp = g_dept
  #    LET g_gzia_m.gziacrtdt = cl_get_current()
  #    LET g_gzia_m.gziastus = "Y"
  #    INSERT INTO gzia_t(gziastus, gzia001, gzia002, gzia003, gzia004,gzia005,gzia006, gziaownid, gziaowndp, gziacrtid, gziacrtdp, gziacrtdt) 
  #                VALUES(g_gzia_m.gziastus, g_gzia_m.gzia001, g_gzia_m.gzia002, g_gzia_m.gzia003, g_gzia_m.gzia004,g_gzia_m.gzia005,g_gzia_m.gzia006,
  #                       g_gzia_m.gziaownid, g_gzia_m.gziaowndp, g_gzia_m.gziacrtid, g_gzia_m.gziacrtdp, g_gzia_m.gziacrtdt,)
  #                  
  #                   
  # END IF
  # IF SQLCA.sqlcode THEN
  # ELSE
  #    DELETE FROM gzib_t WHERE gzib001 = g_gzia_m.gzia001  
      DELETE FROM gzic_t WHERE gzic001 = g_gzia_m.gzia001  
     # DELETE FROM gzid_t WHERE gzid001 = g_gzia_m.gzia001  
     # DELETE FROM gzif_t WHERE gzif001 = g_gzia_m.gzia001     
  #    DELETE FROM gzie_t WHERE gzie001 = g_gzia_m.gzia001


  #    INSERT INTO gzib_t
  #       SELECT * FROM azzi310_gzib_tmp WHERE gzib001 = g_gzia_m.gzia001                            
      INSERT INTO gzic_t
         SELECT gzic001,gzic002,type2,gzic004,gzic005,gzic006,gzic007 FROM azzi310_tmp01 WHERE gzic001 = g_gzia_m.gzia001       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01                                
       
   #160523-00002#1 add (s)
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'INSERT INTO gzic_t:'
       LET g_errparam.popup = FALSE
       CALL cl_err()
       RETURN
       #EXIT PROGRAM
   END IF
   #160523-00002#1 add (e)
    # INSERT INTO gzid_t
     #    SELECT * FROM azzi310_gzid_tmp WHERE gzid001 = g_gzia_m.gzia001  
     # INSERT INTO gzif_t
     #    SELECT * FROM azzi310_gzif_tmp WHERE gzif001 = g_gzia_m.gzia001  
   #   INSERT INTO gzie_t
  #       SELECT * FROM azzi310_gzie_tmp WHERE gzie001 = g_gzia_m.gzia001  
   
   #END IF
       CALL azzi310_gziblist_b_fill()
       CALL azzi310_gzielist_b_fill()
       CALL azzi310_gzidlist_b_fill()
       CALL azzi310_grouplist_b_fill()
       CALL azzi310_sumy1_b_fill()
       CALL azzi310_sumy2_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 設計資料暫存檔寫入, 並預設帶出
# Memo...........:
# Usage..........: CALL azzi310_default (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..:2015/07/09 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_default()
  DEFINE li    SMALLINT 
   #先將暫存檔清空
   CALL azzi310_delete_temptable()

   #INSERT INTO azzi310_gzib_tmp SELECT * FROM gzib_t WHERE gzib001 =g_gzia_m.gzia001
   
   INSERT INTO azzi310_tmp01   #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01    
        SELECT  gzic001,gzic002,gzid004 id2,gzic004,gzic005,
                gzib002 pid2,gzic003,'0' pidseq2,gzic006,gzic007
          FROM (gzic_t t1 left outer join gzid_t on gzid001=gzic001 and gzid002=gzic002 AND gzid001=g_gzia_m.gzia001) 
                left outer join gzib_t on gzib001=gzib001 and gzib003=gzic005 AND gzib001=g_gzia_m.gzia001
        # WHERE gzic001=g_gzia_m.gzia001 AND gzic003!='6' #mod 20160120 防止汇总右边修改计算方式导致错误
        WHERE gzic001=g_gzia_m.gzia001 AND gzic006='c'        

  INSERT INTO azzi310_tmp01   #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01    
        SELECT  gzic001,gzic002,t2.gzib002 id2,gzic004,gzic005,
                t3.gzib002 pid2,gzic003,'1' pidseq2,gzic006,gzic007
          FROM (gzic_t t1 left outer join gzib_t t2 on t2.gzib001=gzic001 and t2.gzib003=gzic002 AND t2.gzib001=g_gzia_m.gzia001) 
                left outer join gzib_t t3 on t3.gzib001=gzic001 and t3.gzib003=gzic005 AND t3.gzib001=g_gzia_m.gzia001
         #WHERE gzic001=g_gzia_m.gzia001 AND gzic003='6'
         WHERE gzic001=g_gzia_m.gzia001 AND gzic006='p'
       
  UPDATE azzi310_tmp01 SET pid2='0' WHERE pid2 IS NULl     #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01

  #LET g_sql="SELECT gzig002 FROM gzig_t WHERE gzig001='",g_gzia_m.gzia001,"'"
  LET g_sql="SELECT gzig002,gzig003 FROM gzig_t WHERE gzig001='",g_gzia_m.gzia001,"'" #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
  PREPARE azzi310_gzig_sel_pre FROM g_sql
  DECLARE azzi310_gzig_sel_curs CURSOR FOR azzi310_gzig_sel_pre
  LET li=1
  #FOREACH azzi310_gzig_sel_curs INTO g_tab[li].tabname
  FOREACH azzi310_gzig_sel_curs INTO g_tab[li].tabname,g_tab[li].tabalias #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
      LET li=li+1
  END FOREACH
  CALL g_tab.deleteElement(li)
  LET li=li-1  
  LET g_tab_cnt=li
END FUNCTION

################################################################################
# Descriptions...: 刪除此報表元件table
# Memo...........:
# Usage..........: azzi310_delete_temptable (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/09 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_delete_temptable()
   #先將暫存檔清空
  
    DELETE FROM azzi310_tmp01       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
    
    #DELETE FROM azzi310_gzib_tmp
END FUNCTION

################################################################################
# Descriptions...: 確定欄位值是否存在tmp檔裡
# Memo...........:
# Usage..........: CALL azzi310_chk_filed_exist (ps_array,ps_filed1,ps_field2)
#                  RETURNING l_exits
# Input parameter: ps_array  需检查的record
#                : ps_field1 待检查栏位
#                : ps_field2 待检查栏位父亲栏位
# Return code....: l_exit    bool
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_chk_field_exist(ps_array,ps_field,ps_field1)
DEFINE ps_array   STRING
   DEFINE ps_field   STRING
   DEFINE ps_field1  STRING
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_field   STRING
   DEFINE ls_field1  STRING 
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE ls_key3    STRING    
   DEFINE ls_key4    STRING    
   DEFINE  l_sql     STRING
   DEFINE l_dzeb007  LIKE dzeb_t.dzeb007

   #array對應的Table及順序欄位指定
   CASE ps_array
      WHEN "s_detail1"   
         LET ls_table = "gzib_t"
         LET ls_key1 = "gzib001"
         LET ls_field = "gzib002"  
        LET g_sql = " SELECT COUNT(*) FROM ",ls_table,
                " WHERE ",ls_key1," = '", g_gzia_m.gzia001,"' AND ",ls_field," = '",ps_field,"'" 
                
      WHEN "s_sumylist2"   
         LET ls_table = "azzi310_tmp01"       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
         LET ls_key1 = "gzic001"
         LET ls_field = "id2"
         LET ls_field1 = "pid2"
        
   
      LET g_sql = " SELECT COUNT(*) FROM ",ls_table,
                  " WHERE ",ls_key1," = '", g_gzia_m.gzia001,"' AND ",ls_field," = '",ps_field,"' AND ",ls_field1," = '",ps_field1,"'"
                  
         LET l_dzeb007=""
         LET l_sql="SELECT gzid013 FROM gzid_t WHERE gzid004 ='",ps_field,"' AND gzid001='",g_gzia_m.gzia001,"'"
         PREPARE sel_type_cs0_pre FROM l_sql
         DECLARE sel_type_cs0 CURSOR FOR sel_type_cs0_pre
         FOREACH sel_type_cs0 INTO l_dzeb007
            EXIT FOREACH
         END FOREACH
         
         IF l_dzeb007 IS NULL THEN
            LET l_sql="SELECT dzeb007 FROM dzeb_t WHERE dzeb002 ='",ps_field,"'"
            PREPARE sel_type_cs_pre FROM l_sql
            DECLARE sel_type_cs CURSOR FOR sel_type_cs_pre
            FOREACH sel_type_cs INTO l_dzeb007
              EXIT FOREACH
            END FOREACH
         END IF
          
         IF l_dzeb007 IS NULL THEN
           LET l_sql="SELECT data_type FROM user_tab_columns WHERE lower(column_name) ='",ps_field,"'"
           PREPARE sel_type_cs_pre1 FROM l_sql
           DECLARE sel_type_cs1 CURSOR FOR sel_type_cs_pre1
           FOREACH sel_type_cs1 INTO l_dzeb007
             EXIT FOREACH
           END FOREACH
         END IF
         
         IF l_dzeb007='number' OR l_dzeb007='NUMBER' THEN
         ELSE
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "azz-00919"
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
         
             
         
   END CASE
   LET l_cnt = 0
   #找尋暫存檔裡是否有欄位
#   
#      LET g_sql = " SELECT COUNT(*) FROM ",ls_table,
#                  " WHERE ",ls_key1," = '", g_gzia_m.gzia001,"' AND ",ls_field," = '",ps_field,"'"
   #END IF 
               
   PREPARE chk_field_exist_pre FROM g_sql

   DECLARE chk_field_exist_curs CURSOR FOR chk_field_exist_pre
   FOREACH chk_field_exist_curs INTO l_cnt  
     IF SQLCA.sqlcode THEN
       EXIT FOREACH
     END IF
   END FOREACH 
   
   IF l_cnt = 0 THEN 
      RETURN TRUE
   ELSE 
      RETURN FALSE
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 获取栏位信息
# Memo...........:
# Usage..........: CALL azzi310_get_column_info (p_dbname,p_tabname,p_tabalias,p_colname,p_flag)
#                  RETURNING 回传参数
# Input parameter: p_dbname   库名
#                : p_tabname  资料档名
#                : p_tabalias 资料档别名
#                : p_colname  栏位名
#                : p_colalias 栏位别名
#                : p_flag     标志是否要insert
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/13 by chenjpa 
# Modify.........: 2015/12/14 by chenjpa 151214-00004#1 增加p_flag 
# Modify.........: 2016/07/25 by chenjpa 160721-00005#1 增加p_colalais 
################################################################################
PUBLIC FUNCTION azzi310_get_column_info(p_dbname,p_tabname,p_tabalias,p_colname,p_colalias,p_flag)
   DEFINE p_dbname    VARCHAR(20)
   DEFINE p_tabname   VARCHAR(20)         
   DEFINE p_tabalias  VARCHAR(20)          #151214-00004#1 mod
   DEFINE p_colname   VARCHAR(1000)          #160901-00030#1 mod 20>500
   DEFINE p_colalias  VARCHAR(50)          #160721-00005#1 add
   DEFINE l_colalias  VARCHAR(50)          #160721-00005#1 add
   DEFINE p_flag      STRING               #151214-00004#1 add
   DEFINE l_colname1  STRING
   DEFINE l_db_type   VARCHAR(3)
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING
   DEFINE l_exesql    STRING
   DEFINE l_tmp       STRING
   DEFINE l_dbname    STRING
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_module    LIKE dzea_t.dzea003
   DEFINE l_gztd010   LIKE gztd_t.gztd010
   DEFINE l_gztd012   STRING
   DEFINE l_gztd001   LIKE gztd_t.gztd001
   DEFINE l_len       LIKE type_t.num5
   DEFINE l_viewname  VARCHAR(20)  #160523-00002#1 add

   LET l_db_type='ORA'
   #db_get_database_type() = "ORA"


   LET p_tabname = p_tabname CLIPPED
    #151214-00004#1 mod(s)
   IF cl_null(p_tabname) THEN
   	  #LET l_colname1=p_colname
   	  #LET p_tabname=l_colname1.subString(1,4),'%_t'
   	  LET p_tabname=cl_get_tableid(p_colname) 	  
   END IF
   
    #160523-00002#1 add (s) 有分歧，因为会导致p_tabname和viename不一致，导致树状问题。考虑在g_tab加个view的变量。调用之前就进行考虑。
   #IF p_flag='all' THEN 
       #判断查找的的栏位对应的table是否在g_tab存在,如果不存在到USER_VIEWS和USER_TAB_COLUMNS,ALL_VIEWS和ALL_TAB_COLUMNS
      IF NOT cl_null(p_tabname) THEN  #160711-00011#1 add 增加判断p_tabname是否为空值情况   #161202-00026#1 mod     
        #在g_tab中存在找到的表名，退出FOR循环继续
         FOR l_cnt =1 TO g_tab_cnt
            IF p_tabname = g_tab[l_cnt].tabname THEN
               LET p_tabalias= g_tab[l_cnt].tabalias
               EXIT FOR
            END IF
         END FOR  
      END IF        
        #不在g_tab中或者p_tabname是空的
        IF l_cnt > g_tab_cnt OR cl_null(p_tabname) THEN  #160711-00011#1 add 增加判断p_tabname是否为空值情况
           FOR l_cnt =1 TO g_tab_cnt
             SELECT DISTINCT LOWER(a.VIEW_NAME) INTO l_viewname FROM USER_VIEWS a,USER_TAB_COLUMNS b WHERE a.VIEW_NAME=b.TABLE_NAME AND a.OWNER=b.OWNER AND  LOWER(b.COLUMN_NAME)=p_colname AND LOWER(a.VIEW_NAME)=g_tab[l_cnt].tabname
             IF CL_NULL(l_viewname) THEN
                 SELECT DISTINCT LOWER(a.VIEW_NAME) INTO l_viewname FROM ALL_VIEWS a,ALL_TAB_COLUMNS b WHERE a.VIEW_NAME=b.TABLE_NAME AND a.OWNER=b.OWNER AND LOWER(b.COLUMN_NAME)=p_colname AND LOWER(a.VIEW_NAME)=g_tab[l_cnt].tabname
             END IF
             
             #在g_tab中且在VIEW中
             IF NOT CL_NULL(l_viewname) THEN
             　　CALL azzi310_get_column_info_fromview(l_viewname,g_tab[l_cnt].tabalias,p_colname,p_colalias,'view') #160721-00005#1 mod 增加p_colalias
                 RETURN
             END IF
           END FOR
        END IF 
        LET l_cnt=0
  # END IF        
   #160523-00002#1 add (e) 
   
   IF cl_null(p_tabalias) THEN
      LET p_tabalias=p_tabname
   END IF 
   #151214-00004#1 mod(e)
   
   LET l_sql="SELECT dzea003 FROM ds.dzea_t WHERE dzea001 LIKE '",p_tabname,"%' AND rownum=1"
   PREPARE  azzi310_get_module_p FROM l_sql
   EXECUTE azzi310_get_module_p INTO l_module
   IF l_module = "ADZ" OR l_module = "AZZ" THEN
      LET p_dbname ="ds"
   END IF
   #160523-00002#1 add(s)
   IF cl_null(p_dbname) THEN
      LET p_dbname=g_dbs
   END IF 
   #160523-00002#1 add(e)
   LET p_colname = p_colname CLIPPED

   #160523-00002#1 mod(s)
   LET p_colalias = p_colalias CLIPPED
   LET l_sql= " SELECT dzeb001,dzeb002,gztd003,gztd010,gztd012,dzebl003,gztd001",      
              "  FROM ",p_dbname CLIPPED,".dzeb_t left outer join ",p_dbname CLIPPED,".dzebl_t ",
              "         ON dzebl000=dzeb001 AND dzebl001=dzeb002 AND dzebl002='",g_dlang,"',",p_dbname CLIPPED,".gztd_t",
              "  WHERE dzeb006 = gztd001 "       
            # " WHERE dzeb001 LIKE '",p_tabname CLIPPED,"%' ", 
              #"   AND dzeb002='",p_colname CLIPPED,"' ",
            #  "   AND dzeb006 = gztd001 "
    #160523-00002#1 mod(e)             

   IF p_colname = "*" THEN
        LET l_sql=l_sql," AND dzeb001 '",p_tabname CLIPPED,"'"  #160523-00002#1 add
   ELSE
   	  LET l_sql=l_sql," AND dzeb002='",p_colname CLIPPED,"'"
   END IF
   LET l_sql1="SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE azzi310_column_cnt_p FROM l_sql1
   EXECUTE azzi310_column_cnt_p INTO l_cnt
   IF l_cnt = 0 THEN
   
   #160523-00002#1 mod(s)
      LET l_sql= " SELECT dzeb001,dzeb002,gztd003,gztd010,gztd012,dzebl003,gztd001",       
                 "  FROM ds.dzeb_t left outer join ds.dzebl_t on dzebl000=dzeb001 ",
                 "   AND dzebl001=dzeb002 AND dzebl002='",g_dlang,"', ds.gztd_t ",
                 "  WHERE dzeb006 = gztd001 " 
                 #" WHERE dzeb001 LIKE '",p_tabname CLIPPED,"%' ",
                # "   AND dzeb002='",p_colname CLIPPED,"' ",
                # "   AND dzeb006 = gztd001 " 
 #160523-00002#1 mod(e)                  
       IF p_colname = "*" THEN
          LET l_sql=l_sql," AND dzeb001 = '",p_tabname CLIPPED,"'" #160523-00002#1 add
       ELSE
   	   LET l_sql=l_sql," AND dzeb002='",p_colname CLIPPED,"'"
       END IF
      
   END IF
   
   LET l_sql=l_sql," ORDER BY dzeb001,dzeb021,dzeb002 "
   PREPARE azzi310_get_column_pre1 FROM l_sql
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.SQLCODE
      LET g_errparam.extend = "prepare column_info: "
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   DECLARE azzi310_get_column_cs1 CURSOR FOR azzi310_get_column_pre1
   	IF SQLCA.SQLCODE THEN
   	  INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.SQLCODE
      LET g_errparam.extend = "declare column_info: "
      LET g_errparam.popup = TRUE
      CALL cl_err()
    END IF
    
   LET l_len=g_feld.getLength()+1
   FOREACH azzi310_get_column_cs1 INTO g_feld[l_len].tabname,g_feld[l_len].feldname,g_feld[l_len].feldtype,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldnamec,l_gztd001
       LET l_gztd012=g_feld[l_len].feldpreci
       IF l_gztd012.getIndexOf(",",1) THEN
          LET g_feld[l_len].feldpreci=l_gztd012.subString(l_gztd012.getIndexOf(",",1)+1,l_gztd012.getLength())
          LET g_feld[l_len].feldprop= l_gztd001
       END IF
       #160523-00002#1 add(s)
       IF p_flag="view" THEN
           RETURN
        #  EXIT FOREACH
       END IF
       #160523-00002#1 add(e)
       
       #151214-00004#1 mod(s)
       IF p_flag="all" THEN
          LET g_feld[l_len-1].*=g_feld[l_len].*
          EXIT FOREACH
       ELSE
         # INSERT INTO azzi310_xabd VALUES(l_len,g_feld[l_len].tabname,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',g_feld[l_len].feldname,g_feld[l_len].feldnamec,g_feld[l_len].feldprop)
         # INSERT INTO azzi310_xabd VALUES(l_len,p_tabalias,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',g_feld[l_len].feldname,g_feld[l_len].feldnamec,g_feld[l_len].feldprop) #160721-00005#1 mark
         #160721-00005#1 add(s)
         IF cl_null(p_colalias) THEN
            LET l_colalias=g_feld[l_len].feldname
         ELSE
            LET l_colalias=p_colalias
         END IF
         #160721-00005#1 add(e)
         INSERT INTO azzi310_xabd VALUES(l_len,p_tabalias,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',l_colalias,g_feld[l_len].feldnamec,g_feld[l_len].feldprop)   #160721-00005#1 mod
          LET l_cnt=sqlca.sqlerrd[3] 	
          LET l_len=l_len+1
       END IF
       #151214-00004#1 mod(e)
   END FOREACH
   CALL g_feld.deleteElement(l_len)
   LET l_len=l_len-1
   #自定义栏位
   IF l_cnt <1 AND (p_flag != "all" OR cl_null(p_flag))THEN     #151214-00004#1 mod #160711-00011#1 add 增加判断cl_null是否为空值情况
      #160901-00030#1 add(s)
      IF NOT cl_null(p_tabalias) THEN
          LET p_colname=p_tabalias,".",p_tabname
      END IF
      #160901-00030#1 add(e)
      LET l_exesql="SELECT " ,p_colname," FROM ",g_tabs," where 1=2 " 	
      #CALL azzi310_get_column_info_fromds(l_exesql)
      # CALL azzi310_get_column_info_fromds(l_exesql,'')  #151214-00004#1 mod #160523-00002#1 mark
      #CALL azzi310_get_column_info_fromds(l_exesql,'','') #160523-00002#1 add #160721-00005#1 mark
      CALL azzi310_get_column_info_fromds(l_exesql,'','',p_colalias) #160721-00005#1 mod
   END IF
END FUNCTION

################################################################################
# Descriptions...: 从系统库中获取栏位信息
# Memo...........:
# Usage..........: CALL azzi310_get_column_info_fromds(p_execmd,p_flag,p_feldname,p_feldalais)
#                  
# Input parameter: p_execmd   sql命令
#                : p_flag     标示传入的栏位是single还是all
#                : p_feldname 传人栏位名称
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........: 2015/12/14 by chenjpa 151214-00004#1 增加p_flag 
# Modify.........: 2016/06/13 by chenjpa 160523-00002#1 增加p_feldname 
# Modify.........: 2016/07/25 by chenjpa 160721-00005#1 增加p_feldalais
################################################################################
PUBLIC FUNCTION azzi310_get_column_info_fromds(p_execmd,p_flag,p_feldname,p_feldalias)
DEFINE l_serial                  INTEGER
   DEFINE ls_serial                 STRING
   DEFINE ls_tmptbl                 STRING
   DEFINE l_sql                     STRING
   DEFINE l_i                       INTEGER
   DEFINE l_len                     INTEGER
   DEFINE ls_feld_alias             STRING
   DEFINE ls_feld_type              STRING
   DEFINE ls_feld_len               INTEGER 
   DEFINE ls_feld_name              STRING
   DEFINE ls_tab_name               STRING
   DEFINE p_execmd                  STRING
   DEFINE p_flag                    STRING      #151214-00004#1 add
   DEFINE p_feldname                STRING      #160523-00002#1 add
   DEFINE p_feldalias               VARCHAR(40) #160721-00005#1 add
   DEFINE l_feldalias               VARCHAR(40) #160721-00005#1 add
   
   #目前只考虑oracle情况
   LET ls_serial = azzi310_get_tmptbl_id()
   LET ls_tmptbl = "azzi310_",ls_serial,"_tmp1"

   LET l_sql = "DROP TABLE ",ls_tmptbl
   PREPARE drop_cols_crt FROM l_sql
   EXECUTE drop_cols_crt
   
   LET l_sql = " CREATE TABLE ",ls_tmptbl,
               " TABLESPACE temptabs ",
               " AS ",
               "    (SELECT * ",
               "       FROM (",p_execmd,") ",
               "      WHERE 1 = 2) "
   PREPARE get_cols_crt FROM l_sql
   EXECUTE get_cols_crt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'adz-00414'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   LET p_feldalias = p_feldalias CLIPPED
   LET p_feldname = p_feldname CLIPPED
   
   LET l_len=g_feld.getLength()+1
   LET l_sql = "   SELECT LOWER(column_name),LOWER(data_type),data_length,data_scale ",#160523-00002#1 mod
               "     FROM user_tab_columns ",
               "    WHERE table_name = '",ls_tmptbl.toUpperCase(),"' ",
               " ORDER BY column_id "
   DECLARE get_cols_c CURSOR FROM l_sql
   FOREACH get_cols_c INTO g_feld[l_len].feldalias,g_feld[l_len].feldtype,g_feld[l_len].feldlen,g_feld[l_len].feldpreci
       #获取字段名称
       #160721-00005#1 mark(s)
       #LET ls_feld_alias = g_feld[l_len].feldalias
       #LET g_feld[l_len].feldalias = ls_feld_alias.toLowerCase() 
      #160721-00005#1 mark(e)  
      
       #160523-00002#1 mod (s)
       IF NOT cl_null(p_feldname) THEN 
           LET g_feld[l_len].feldname = p_feldname
       ELSE       
          LET g_feld[l_len].feldname = g_feld[l_len].feldalias
       END IF
       #160523-00002#1 mod (e)
       #160721-00005#1 add(s) 
       IF cl_null(p_feldalias) THEN
          LET l_feldalias=g_feld[l_len].feldname
       ELSE
          LET l_feldalias=p_feldalias
       END IF
       #160721-00005#1 add(e) 
       
       #151214-00004#1 add(s)
       #LET g_feld[l_len].tabname="user-def"    #160523-00002#1 mark
       IF p_flag="all" THEN
           #CALL azzi310_get_column_info(g_dbs,'','',g_feld[l_len].feldname,p_flag)
           CALL azzi310_get_column_info(g_dbs,'','',g_feld[l_len].feldname,l_feldalias,p_flag)
       END IF
       #151214-00004#1 add(e)
       
       #160523-00002#1 add(s)
      IF cl_null(g_feld[l_len].tabname) THEN
          LET g_feld[l_len].tabname="user-def" 
      END IF
      #160523-00002#1 add(e)
        #151214-00004#1 mod:g_feld[l_len].tabname,g_feld[l_len].feldnamec,g_feld[l_len].feldprop
       #INSERT INTO azzi310_xabd VALUES(l_len,g_feld[l_len].tabname,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',g_feld[l_len].feldname,g_feld[l_len].feldnamec,g_feld[l_len].feldprop) #160721-00005#1 mark
       INSERT INTO azzi310_xabd VALUES(l_len,g_feld[l_len].tabname,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',l_feldalias,g_feld[l_len].feldnamec,g_feld[l_len].feldprop)  #160721-00005#1 mod
       LET l_len = l_len + 1
   END FOREACH
   	CALL g_feld.deleteElement(l_len)
   	LET l_len=l_len-1
END FUNCTION

################################################################################
# Descriptions...: 群组页签-栏位树状列表
# Memo...........:
# Usage..........: CALL azzi310_grouplist_b_fill (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_grouplist_b_fill()
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_cnt       LIKE type_t.num5  
   DEFINE lc_tablename LIKE dzeal_t.dzeal003
 
   DEFINE l_view       LIKE type_t.chr1  #160523-00002#1 add
   CALL g_grouplist.clear() 
 
   LET li_cnt = 1
   LET li_cnt = 1
   FOR li_i = 1 TO g_tab_cnt
       #160523-00002#1 add(s)
        LET lc_tablename=""
        LET l_view="" 
        #160523-00002#1 add(e)
       SELECT dzeal003 INTO lc_tablename FROM dzeal_t 
        WHERE dzeal001 = g_tab[li_i].tabname AND dzeal002 = g_dlang 
    
     #160523-00002#1 add(s)
        IF cl_null(lc_tablename) THEN
           LET lc_tablename="VIEW"
           LET l_view="v"
        END IF
        #160523-00002#1 add(e)
    
       LET g_grouplist[li_cnt].groupname = g_tab[li_i].tabname,":", lc_tablename
       #151214-00004#2  add(s)  #增加资料表别名的信息，解决一表多用问题
       IF g_tab[li_i].tabname != g_tab[li_i].tabalias AND g_tab[li_i].tabalias IS NOT NULL 
       AND g_tab[li_i].tabalias !=" " AND g_tab[li_i].tabalias IS NOT NULL !="" THEN
           LET g_grouplist[li_cnt].groupname = g_tab[li_i].tabname,"(",g_tab[li_i].tabalias,"):", lc_tablename
       END IF
       #151214-00004#2  add(e) 
       #151214-00004#2  mod(s)  #增加资料表别名的信息，解决一表多用问题
       #LET g_grouplist[li_cnt].groupid = g_tab[li_i].tabname 
       LET g_grouplist[li_cnt].groupalias = g_tab[li_i].tabname   
       LET g_grouplist[li_cnt].groupid = g_tab[li_i].tabalias
       IF cl_null(g_tab[li_i].tabalias) THEN
          LET g_grouplist[li_cnt].groupid = g_tab[li_i].tabname 
       END IF
       #151214-00004#2  mod(e)       
       LET g_grouplist[li_cnt].groupexp = TRUE   #預設全開
       LET g_grouplist[li_cnt].groupisnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
       
        #160523-00002#1 mpd(s)
       IF l_view="v" THEN
         CALL azzi310_grouplist_b_fill_child_view(g_tab[li_i].tabname, li_cnt) RETURNING li_cnt
       ELSE
         CALL azzi310_grouplist_b_fill_child(g_tab[li_i].tabname, li_cnt) RETURNING li_cnt
       END IF
        #160523-00002#1 mod(e)

#       IF li_i = g_tab_cnt THEN
#           EXIT FOR
#       END IF
   END FOR 

 
END FUNCTION

################################################################################
# Descriptions...: 群组页签-树状栏位列表(子节点)
# Memo...........:
# Usage..........:azzi310_grouplist_b_fill_child (pc_dzea001,pi_idx)
#                  RETURNING pi_idx
# Input parameter: pc_dzea001  资料表
#                : pi_idx      最后节点位置
# Return code....: pi_idx      接下来节点位置
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_grouplist_b_fill_child(pc_dzea001,pi_idx)
   DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_prefix    STRING     
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002
   DEFINE lp_idx       LIKE type_t.num5  #151214-00004#2  add  #增加资料表别名的信息，解决一表多用问题
   
   LET lp_idx=pi_idx #151214-00004#2 add   #增加资料表别名的信息，解决一表多用问题
       LET lc_prefix = pc_dzea001
       LET lc_prefix = lc_prefix.subString(1,lc_prefix.getIndexOf("_",1)-1) 

      LET g_sql="SELECT dzeb002,dzebl003 FROM dzeb_t ",
                "       LEFT OUTER JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002='",g_dlang,"'",
                " WHERE dzeb001='",pc_dzea001,"'"                  
      PREPARE azzi310_grouplist_b_fill_pre FROM g_sql
      DECLARE azzi310_grouplist_b_fill_curs CURSOR FOR azzi310_grouplist_b_fill_pre       
        LET pi_idx = pi_idx + 1     
        FOREACH azzi310_grouplist_b_fill_curs INTO lc_dzeb002, lc_dzebl003         
          LET g_grouplist[pi_idx].groupname = lc_dzeb002,":", lc_dzebl003
          LET g_grouplist[pi_idx].groupid = lc_dzeb002
          
          #151214-00004#2 mod(s)   #增加资料表别名的信息，解决一表多用问题
          #LET g_grouplist[pi_idx].grouppid = pc_dzea001      
          LET g_grouplist[pi_idx].grouppid = g_grouplist[lp_idx].groupid
          #151214-00004#2 mod(e) 
          LET g_grouplist[pi_idx].groupexp = FALSE
          LET g_grouplist[pi_idx].groupisnode = FALSE

          LET pi_idx = pi_idx + 1
       END FOREACH
 
   RETURN pi_idx
END FUNCTION

################################################################################
# Descriptions...: 群组页签-已挑选栏位列表
# Memo...........:
# Usage..........: CALL azzi310_gziblist_b_fill() 
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_gziblist_b_fill()
   DEFINE li_cnt       LIKE type_t.num5  
   DEFINE l_gzib_d     type_g_gzib_d #160822-00021#1 add
   
   CALL g_gzib_d.clear()

   LET li_cnt = 1
   LET g_sql = "SELECT gzib002,gzib003,dzebl003,gzib005, gzib006, gzib004 FROM gzib_t",   
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = gzib002 AND dzebl002 = '",g_dlang,"'",                  
               " WHERE gzib001 ='",g_gzia_m.gzia001,"'",                                                          
               " ORDER BY gzib003"
   PREPARE groupsel_b_fill_pre FROM g_sql 
   DECLARE groupsel_b_fill_curs CURSOR FOR groupsel_b_fill_pre
   #160822-00021#1 add(s)
   FOREACH groupsel_b_fill_curs INTO l_gzib_d.gzib002,l_gzib_d.gzib003,l_gzib_d.gzib002_desc, l_gzib_d.gzib005, l_gzib_d.gzib006, l_gzib_d.gzib004
     IF cl_null(l_gzib_d.gzib004) THEN 
        LET l_gzib_d.gzib004 ='N'
     END IF
     LET g_gzib_d[l_gzib_d.gzib003].*=l_gzib_d.*
   END FOREACH
   #160822-00021#1 add(e) 
#160822-00021#1 mark(s)   
#   FOREACH groupsel_b_fill_curs INTO g_gzib_d[li_cnt].gzib002,g_gzib_d[li_cnt].gzib003,g_gzib_d[li_cnt].gzib002_desc, g_gzib_d[li_cnt].gzib005, g_gzib_d[li_cnt].gzib006, g_gzib_d[li_cnt].gzib004
#
#      IF cl_null(g_gzib_d[li_cnt].gzib004) THEN 
#         LET g_gzib_d[li_cnt].gzib004 ='N'
#      END IF 
#       
#      LET li_cnt = li_cnt + 1
#   END FOREACH
#   CALL g_gzib_d.deleteElement(li_cnt)
#160822-00021#1 mark(e)   

END FUNCTION

################################################################################
# Descriptions...: qbe栏位资料页签
# Memo...........:
# Usage..........: azzi310_gzidlist_b_fill()  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_gzidlist_b_fill()
DEFINE ps_arg       LIKE type_t.num5
   DEFINE i            LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003

   CALL g_gzib3_d.clear()
   LET l_cnt = 1
#151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
#    LET g_sql = "SELECT gzid002,gzid003,gzid004,gzidl004,gzid005,gzid006,",
#               "       gzid007,gzid008,gzid009,gzid010,gzid011,gzid012 ",
#               " FROM gzid_t left outer join gzidl_t on gzidl001=gzid001 and gzidl002=gzid002 and gzidl003='",g_dlang,"' ",
#               " WHERE gzid001 = '",g_gzia_m.gzia001,"'",
#               " ORDER BY gzid002"  
   #160901-00030#1mod add->gzid017 
   #161121-00024#1mod add->gzid018    
   #160926-00005#1.2 mod add NVL   
   LET g_sql = "SELECT gzid002,gzid003,gzig002,gzid004,gzidl004,gzid005,gzid006,",
               "       gzid007,gzid018,NVL(gzid008,'N'),gzid009,NVL(gzid014,'N'),gzid015,gzid017,gzid010,gzid011,NVL(gzid012,'N') ", #160523-00002#2 add gzid014,gzid015
               " FROM gzid_t left outer join gzidl_t on gzidl001=gzid001 and gzidl002=gzid002 and gzidl003='",g_dlang,"' ",
               " LEFT OUTER JOIN gzig_t ON gzig001=gzid001 AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=gzid003  ", 
               " WHERE gzid001 = '",g_gzia_m.gzia001,"'",
               " ORDER BY gzid002"
#151214-00004#2 mod(e)               
   PREPARE gzidlist_b_fill_pre FROM g_sql
   DECLARE gzidlist_b_fill_curs CURSOR FOR gzidlist_b_fill_pre  
   FOREACH gzidlist_b_fill_curs INTO g_gzib3_d[l_cnt].*
       #151214-00004#2 add(s) #增加资料表别名的信息，解决一表多用问题   
        IF g_gzib3_d[l_cnt].gzig002 IS NULL THEN
           LET g_gzib3_d[l_cnt].gzig002 =g_gzib3_d[l_cnt].gzid003        #user-def情况
        END IF
        #151214-00004#2 add(e) 
   	  IF g_gzib3_d[l_cnt].gzidl004 is NULL THEN
   	     LET lc_dzebl003=""
   	     #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
#   	  	  SELECT dzebl003 INTO lc_dzebl003 FROM dzebl_t 
#   	  	   WHERE dzebl001=g_gzib3_d[l_cnt].gzid004
#   	  	     AND dzebl000=g_gzib3_d[l_cnt].gzid003
#   	  	     AND dzebl002=g_dlang
           #160523-00002#1 mod (s)
   	  	  SELECT dzebl003 INTO lc_dzebl003 FROM dzebl_t,gzig_t 
   	  	   WHERE dzebl001=g_gzib3_d[l_cnt].gzid004
   	  	     AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=g_gzib3_d[l_cnt].gzid003
   	  	     AND dzebl002=g_dlang
   	  	     AND gzig001=g_gzia_m.gzia001
#   	  	        WHERE dzebl000=gzig002
#   	  	     AND dzebl001=g_gzib3_d[l_cnt].gzid004
#   	  	     AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=g_gzib3_d[l_cnt].gzid003
#   	  	     AND dzebl002=g_dlang
#   	  	     AND gzig001=g_gzia_m.gzia001
   	  	     #160523-00002#1 mod (e)
             IF SQLCA.sqlcode AND SQLCA.sqlcode != 100  THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "search dzebl003 :" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                EXIT FOREACH
             END IF
   	  	 #151214-00004#2 mod(e) 
   	  	  LET g_gzib3_d[l_cnt].gzidl004=lc_dzebl003
   	  END IF
      LET l_cnt = l_cnt + 1
   END FOREACH  
      #151214-00004#1 add(s) 
        IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach azzi310_sumy1_b_fill_curs:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
       #151214-00004#1 add(e)
   CALL g_gzib3_d.deleteElement(l_cnt)
END FUNCTION

################################################################################
# Descriptions...: 参数页签
# Memo...........:
# Usage..........: CALL azzi310_gzielist_b_fill() 
#                  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_gzielist_b_fill()
   DEFINE l_cnt        LIKE type_t.num5
   

   CALL g_gzib2_d.clear()
   LET l_cnt = 1
   LET g_sql = "SELECT gzie002,gzie003,gzie005 ",
               " FROM gzie_t ",
               " WHERE gzie001 = '",g_gzia_m.gzia001,"'",
               " ORDER BY gzie002"
            
   PREPARE gzielist_b_fill_pre FROM g_sql
   DECLARE gzielist_b_fill_curs CURSOR FOR gzielist_b_fill_pre  
   FOREACH gzielist_b_fill_curs INTO g_gzib2_d[l_cnt].gzie002,g_gzib2_d[l_cnt].gzie003,g_gzib2_d[l_cnt].gzie005
      LET l_cnt = l_cnt + 1
   END FOREACH  
   LET g_argcnt=l_cnt-1
   CALL g_gzib2_d.deleteElement(l_cnt)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310__maintain_gzib ((pi_idx, ps_type))
# Input parameter: pi_idx   s_detail1上focus的行数
#                : ps_type  add新增/upd修改/del刪除
# Return code....: none
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_maintain_gzib(pi_idx,ps_type)
DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_gzib002   LIKE gzib_t.gzib002
   DEFINE lc_gzib003   LIKE gzib_t.gzib003
   DEFINE lc_gzib002_t LIKE gzib_t.gzib002            ##140512 add
   DEFINE ls_temp      LIKE type_t.num5               ##140512 add
   DEFINE l_k          LIKE type_t.num5               ##141013 add 
   DEFINE l_pid2       LIKE gzib_t.gzib002            ##141211 add
   DEFINE l_gzib007    LIKE gzib_t.gzib007            #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题

   CASE ps_type
      WHEN "add"
         #檢查單頭是否存入, 若還未存入必須先INSERT單頭
         
             #找出最大序號
             SELECT MAX(gzib003) + 1 INTO g_gzib_d1.gzib003 FROM  gzib_t 
              WHERE gzib001 = g_gzia_m.gzia001               
                
             IF cl_null(g_gzib_d1.gzib003)  THEN
                LET g_gzib_d1.gzib003 = 1
             END IF
             
             LET g_sql = "INSERT INTO azzi310_tmp01 ",       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
                         "VALUES('",g_gzia_m.gzia001,"',?,?,?,?,?,?,?,?,?)"   
             PREPARE azzi310_sum2_tmp_ins_pre FROM g_sql
             
             #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
             #LET g_sql = "INSERT INTO gzib_t  ",
             #            "VALUES('",g_gzia_m.gzia001,"',?,?,?,?,?)"  
             LET g_sql = "INSERT INTO gzib_t  ",
                         "VALUES('",g_gzia_m.gzia001,"',?,?,?,?,?,?)" 
             #151214-00004#2 mod(e)                  
             PREPARE azzi310_gzib_t_ins_pre FROM g_sql

             #由s_grouplist新增進入, 可能為多選新增
             FOR pi_idx = 1 TO g_grouplist.getLength()
                 IF gdig_curr.isRowSelected("s_grouplist", pi_idx) THEN
                    #如果是點在table節點上, 批次新增所有欄位
                    IF g_grouplist[pi_idx].groupisnode THEN
                        LET l_gzib007 =g_grouplist[pi_idx].groupid #151214-00004#2  add  #增加资料表别名的信息，解决一表多用问题
                       #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = pi_idx + 1 TO g_grouplist.getLength()
                           IF NOT g_grouplist[li_i].groupisnode THEN
                             IF azzi310_chk_field_exist("s_detail1",g_grouplist[li_i].groupid,'') THEN 
                                  LET g_gzib_d1.gzib002 = g_grouplist[li_i].groupid
                                  LET g_gzib_d1.group = 'Y'  #group
                                  LET g_gzib_d1.sort = 1     #sort,升序
                                  LET g_gzib_d1.paging = 'N' #paging  
                                 #151214-00004#2  mod(s)  #增加资料表别名的信息，解决一表多用问题                                  
                                 # EXECUTE azzi310_gzib_t_ins_pre USING g_gzib_d1.gzib002,g_gzib_d1.gzib003,g_gzib_d1.paging,g_gzib_d1.group,g_gzib_d1.sort 
                                  EXECUTE azzi310_gzib_t_ins_pre USING g_gzib_d1.gzib002,g_gzib_d1.gzib003,g_gzib_d1.paging,g_gzib_d1.group,g_gzib_d1.sort,l_gzib007                                                                      
                                  IF sqlca.sqlcode THEN
                                    INITIALIZE g_errparam TO NULL 
                                    LET g_errparam.extend = "EXECUTE azzi310_gzib_t_ins_pre:" 
                                    LET g_errparam.code   = SQLCA.sqlcode 
                                    LET g_errparam.popup  = FALSE
                                    CALL cl_err()
                                    LET INT_FLAG=1                                    
                                  END IF
                                  #151214-00004#2  mod(e) 
                                  LET lc_gzib002_t =''
                                  IF g_gzib_d1.gzib003 = 1 THEN
                                     ##指第一個
                                     LET lc_gzib002_t = "0"
                                  ELSE                   
                                     SELECT gzib002 INTO lc_gzib002_t FROM gzib_t
                                      WHERE gzib001 = g_gzia_m.gzia001 
                                        AND gzib003 = g_gzib_d1.gzib003 - 1                                       
                                  END IF
                                  LET l_k = 1    
                                  LET lc_gzib003=g_gzib_d1.gzib003-1
                                  #160523-00002#1 add(s) 会有重复情况
                                  IF lc_gzib003=0 THEN
                                      LET lc_gzib003=999
                                  END IF
                                  #160523-00002#1 add(e)                           
                                  EXECUTE azzi310_sum2_tmp_ins_pre USING '0',g_gzib_d1.gzib002,'N',lc_gzib003,lc_gzib002_t, '6',l_k,'p','3'
                                  IF sqlca.sqlcode THEN
                                    INITIALIZE g_errparam TO NULL 
                                    LET g_errparam.extend = "EXECUTE azzi310_sum2_tmp_ins_pre:" 
                                    LET g_errparam.code   = SQLCA.sqlcode 
                                    LET g_errparam.popup  = FALSE
                                    CALL cl_err()
                                    LET INT_FLAG=1                                    
                                  END IF
                             END IF 
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                       IF azzi310_chk_field_exist("s_detail1",g_grouplist[pi_idx].groupid,'') THEN                      
                           LET g_gzib_d1.gzib002 = g_grouplist[pi_idx].groupid
                           LET g_gzib_d1.group  = 'Y'  #group
                           LET g_gzib_d1.sort   = 1    #sort 
                           LET g_gzib_d1.paging = 'N'  #paging
                           #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
                           LET l_gzib007 =g_grouplist[pi_idx].grouppid #151214-00004#2  add  #增加资料表别名的信息，解决一表多用问题
                           #EXECUTE azzi310_gzib_t_ins_pre USING g_gzib_d1.gzib002,g_gzib_d1.gzib003,g_gzib_d1.paging,g_gzib_d1.group,g_gzib_d1.sort  
                           EXECUTE azzi310_gzib_t_ins_pre USING g_gzib_d1.gzib002,g_gzib_d1.gzib003,g_gzib_d1.paging,g_gzib_d1.group,g_gzib_d1.sort,l_gzib007                                     
                           #151214-00004#2 mod(e) #增加资料表别名的信息，解决一表多用问题
                           LET lc_gzib002_t =''
                           IF g_gzib_d1.gzib003 = 1 THEN
                              ##指第一個
                              LET lc_gzib002_t = "0"
                           ELSE                              
                              SELECT gzib002 INTO lc_gzib002_t FROM gzib_t
                               WHERE gzib001 = g_gzia_m.gzia001 
                                 AND gzib003 = g_gzib_d1.gzib003 - 1                                
                           END IF
                           LET l_k = 1   
                           LET lc_gzib003=g_gzib_d1.gzib003-1
                            #160523-00002#1 add(s) 会有重复情况
                            IF lc_gzib003=0 THEN
                               LET lc_gzib003=999
                            END IF
                           #160523-00002#1 add(e)  
                           EXECUTE azzi310_sum2_tmp_ins_pre USING g_gzib_d1.gzib003,g_gzib_d1.gzib002,'N',lc_gzib003,lc_gzib002_t, '6',l_k,'p','3'
                           
                       END IF 
                    END IF
                 END IF
             END FOR
             
      WHEN "upd"
         
         IF g_gzib_d[pi_idx].gzib005 = "N" THEN 
            IF g_gzib_d[pi_idx].gzib004 = "Y" THEN 
               LET g_gzib_d1.paging  = 'N'
            END IF 
            LET g_gzib_d1.group  = 'N'
            LET g_gzib_d1.sort  = g_gzib_d[pi_idx].gzib006      
         ELSE 
            LET g_gzib_d1.group  = 'Y'
            LET g_gzib_d1.paging  = g_gzib_d[pi_idx].gzib004              
            LET g_gzib_d1.sort  = g_gzib_d[pi_idx].gzib006      
         END IF 
     
         UPDATE gzib_t SET gzib005 = g_gzib_d1.group          
                ,gzib006 = g_gzib_d1.sort, gzib004 = g_gzib_d1.paging  
          WHERE gzib001 = g_gzia_m.gzia001 AND gzib002 = g_gzib_d[pi_idx].gzib002
            AND gzib003 = g_gzib_d[pi_idx].gzib003
            
            
      WHEN "del"
         
         DELETE FROM gzib_t
          WHERE gzib001 = g_gzia_m.gzia001 AND gzib002 = g_gzib_d[pi_idx].gzib002 AND gzib003 = g_gzib_d[pi_idx].gzib003
         IF SQLCA.SQLCODE THEN
         ELSE
            
            LET g_gzib_d1.gzib002 = g_gzib_d[pi_idx].gzib002

            # 刪除前先抓出欲刪除的爸爸 - add (s)
            LET l_pid2 = ""
            SELECT pid2 INTO l_pid2 FROM azzi310_tmp01       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
             WHERE gzic001 = g_gzia_m.gzia001 
               AND id2 = g_gzib_d[pi_idx].gzib002
           
            #刪除彙總
            DELETE FROM azzi310_tmp01      #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
             WHERE gzic001 = g_gzia_m.gzia001 
               AND (pid2 = g_gzib_d[pi_idx].gzib002 AND pidseq2 = 0) OR (id2 = g_gzib_d[pi_idx].gzib002 AND pidseq2 = 1)    

            # 將刪除的下一階補上新爸爸(       
            UPDATE azzi310_tmp01 SET pid2 = l_pid2    #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
             WHERE gzic001 = g_gzia_m.gzia001  
               AND pid2 = g_gzib_d[pi_idx].gzib002
               AND pidseq2 = 1  #是否為父節點          
         END IF
         
   END CASE
  

   #重整
   CALL azzi310_gziblist_b_fill()
   CALL azzi310_sumy1_b_fill()
   CALL azzi310_sumy2_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 维护参数gzie_t资料档
# Memo...........:
# Usage..........: CALL azzi310_maintain_gzie (ps_argsel_idx)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_maintain_gzie(ps_argsel_idx)
   DEFINE ps_argsel_idx    LIKE type_t.num5
   DEFINE l_have         LIKE type_t.num5  

   IF ps_argsel_idx = 0 THEN RETURN END IF 
   LET l_have = 0
   SELECT COUNT(*) INTO l_have FROM gzie_t
    WHERE gzie001 = g_gzia_m.gzia001 AND gzie002 =g_gzib2_d[ps_argsel_idx].gzie002  AND gzie003 = g_gzib2_d[ps_argsel_idx].gzie003

   
   IF l_have > 0 THEN 
      UPDATE gzie_t SET gzie005 = g_gzib2_d[ps_argsel_idx].gzie005
        WHERE gzie001 = g_gzia_m.gzia001 AND gzie003 = g_gzib2_d[ps_argsel_idx].gzie002 AND gzie003 = g_gzib2_d[ps_argsel_idx].gzie003
             
   ELSE 
  
      LET g_sql = " INSERT INTO gzie_t(gzie001,gzie002,gzie003 ",                    
                  "VALUES('",g_gzia_m.gzia001,"',?,?)" 
      PREPARE azzi310_gzie_t_ins_pre FROM g_sql
      EXECUTE azzi310_gzie_t_ins_pre USING  g_gzib2_d[ps_argsel_idx].gzie002,  g_gzib2_d[ps_argsel_idx].gzie003
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_maintain_sumylist (ps_idx,ps_seq, ps_type)
#                  RETURNING 回传参数
# Input parameter: pi_idx       s_sumylist1/s_sumylist2上focus的行數
#                : ps_seq       g_sumylist2 的seq
#                : ps_type      add新增/upd修改/del刪除
# Return code....: none
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_maintain_sumylist(ps_idx,ps_seq,ps_type)
DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_idx       LIKE type_t.num5
   DEFINE ps_seq       LIKE type_t.num5
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_j         LIKE type_t.num5
   DEFINE lc_gzib002   LIKE gzib_t.gzib002
   DEFINE lc_gzib003   LIKE gzib_t.gzib003
   DEFINE lc_gzic004   LIKE gzic_t.gzic004
   DEFINE lc_gzid002   LIKE gzid_t.gzid002
   DEFINE g_seq2       LIKE type_t.num5
   DEFINE ls_pid2      DYNAMIC ARRAY OF VARCHAR(20)



   LET g_sql =" SELECT id2 FROM azzi310_tmp01 ",      #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
              " WHERE gzic001 ='", g_gzia_m.gzia001 ,"'",       
              "  AND  pidseq2 = 1 "
   PREPARE sumy_getpid_pre FROM g_sql
   DECLARE sumy_getpid_curs CURSOR FOR sumy_getpid_pre
   	
   	LET g_sql="SELECT gzid002 FROM gzid_t ",
   	          " WHERE gzid001='",g_gzia_m.gzia001,"' AND gzid003=? AND gzid004=? "
   	PREPARE sumy_getidseq_pre FROM g_sql
   	  
   	LET g_sql="SELECT gzib003 FROM gzib_t ",
   	          " WHERE gzib001='",g_gzia_m.gzia001,"' AND gzib002=? "
    PREPARE sumy_getpidseq_pre FROM g_sql 
    
   CASE ps_type
      WHEN "add"      
              LET li_i = 1
             #找出父節點  
              FOREACH sumy_getpid_curs INTO ls_pid2[li_i]
                  LET li_i = li_i + 1
              END FOREACH 
              CALL ls_pid2.deleteElement(li_i)
              LET li_i = li_i - 1

             IF g_comb_sumy IS NULL THEN  #默认最大值
                LET g_comb_sumy='2'
             END IF 
             LET g_sql = "INSERT INTO azzi310_tmp01 ",     #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
                         "VALUES('",g_gzia_m.gzia001,"',?,?,?,?,?,?,?,?,?)"
             PREPARE azzi310_sumy_tmp_ins_pre FROM g_sql
             IF g_sumylist2_idx >=1 THEN  #右边tree选中父节点
             	  LET li_i=g_sumylist2_idx
             	  IF g_sumylist2[g_sumylist2_idx].sumyid2="node" THEN
             	     LET lc_gzib003=0
             	     LET lc_gzib002='0'
             	     LET lc_gzic004='N'
             	  ELSE
             	     EXECUTE sumy_getpidseq_pre INTO lc_gzib003 USING g_sumylist2[g_sumylist2_idx].sumyid2
             	       LET lc_gzic004='Y'
             	       LET lc_gzib002=g_sumylist2[g_sumylist2_idx].sumyid2
             	  END IF
             	  #由s_sumylist1新增進入, 可能為多選新增
                  FOR pi_idx = 1 TO g_sumylist1.getLength()
                     IF gdig_curr.isRowSelected("s_sumylist1", pi_idx) THEN                     	  
                        IF NOT g_sumylist1[pi_idx].sumyisnode1 THEN  #非父节点
                          #IF g_sumylist1[pi_idx].sumypid1 !='user-def' THEN  #非自定义节点
                           #已经添加的不可以再添加
                           IF azzi310_chk_field_exist("s_sumylist2",g_sumylist1[pi_idx].sumyid1,lc_gzib002) THEN
                                EXECUTE sumy_getidseq_pre  INTO lc_gzid002 USING g_sumylist1[pi_idx].sumypid1,g_sumylist1[pi_idx].sumyid1                               
                                EXECUTE azzi310_sumy_tmp_ins_pre USING lc_gzid002,g_sumylist1[pi_idx].sumyid1,lc_gzic004,lc_gzib003, lc_gzib002,g_comb_sumy, '0','c','1'                         
                           END IF
                          #END IF
                        ELSE #如果是點在table節點上, 批次新增所有欄位
                          #IF g_sumylist1[pi_idx].sumyid1 !='user-def' THEN  #非自定义节点
                           FOR li_j= pi_idx+1 TO g_sumylist1.getLength()
                             IF NOT g_sumylist1[li_j].sumyisnode1 THEN
                       	  	      IF azzi310_chk_field_exist("s_sumylist2",g_sumylist1[li_j].sumyid1,lc_gzib002) THEN
                                    EXECUTE sumy_getidseq_pre  INTO lc_gzid002 USING g_sumylist1[li_j].sumypid1,g_sumylist1[li_j].sumyid1  
                                    EXECUTE azzi310_sumy_tmp_ins_pre USING lc_gzid002,g_sumylist1[li_j].sumyid1,lc_gzic004,lc_gzib003, lc_gzib002,g_comb_sumy, '0','c','1'                                                            
                                 END IF
                              ELSE
                           	  	LET pi_idx=li_j
                           	  	EXIT FOR
                              END IF
                             
                           END FOR
                          #END IF
                         
                        END IF
                         
                      END IF
                  END FOR 
             ELSE               
                LET lc_gzic004='N'
            	 LET lc_gzib002='0'
            	 LET lc_gzib003=0
                                  	   
                 	   FOR pi_idx = 1 TO g_sumylist1.getLength()
                         IF gdig_curr.isRowSelected("s_sumylist1", pi_idx) THEN                     	  
                            IF NOT g_sumylist1[pi_idx].sumyisnode1 THEN
                              # IF g_sumylist1[pi_idx].sumypid1 !='user-def' THEN  #非自定义节点                            
                                  IF azzi310_chk_field_exist("s_sumylist2",g_sumylist1[pi_idx].sumyid1,lc_gzib002) THEN
                                    EXECUTE sumy_getidseq_pre  INTO lc_gzid002 USING g_sumylist1[pi_idx].sumypid1,g_sumylist1[pi_idx].sumyid1                              
                                    EXECUTE azzi310_sumy_tmp_ins_pre USING lc_gzid002,g_sumylist1[pi_idx].sumyid1,lc_gzic004,lc_gzib003,lc_gzib002,g_comb_sumy,'0','c','1'                         
                                   
                                  END IF
                              # END IF
                           ELSE #如果是點在table節點上, 批次新增所有欄位
                              #IF g_sumylist1[pi_idx].sumyid1 !='user-def' THEN  #非自定义节点
                               FOR li_j= pi_idx+1 TO g_sumylist1.getLength()
                               	  IF NOT g_sumylist1[li_j].sumyisnode1 THEN
                               	  	 IF azzi310_chk_field_exist("s_sumylist2",g_sumylist1[li_j].sumyid1,lc_gzib002) THEN
                                        EXECUTE sumy_getidseq_pre  INTO lc_gzid002 USING g_sumylist1[li_j].sumypid1,g_sumylist1[li_j].sumyid1  
                                        EXECUTE azzi310_sumy_tmp_ins_pre USING lc_gzid002,g_sumylist1[li_j].sumyid1,lc_gzic004,lc_gzib003,lc_gzib002,g_comb_sumy, '0','c','1'                                                             
                                     END IF
                               	  ELSE
                               	  	LET pi_idx=li_j
                               	  	EXIT FOR
                               	  END IF
                               END FOR
                             #END IF
                             
                            END IF
                             
                          END IF
                       
                     END FOR   
             END IF
             
            IF sqlca.sqlcode AND sqlca.sqlcode != 100 THEN
               INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend ="ins azzi310_tmp01"           #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = FALSE 
                CALL cl_err()
              END IF
              
      WHEN "upd"
        IF NOT g_sumylist2[ps_idx].sumyisnode2 THEN
           LET lc_gzib002=g_sumylist2[ps_idx].sumypid2
           IF g_sumylist2[ps_idx].sumypid2 ="node" THEN
              LET lc_gzib002='0' 
           END IF
          UPDATE azzi310_tmp01 SET type2 = g_comb_sumy         #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01               
           WHERE gzic001 = g_gzia_m.gzia001 
             AND pid2 = lc_gzib002
             AND id2 = g_sumylist2[ps_idx].sumyid2
             

             IF sqlca.sqlcode AND sqlca.sqlcode != 100 THEN
               INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "upd azzi310_tmp01"         #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = FALSE 
                CALL cl_err()
              END IF
        END IF
        
      WHEN "del"
          
         LET li_i = 1
         #找出父節點  
         
             FOR pi_idx = 1 TO g_sumylist2.getLength()
                  IF gdig_curr.isRowSelected("s_sumylist2", pi_idx) THEN                                           
                     IF NOT g_sumylist2[pi_idx].sumyisnode2 THEN   #点在子节点上
                     #160523-00002#1 add(s)
                        IF g_sumylist2[pi_idx].sumypid2 ="node" THEN
                           LET g_sumylist2[pi_idx].sumypid2='0'
                       END IF
                       #160523-00002#1 add(e)
                        DELETE FROM azzi310_tmp01        #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01          
                         WHERE gzic001 = g_gzia_m.gzia001                               
                           AND id2 = g_sumylist2[pi_idx].sumyid2  
                           AND type2 !='6'               #排除父节点
                           AND pid2 = g_sumylist2[pi_idx].sumypid2 #151214-00004#1 add
#                           AND pidseq2 ='1'
                           
                           IF sqlca.sqlcode AND sqlca.sqlcode != 100 THEN
                             INITIALIZE g_errparam TO NULL 
                             LET g_errparam.extend = "del azzi310_tmp01"       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01          
                             LET g_errparam.code   = SQLCA.sqlcode 
                              LET g_errparam.popup  = FALSE 
                              CALL cl_err()
                            END IF
                                                     
                      ELSE                                        #点在父节点上
                       IF g_sumylist2[ps_idx].sumyid2 ="node" THEN
                           LET g_sumylist2[ps_idx].sumyid2='0'
                       END IF
                         LET li_j=azzi310_sumylist2_del(pi_idx,0)
                         IF li_j =0 THEN    #在无子节点的父节点上
                             LET li_j=1
                         END IF
                         LET pi_idx=pi_idx+ li_j
                         
                      END IF 
                   END IF 
                  END FOR 
              
   END CASE

   #重整
   CALL azzi310_sumy2_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 上下移動排序
# Memo...........:
# Usage..........: CALL azzi310_move_up_down(ps_array, ps_type)
# Input parameter: ps_array   移動的array名稱
#                : ps_type    往上移動/往下移動
# Return code....: None
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_move_up_down(ps_array,ps_type)
  DEFINE ps_array   STRING
   DEFINE ps_type    STRING
   DEFINE li_step    LIKE type_t.num5
   DEFINE li_idx     LIKE type_t.num5   #目前指定的位置
   DEFINE li_idx_p   LIKE type_t.num5   #目的位置
   DEFINE li_idx_t   LIKE type_t.num5   #暫時的位置(因為序號是key)
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_key3    STRING
   DEFINE ls_seq     STRING
   DEFINE l_sql      STRING
   DEFINE lt_sql     STRING
   
   DEFINE  l_tmp     INTEGER

   IF ps_type = "up" THEN
      LET li_step = -1
   ELSE
      LET li_step = 1
   END IF

   LET li_idx = gdig_curr.getCurrentRow(ps_array)
   #LET li_idx_p = li_idx + li_step  #160926-00005#1 .3 mark
   #array對應的Table及順序欄位指定
   CASE ps_array                 
      WHEN "s_detail1"   
         LET ls_table = "gzib_t"
         LET ls_key1 = "gzib001"
         LET ls_seq = "gzib003" 
         LET li_idx=g_gzib_d[li_idx].gzib003    #160926-00005#1 .3 add     
         
      WHEN "s_detail2"
         LET ls_table = "gzie_t"
         LET ls_key1 = "gzie001"
         LET ls_seq = "gzie002" 
         LET li_idx=g_gzib2_d[li_idx].gzie002    #160926-00005#1 .3 add    
    
      WHEN "s_detail3"      
          LET ls_table="gzid_t"
          LET ls_key1="gzid001"
          LET ls_seq ="gzid007"
          LET li_idx=g_gzib3_d[li_idx].gzid007   #160926-00005#1 .3 add    

   END CASE
   LET li_idx_p = li_idx + li_step  #160926-00005#1 .3 add

       
   LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
              " WHERE ",ls_key1," = '", g_gzia_m.gzia001,"'"

   PREPARE change_seq_tmploction_pre FROM g_sql
   EXECUTE change_seq_tmploction_pre INTO li_idx_t
   IF li_idx_t IS NULL THEN
      LET li_idx_t = 1
   END IF

   LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ? ",
               " WHERE ",ls_key1," = '", g_gzia_m.gzia001,"' AND ",ls_seq," = ?"
   
   PREPARE change_seq_pre FROM g_sql
   #先把目的位置的資料搬去最後一筆
   EXECUTE change_seq_pre USING li_idx_t, li_idx_p
   #把指定位置的資料搬到目的位置
   EXECUTE change_seq_pre USING li_idx_p, li_idx
   #再把暫時丟到最後一筆的資料放回指定位置
   EXECUTE change_seq_pre USING li_idx, li_idx_t

   #重整
   CASE ps_array
 
      WHEN "s_detail1"
         CALL azzi310_gziblist_b_fill()  
      WHEN "s_detail2"
         CALL azzi310_gzielist_b_fill()  
      WHEN "s_detail3"
         CALL azzi310_gzidlist_b_fill()
         
   END CASE
   #最後, 指標要跟著指定資料跑
    #CALL gdig_curr.setCurrentRow(ps_array, li_idx_p) #160926-00005#1 .3 mark

   #上下按鍵要跟著開關
   #160926-00005#1 .3 mark(s)
#   CASE ps_array
#      WHEN "s_detail1"
#         CALL azzi310_set_seqaction_active("s_detail1", "groupup", "groupdown")    
#      WHEN "s_detail2"
#         CALL azzi310_set_seqaction_active("s_detail2", "argup", "argdown")        
#      WHEN "s_detail3"
#         CALL azzi310_set_seqaction_active("s_detail3", "qbeup", "qbedown")                     
#   END CASE
      #160926-00005#1 .3 mark(e)
      
         #上下按鍵要跟著開關
   #161027-00030#1 add(s)
   CASE ps_array
      WHEN "s_detail1"
         CALL azzi310_set_seqaction_active("s_detail1", "groupup", "groupdown",li_idx_p)    
      WHEN "s_detail2"
         CALL azzi310_set_seqaction_active("s_detail2", "argup", "argdown",li_idx_p)        
      WHEN "s_detail3"
         CALL azzi310_set_seqaction_active("s_detail3", "qbeup", "qbedown",li_idx_p)                     
   END CASE
#161027-00030#1 add(e)
END FUNCTION

################################################################################
# Descriptions...: 解析sql中的栏位信息
# Memo...........:
# Usage..........: CALL azzi310_parse_sql(p_cmd)
# Input parameter: p_cmd   a:輸入 u:更改 
# Return code....: none
# Date & Author..: 2015/03/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_parse_sql(p_cmd)
    DEFINE p_cmd       LIKE type_t.chr1    # a:輸入 u:更改 
    DEFINE l_text      STRING
    DEFINE l_str       STRING
    DEFINE l_sql       STRING
    DEFINE l_tmp       STRING
    DEFINE l_exesql    STRING
    DEFINE l_tok       base.StringTokenizer 
    DEFINE l_start     LIKE type_t.num5        
    DEFINE l_end       LIKE type_t.num5          
    DEFINE l_feldtmp   STRING
    DEFINE l_feld       DYNAMIC ARRAY OF RECORD
             feldname   STRING, 
             feldalias STRING
           END RECORD  
    DEFINE l_cnts      LIKE type_t.num5
    DEFINE l_felds     STRING    
    DEFINE l_i         LIKE type_t.num5       
    DEFINE l_j         LIKE type_t.num5      
    DEFINE l_k         LIKE type_t.num5 
    DEFINE l_n         LIKE type_t.num5    
    DEFINE l_dzebl003   LIKE dzebl_t.dzebl003     
    DEFINE l_feld_cnt  LIKE type_t.num5           
    DEFINE l_colalias  LIKE dzebl_t.dzebl003   
    DEFINE l_cnt       LIKE type_t.num10 
    DEFINE l_gzid       DYNAMIC ARRAY OF RECORD   
           gzid002         LIKE gzid_t.gzid002,                            
           gzid004         LIKE gzid_t.gzid004,                             
           tag           LIKE type_t.chr1 
                         END RECORD                            
    DEFINE l_tab_name  STRING    
    DEFINE l_wc        STRING   
    DEFINE l_wc2       STRING    
   # DEFINE l_column    LIKE dzeb_t.dzeb002
    DEFINE l_column    LIKE type_t.chr30  #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
    DEFINE l_tabname STRING  #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
    DEFINE l_column1  LIKE type_t.chr30   #161125-00024#1 add
    CALL g_feld.clear()
    DELETE FROM azzi310_xabd
 
    #160711-00011#1 mark(s)
#    LET l_str=g_gzia_m.gzia006
#    LET l_str = l_str.toLowerCase()
#    LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,"\n","",TRUE)
#    WHILE l_tok.hasMoreTokens()
#          LET l_tmp=l_tok.nextToken()
#          IF l_text is null THEN
#             LET l_text = l_tmp.trim()
#          ELSE
#             LET l_text = l_text CLIPPED,' ',l_tmp.trim()
#          END IF
#    END WHILE
     #160711-00011#1 mark(e)
    LET l_text=g_sqlcmd #160711-00011#1 add
    LET g_parsql=l_text  
    LET l_str= g_parsql CLIPPED                           
    LET l_tmp= l_str
    
    #分离栏位
    LET l_start = l_tmp.getIndexOf('select',1)
    IF l_start=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '!' 
      LET g_errparam.extend = "can not execute this command,missing select"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET INT_FLAG=1
      RETURN 
    END IF
     #20160317-00020#1 add(s)
    LET l_start=l_start+7
    IF l_tmp.getIndexOf("distinct",l_start) >0 THEN
       LET l_start=l_tmp.getIndexOf("distinct",l_start)+9
    END IF
    
     IF l_tmp.getIndexOf("unique",l_start) >0 THEN
        LET l_start=l_tmp.getIndexOf("unique",l_start)+7
    END IF
     #20160317-00020#1 add(e)
     
    LET l_end   = l_tmp.getIndexOf('from',1)
    # LET l_str=l_str.subString(l_start+7,l_end-2)   #栏位列表
    #160523-00002#1 mod (s)
   # LET l_str=l_str.subString(l_start,l_end-2)   #栏位列表     #20160317-00020#1 mod
    LET l_str=l_str.subString(l_start,l_end-1)
    #160523-00002#1 mod (e)
    LET l_str=l_str.trim()

    #151214-00004#1 add(s)
    IF (l_str.getIndexOf('case',1) OR l_str.getIndexOf('decode',1) OR l_str.getIndexOf('nvl',1) OR l_str.getIndexOf('to_date',1)) #160711-00011#mod
        AND db_get_database_type() = "ORA" THEN
        LET l_exesql="SELECT " ,l_str," FROM ",g_tabs," where 1=2 " 	
        #CALL azzi310_get_column_info_fromds(l_exesql,"all")
        CALL azzi310_get_column_info_fromds(l_exesql,"all","","") #160523-00002#1 mod  #160721-00005#1 mod 增加参数
    ELSE          
    #151214-00004#1 add(e)
    LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)   
    LET l_i=1     
    WHILE l_tok.hasMoreTokens()
          LET l_feldtmp=l_tok.nextToken()
          LET l_feldtmp=l_feldtmp.trim()
          IF l_feldtmp.getIndexOf(' ',1) THEN    #获取别名                   
              LET l_feld[l_i].feldalias=l_feldtmp.subString(l_feldtmp.getIndexOf(' ',1)+1,l_feldtmp.getLength()) #别名
              LET l_feld[l_i].feldname=l_feldtmp.subString(1,l_feldtmp.getIndexOf(' ',1)-1)                      #栏位名
              #160901-00030#1 add(s)
              IF l_feld[l_i].feldalias.getIndexOf('as ',1) THEN
                 LET l_feld[l_i].feldalias=l_feld[l_i].feldalias.subString(l_feld[l_i].feldalias.getIndexOf('as ',1)+3,l_feld[l_i].feldalias.getLength())
              END IF
              #160901-00030#1 add(e)
          ELSE
          	  LET l_feld[l_i].feldalias=''        #别名  
              LET l_feld[l_i].feldname=l_feldtmp  #栏位名 
          END IF
          LET l_i=l_i+1
    END WHILE
    LET l_feld_cnt=l_i-1
 
    LET l_cnt=1   
    FOR l_i=1 TO l_feld_cnt 
    	 CASE
    	     WHEN l_feld[l_i].feldname = '*'
    	          FOR l_k =1 TO g_tab_cnt
    	          	 #CALL azzi310_get_column_info(g_dbs,g_tab[l_k].tabname,'*')
    	          	 #CALL azzi310_get_column_info(g_dbs,g_tab[l_k].tabname,'*','')   #151214-00004#2  mod 
 	                #160523-00002#1 mod(s)
    	          	 IF g_tab[l_k].views='v' THEN
    	          	    CALL azzi310_get_column_info_fromview(g_tab[l_k].tabname,g_tab[l_k].tabalias,'*','','')   #160721-00005#1 mod 增加一个参数  	                   
    	          	 ELSE
    	          	    CALL azzi310_get_column_info(g_dbs,g_tab[l_k].tabname,g_tab[l_k].tabalias,'*','','')  #151214-00004#2  mod,表名改成别名, #160721-00005#1 mod 增加一个参数  	   	                
    	             END IF
    	             #160523-00002#1 mod(e)    	         
    	         END FOR
  
    	     WHEN  l_feld[l_i].feldname.getIndexOf('.*',1) >=1 
    	           LET l_tab_name=''
    	           LET l_tab_name=l_feld[l_i].feldname.subString(1,l_feld[l_i].feldname.getIndexOf('.*',1)-1)
    	           
    	           FOR l_k=1 TO g_tab_cnt
    	           	 # IF l_tab_name=g_tab[l_k].tabname THEN
    	           	  IF l_tab_name=g_tab[l_k].tabalias THEN    #151214-00004#2  mod,表名改成别名
    	           	  	 EXIT FOR
    	           	  END IF
    	           END FOR
    	           	 #151214-00004#2  mark(s),表名改成别名
    	           #IF l_k > g_tab_cnt THEN            #说明表是别名
    	           #	  FOR l_n=1 TO g_tab_cnt
    	           #	  IF l_tab_name=g_tab[l_n].tabalias THEN
    	           #	  	 LET l_tab_name=g_tab[l_n].tabname
    	           #	  	 EXIT FOR
    	           #	  END IF
    	           #   END FOR
    	           #END IF
    	            #151214-00004#2  mark(e),表名改成别名
    	           #CALL azzi310_get_column_info(g_dbs,l_tab_name,'*')
    	              #160523-00002#1 mod(s)
    	          	 IF g_tab[l_k].views='v' THEN
    	          	    CALL azzi310_get_column_info_fromview(g_tab[l_k].tabname,l_tab_name,'*','','')    #160721-00005#1 mod 增加一个参数  	 	                   
    	          	 ELSE 	                
    	                CALL azzi310_get_column_info(g_dbs,g_tab[l_k].tabname,l_tab_name,'*','','') #151214-00004#1  mod      #160721-00005#1 mod 增加一个参数  	      
    	            END IF
    	             #160523-00002#1 mod(e)
    	           
             WHEN  l_feld[l_i].feldname matches 'count*' OR 
                   l_feld[l_i].feldname matches 'sum*' OR 
                   l_feld[l_i].feldname matches 'avg*' OR 
                   l_feld[l_i].feldname matches 'min*' OR 
                   l_feld[l_i].feldname matches 'max*' OR
                   l_feld[l_i].feldname.getIndexOf("+",1)>0 OR #160901-00030#1 add + - /
                   l_feld[l_i].feldname.getIndexOf("-",1)>0 OR
                   l_feld[l_i].feldname.getIndexOf("/",1)>0 
                   
                     #LET l_exesql="SELECT " ,l_feld[l_i].feldname," FROM ",g_tabs," where 1=2 " 	#160523-00002#1 mark
                     #CALL azzi310_get_column_info_fromds(l_exesql)
                     #CALL azzi310_get_column_info_fromds(l_exesql,'') #151214-00004#1  mod  #160523-00002#1 mark
                     #160523-00002#1 add(s)
                     #160926-00005#1 mod(s)    
                     IF l_feld[l_i].feldname.getIndexOf("(",1)>0 THEN
                        LET l_exesql="SELECT " ,l_feld[l_i].feldname.subString(l_feld[l_i].feldname.getIndexOf("(",1)+1,l_feld[l_i].feldname.getIndexOf(")",1)-1)," FROM ",g_tabs," where 1=2 " 
                     ELSE
                       LET l_exesql="SELECT " ,l_feld[l_i].feldname," FROM ",g_tabs," where 1=2 " 
                     END IF
                     #160926-00005#1 mod(e)
                     CALL azzi310_get_column_info_fromds(l_exesql,'',l_feld[l_i].feldname,l_feld[l_i].feldalias) #160721-00005#1 mod 增加l_feld[l_i].feldalias参数
                     #160523-00002#1 add(e)
    	     OTHERWISE
    	          LET l_k=0        #160523-00002#1 add
    	          LET l_tab_name=''
    	          LET l_tabname='' #151214-00004#1 add 表名
                  LET l_feldtmp=l_feld[l_i].feldname
                  LET l_colalias=l_feld[l_i].feldalias
                  IF l_feld[l_i].feldname.getIndexOf('.',1) THEN
                     LET l_feldtmp=l_feld[l_i].feldname.subString(l_feld[l_i].feldname.getIndexOF('.',1)+1,l_feld[l_i].feldname.getLength())
                     LET l_tab_name=l_feld[l_i].feldname.subString(1,l_feld[l_i].feldname.getIndexOF('.',1)-1)
                     FOR l_k=1 TO g_tab_cnt
    	           	     #IF l_tab_name=g_tab[l_k].tabname THEN
    	           	     IF l_tab_name=g_tab[l_k].tabalias THEN #151214-00004#2 mod,表名改成别名
    	           	        LET l_tabname=g_tab[l_k].tabname    #151214-00004#1 add
    	           	  	    EXIT FOR
    	           	     END IF
    	               END FOR
    	           		 #151214-00004#2  mark(s),表名改成别名
    	              #IF l_k > g_tab_cnt THEN            #说明表是别名
    	           	  #   FOR l_n=1 TO g_tab_cnt
    	           	  #     IF l_tab_name=g_tab[l_n].tabalias THEN
    	           	  #	     LET l_tab_name=g_tab[l_n].tabname
    	           	  #	     EXIT FOR
    	              #	   END IF
    	              #   END FOR
    	              #END IF
    	              	#151214-00004#2  mark(s),表名改成别名
                  END IF
    	         #CALL azzi310_get_column_info(g_dbs,l_tab_name,l_feldtmp)
    	         #160523-00002#1 mod(s)
    	         IF l_k>0 THEN
    	            IF g_tab[l_k].views='v' THEN
    	               CALL azzi310_get_column_info_fromview(l_tabname,l_tab_name,l_feldtmp,l_colalias,'')  #160721-00005#1 mod 增加l_colalias参数  	          
                  ELSE
                     CALL azzi310_get_column_info(g_dbs,l_tabname,l_tab_name,l_feldtmp,l_colalias,'')  #151214-00004#2  mod  	 #160721-00005#1 mod 增加l_colalias参数  	                    
    	            END IF
    	          ELSE
    	            CALL azzi310_get_column_info(g_dbs,l_tabname,l_tab_name,l_feldtmp,l_colalias,'')  #151214-00004#2  mod   #160721-00005#1 mod 增加l_colalias参数  	          
    	          END IF
    	         #160523-00002#1 mod(e)
                 	          
    	          #UPDATE azzi310_xabc SET xabc008=l_colalias WHERE xabc003=l_feld-l_i].feldname #别名重新赋值
    	          
    	 END CASE   
    END FOR
   END IF  #151214-00004#1 add
    
   #IF p_cmd='a' OR (p_cmd='u' AND g_action_choice='sqlverify') THEN
   #161122-00035#1 mod增加g_parse_flag
   IF p_cmd='a'  AND g_parse_flag="a" THEN #160822-00021#1 mod
 #160822-00021#1 mark(s)
#   	 DELETE FROM gzie_t WHERE gzie001=g_gzia_m.gzia001   
#   	 IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "delete gzie_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
#          RETURN
#        END IF
#160822-00021#1 mark(e)       
      FOR l_i=1 to g_args.getLength()
    	  INSERT INTO gzie_t values(g_gzia_m.gzia001,l_i,g_args[l_i],'','')
      END FOR 
     	IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "insert gzie_t" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
           CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
          RETURN
        END IF
        
     	#160822-00021#1 mark(s)
      #DELETE FROM gzid_t WHERE gzid001=g_gzia_m.gzia001      
#      PREPARE gzid_t_del FROM l_sql
#      EXECUTE gzid_t_del      
#      IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "delete gzid_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#           CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
#          RETURN
#        END IF
      #160822-00021#1 mark(e)
      
            LET l_sql="INSERT INTO gzid_t(gzid001,gzid002,gzid003,gzid004,gzid005,gzid006,gzid007,gzid008,",
                                         "gzid009,gzid010,gzid011,gzid012,gzid013,gzid014,gzid015,gzid016)", #160901-00030#1 mod
                      #" SELECT '",g_gzia_m.gzia001,"',xabd001,xabd002,xabd003,'Y',xabd004,0,'','',xabd010,xabd005,''",
                      " SELECT '",g_gzia_m.gzia001,"',xabd001,xabd002,xabd003,'Y',xabd004,0,'N','',xabd010,xabd005,'N',xabd006", #160523-00002#1 mod #160926-00005#1.2mod
                       " ,'N','',xabd008", #160523-00002#2 add  #160721-00005#1 mod 增加xabd008        
                      " FROM azzi310_xabd order by xabd001"

           PREPARE azzi310_gzid_ins_p FROM l_sql
           EXECUTE azzi310_gzid_ins_p  
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "insert gzid_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                 CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                RETURN
              END IF
           UPDATE gzid_t set gzid007=gzid002 where gzid001=g_gzia_m.gzia001
           IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "update gzid_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE               
                CALL cl_err()
                CALL s_transaction_end('N','0')  #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                RETURN
              END IF
               
           #160926-00005#1 .1 add(s) 
           LET l_sql="INSERT INTO gzidl_t(gzidl001,gzidl002,gzidl003,gzidl004) ",
                     " SELECT gzid001,gzid002,dzebl002,dzebl003",
                     " FROM gzid_t,dzebl_t WHERE gzid004=dzebl001 AND gzid001='",g_gzia_m.gzia001,"'"
           PREPARE azzi310_gzidl_ins_p FROM l_sql
           EXECUTE azzi310_gzidl_ins_p  
           IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "insert gzidl_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                RETURN
            END IF                    
           #160926-00005#1 .1 add(e) 
#160822-00021#1 mark(s)
       #160523-00002#1 mod (s)
#       IF p_cmd='u' AND g_action_choice='sqlverify' THEN
#       #151214-00004#1 add(s)  
#         #DELETE FROM gzidl_t WHERE gzidl001=g_gzia_m.gzia001
#         DELETE FROM gzidl_t WHERE gzidl001=g_gzia_m.gzia001 AND gzidl002 NOT IN(SELECT gzid002 FROM gzid_t WHERE gzid001=g_gzia_m.gzia001)
#       IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "delete gzidl_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
#          RETURN
#        END IF     
#        #151214-00004#1 add(e) 
#        END IF
        #160523-00002#1 mod (e)
        
#      DELETE FROM gzig_t WHERE gzig001=g_gzia_m.gzia001  
#      IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "delete gzig_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#           CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
#          RETURN
#        END IF
#  
#      DELETE FROM gzib_t WHERE gzib001=g_gzia_m.gzia001  
#      IF SQLCA.sqlcode AND SQLCA.sqlcode !='100' THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "delete gzib_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
#          RETURN
#        END IF
 #160822-00021#1 mark(e)
      
      #LET l_wc="(" #160822-00021#1 mark
      FOR l_i=1 TO g_tab_cnt
         #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
         #INSERT INTO gzig_t VALUES(g_gzia_m.gzia001,g_tab[l_i].tabname) 
         #LET l_wc=l_wc,"'",g_tab[l_i].tabname,"',"       
         INSERT INTO gzig_t VALUES(g_gzia_m.gzia001,g_tab[l_i].tabname,g_tab[l_i].tabalias) 
         #151214-00004#2 mod(e)
      END FOR
  #160822-00021#1 mark(s)     
#      LET l_wc=l_wc.subString(1,l_wc.getLength()-1),")"
#      
#      IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "insert gzig_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          CALL s_transaction_end('N','0')
#          RETURN
#        END IF
#       
#      LET l_wc2=""
#      LET l_column=""
#      #151214-00004#2 mod(s)
#      #LET l_sql="SELECT unique dzeb002 FROM dzeb_t WHERE dzeb001 in ",l_wc," AND dzeb002 like '%ent' "
#      LET l_sql="SELECT unique gzig003||'.'||dzeb002 FROM dzeb_t,gzig_t ",
#                " WHERE dzeb001 =gzig002 AND gzig001='",g_gzia_m.gzia001,"' AND dzeb002 like '%ent' "
#      #151214-00004#2 mod(s)
#      PREPARE parse_ent_pre FROM l_sql
#      DECLARE parse_ent_curs CURSOR FOR parse_ent_pre
#      FOREACH parse_ent_curs INTO l_column
#          LET l_tmp=l_column,"= :ent"
#          IF g_parsql.getIndexOf(l_tmp,1) THEN
#              CONTINUE FOREACH
#          END IF
#          LET l_tmp=l_column," = :ent"
#         IF g_parsql.getIndexOf(l_tmp,1) THEN
#              CONTINUE FOREACH
#          END IF
#          LET l_wc2=l_wc2,"AND ",l_column,"= :ENT  "         
#      END FOREACH
#      
#      IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "foreach dzeb_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
#          RETURN
#      END IF
 #160822-00021#1 mark(e)
#      LET l_cnt=0
#      LET l_sql ="SELECT count(*) FROM dzea_t WHERE dzea001 in ",l_wc," AND dzea003='AZZ' "
#      PREPARE parse_cnt_pre FROM l_sql
#      EXECUTE parse_cnt_pre INTO l_cnt
      
#      IF l_cnt >0 THEN
#151016-00016#1 mark(s)
#          LET l_column=""
#          LET l_sql="SELECT unique dzeb002 FROM dzeb_t WHERE dzeb001 in ",l_wc," AND dzeb002 like '%site' "
#          PREPARE parse_site_pre FROM l_sql
#          DECLARE parse_site_curs CURSOR FOR parse_site_pre
#          FOREACH parse_site_curs INTO l_column
#             LET l_tmp=l_column,"= :site"
#             IF g_parsql.getIndexOf(l_tmp,1) THEN
#                 CONTINUE FOREACH
#             END IF
#            LET l_tmp=l_column," = :site"
#             IF g_parsql.getIndexOf(l_tmp,1) THEN
#                 CONTINUE FOREACH
#             END IF
#             LET l_wc2=l_wc2,"AND ",l_column,"= :SITE  "
#                        
#          END FOREACH
#      
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "foreach dzeb_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            RETURN
#         END IF
 #151016-00016#1 mark(e)        
#      END IF
  
     IF NOT g_parsql.getIndexOf('where',1) AND not cl_null(l_wc2) THEN  #源sql无where条件
        LET l_wc2="where ",l_wc2.subString(4,l_wc2.getLength())
     END IF
     
     LET l_end=g_parsql.getIndexOf('group',1) 
     IF l_end=0 THEN
        LET l_end=g_parsql.getIndexOf('order',1)
     END IF
     
     IF l_end=0 THEN
      #  LET l_end=g_parsql.getLength()+1
       LET l_text=g_gzia_m.gzia006
      
       LET l_end=l_text.getLength()+1
     END IF
     
     LET l_str=g_gzia_m.gzia006
 
     LET l_str=l_str.subString(1,l_end-1)," ",l_wc2,l_str.subString(l_end,l_str.getLength())
         
     LET g_gzia_m.gzia006=l_str
            
   END IF
   
   #160822-00021#1 add(s)
   IF (p_cmd='u' AND g_action_choice='sqlverify') 
      OR g_parse_flag="u"  #161122-00035#1 add
   THEN
   
   	 DELETE FROM gzie_t WHERE gzie001=g_gzia_m.gzia001   
   	 IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "delete gzie_t" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          CALL s_transaction_end('N','0') 
          RETURN
        END IF
        
       FOR l_i=1 to g_args.getLength()
    	    INSERT INTO gzie_t values(g_gzia_m.gzia001,l_i,g_args[l_i],'','')
       END FOR 
     	 IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "insert gzie_t" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          CALL s_transaction_end('N','0') 
          RETURN
        END IF
        
     
        LET l_sql="DELETE FROM gzid_t WHERE gzid001='",g_gzia_m.gzia001,"'",
                  " AND (gzid002,gzid003,gzid004) NOT IN(SELECT xabd001,xabd002,xabd003 FROM azzi310_xabd) "
        PREPARE gzid_t_del FROM l_sql
        EXECUTE gzid_t_del      

        IF SQLCA.sqlcode AND SQLCA.sqlcode !='100'THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "delete gzid_t" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           CALL s_transaction_end('N','0') 
           RETURN
         END IF
   
         DELETE FROM gzidl_t WHERE gzidl001=g_gzia_m.gzia001 AND gzidl002 NOT IN(SELECT gzid002 FROM gzid_t WHERE gzid001=g_gzia_m.gzia001)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "delete gzidl_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0') 
            RETURN
          END IF
          
        LET l_sql=" DELETE FROM azzi310_tmp01 ",      
                  " WHERE gzic001 = '",g_gzia_m.gzia001,"'",                               
                  " AND (gzic002,id2) NOT IN(SELECT xabd001,xabd003 FROM azzi310_xabd) ",  
                  " AND type2 !='6' ",              #排除父节点
                  " AND pidseq2=0 "  #子节点
                  
       PREPARE tmp01_del FROM l_sql
       EXECUTE tmp01_del    
       IF SQLCA.sqlcode AND SQLCA.sqlcode !='100' THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "delete azzi310_tmp01" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           CALL s_transaction_end('N','0') 
           RETURN
       END IF
       
         LET l_sql= "INSERT INTO gzid_t(gzid001,gzid002,gzid003,gzid004,gzid005,gzid006,gzid007,gzid008,",
                                         "gzid009,gzid010,gzid011,gzid012,gzid013,gzid014,gzid015,gzid016)", #160901-00030#1 mod
                   " SELECT '",g_gzia_m.gzia001,"',xabd001,xabd002,xabd003,'Y',xabd004,0,'N','',xabd010,xabd005,'N',xabd006", #160523-00002#1 mod 
                   " ,'N','',xabd008", #160926-00005#1.2mod
                   " FROM azzi310_xabd ",
                   " WHERE (xabd001,xabd002,xabd003) NOT IN(SELECT gzid002,gzid003,gzid004 FROM gzid_t WHERE gzid001='",g_gzia_m.gzia001,"')"
                  ," order by xabd001"

          PREPARE azzi310_gzid_ins_p1 FROM l_sql
          EXECUTE azzi310_gzid_ins_p1 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "insert gzid_t" 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             CALL s_transaction_end('N','0') 
             RETURN
           END IF
           UPDATE gzid_t set gzid007=gzid002 where gzid001=g_gzia_m.gzia001
           AND (gzid007 =0 OR gzid007 IS NULL)  
           IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "update gzid_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE               
               CALL cl_err()
               CALL s_transaction_end('N','0') 
               RETURN
            END IF
            
           #160926-00005#1 .1 add(s) 
           LET l_sql="INSERT INTO gzidl_t(gzidl001,gzidl002,gzidl003,gzidl004) ",
                     " SELECT gzid001,gzid002,dzebl002,dzebl003",
                     " FROM gzid_t,dzebl_t WHERE gzid004=dzebl001 AND gzid001='",g_gzia_m.gzia001,"'",
                     "  AND gzid002 not in(select gzidl002 from gzidl_t where gzidl001='",g_gzia_m.gzia001,"') "
           PREPARE azzi310_gzidl_ins_p1 FROM l_sql
           EXECUTE azzi310_gzidl_ins_p1  
           IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "insert gzidl_t 1" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                CALL s_transaction_end('N','0') #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                RETURN
            END IF                    
           #160926-00005#1 .1 add(e) 
#161202-00026#1 mark(s)
#          DELETE FROM gzig_t WHERE gzig001=g_gzia_m.gzia001  
#          IF SQLCA.sqlcode AND SQLCA.sqlcode !='100'THEN
#             INITIALIZE g_errparam TO NULL 
#             LET g_errparam.extend = "delete gzig_t" 
#             LET g_errparam.code   = SQLCA.sqlcode 
#             LET g_errparam.popup  = TRUE 
#             CALL cl_err()
#             CALL s_transaction_end('N','0') 
#             RETURN
#           END IF
#        LET l_wc="("  
#        FOR l_i=1 TO g_tab_cnt             
#           INSERT INTO gzig_t VALUES(g_gzia_m.gzia001,g_tab[l_i].tabname,g_tab[l_i].tabalias) 
#           LET l_wc=l_wc,"'",g_tab[l_i].tabname,"','",g_tab[l_i].tabalias,"',"
#        END FOR
#        LET l_wc=l_wc.subString(1,l_wc.getLength()-1)||")"
# 
#       IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "insert gzig_t" 
#          LET g_errparam.code   = SQLCA.sqlcode 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          CALL s_transaction_end('N','0')
#          RETURN
#       END IF
        
#        LET l_sql="SELECT gzib003 FROM gzib_t WHERE gzib001='",g_gzia_m.gzia001,"' AND gzib007 NOT IN",l_wc
         #161202-00026#1 mark(e) 
        #161202-00026# add(s)
        LET l_sql="SELECT gzib003 FROM gzib_t,gzig_t ",
                  " WHERE gzib001 = gzig001",
                  "   AND gzib007 = gzig003",
                  "   AND gzib001='",g_gzia_m.gzia001,"'",
                  "   AND gzig001='",g_gzia_m.gzia001,"'"
        LET l_wc="("
        FOR l_i=1 TO g_tab_cnt 
            LET l_wc=l_wc,"'",g_tab[l_i].tabname,"',"
        END FOR  
        LET l_wc=l_wc.subString(1,l_wc.getLength()-1)||")" 
        LET l_sql=l_sql," AND gzig002 NOT IN",l_wc
        #161202-00026# add(e)
        
        PREPARE gzib003_sel_pre FROM l_sql
        DECLARE gzib003_sel_cs CURSOR FOR gzib003_sel_pre
        FOREACH gzib003_sel_cs INTO l_i
        　　CALL azzi310_maintain_gzib(l_i,"del")
        END FOREACH
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "foreach delete azzi310_tmp01" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           CALL s_transaction_end('N','0') 
           RETURN
         END IF 
         #161202-00026#1 add(s)
         LET l_sql="UPDATE gzib_t SET gzib007 = ? ",
                   " WHERE gzib001 ='",g_gzia_m.gzia001,"'",
                   "   AND gzib007 = (SELECT distinct gzig003 FROM gzig_t WHERE gzig001='",g_gzia_m.gzia001,"'",
                                                                 " AND gzig002 = ?)"
          PREPARE gzib007_upd FROM l_sql
          FOR l_i = 1 TO g_tab_cnt
              EXECUTE gzib007_upd USING g_tab[l_i].tabalias,g_tab[l_i].tabname
              
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "update gzib007", g_tab[l_i].tabalias
                 LET g_errparam.code   = SQLCA.sqlcode 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 CALL s_transaction_end('N','0') 
                 RETURN
              END IF 
          END FOR 
          
       DELETE FROM gzig_t WHERE gzig001=g_gzia_m.gzia001  
          IF SQLCA.sqlcode AND SQLCA.sqlcode !='100'THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "delete gzig_t" 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             CALL s_transaction_end('N','0') 
             RETURN
           END IF
        LET l_wc="("  
        FOR l_i=1 TO g_tab_cnt             
           INSERT INTO gzig_t VALUES(g_gzia_m.gzia001,g_tab[l_i].tabname,g_tab[l_i].tabalias) 
           LET l_wc=l_wc,"'",g_tab[l_i].tabname,"','",g_tab[l_i].tabalias,"',"
        END FOR
        LET l_wc=l_wc.subString(1,l_wc.getLength()-1)||")"
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "insert gzig_t" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          CALL s_transaction_end('N','0')
          RETURN
       END IF

         #161202-00026#1 add(e)
        
    END IF #p_cmd='u'
      LET l_wc2=""
      LET l_column=""
      LET l_column1=""  #161125-00024#1 add 
      LET l_sql="SELECT unique gzig003||'.'||dzeb002,dzeb002 FROM dzeb_t,gzig_t ", #161125-00024#1 mod
                " WHERE dzeb001 =gzig002 AND gzig001='",g_gzia_m.gzia001,"' AND dzeb002 like '%ent' "
      PREPARE parse_ent_pre FROM l_sql
      DECLARE parse_ent_curs CURSOR FOR parse_ent_pre
      LET l_text=g_gzia_m.gzia006
      LET l_text=l_text.toLowerCase()
      FOREACH parse_ent_curs INTO l_column,l_column1  #161125-00024#1 mod       
          LET l_tmp=l_column,"= :ent"
          IF l_text.getIndexOf(l_tmp,1) THEN
              CONTINUE FOREACH
          END IF
          LET l_tmp=l_column," = :ent"  
          IF l_text.getIndexOf(l_tmp,1) THEN
              CONTINUE FOREACH
          END IF
          #161125-00024#1 add(s)
          LET l_tmp=l_column1,"= :ent"
          IF l_text.getIndexOf(l_tmp,1) THEN
              CONTINUE FOREACH
          END IF
          LET l_tmp=l_column1," = :ent"  
          IF l_text.getIndexOf(l_tmp,1) THEN
              CONTINUE FOREACH
          END IF
          #161125-00024#1 add(e)
          LET l_wc2=l_wc2,"AND ",l_column,"= :ENT  "         
      END FOREACH
       
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "foreach dzeb_t" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          CALL s_transaction_end('N','0') 
          RETURN
      END IF
      #161125-00024#1 add(s)
      IF NOT cl_null(l_wc2) THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = l_wc2 
          LET g_errparam.code   = "azz-01160" 
          LET g_errparam.popup  = FALSE
          CALL cl_err()
      END IF
      #161125-00024#1 add(e)  
      #161125-00024#1 mark(s)      
#     IF NOT g_parsql.getIndexOf('where',1) AND not cl_null(l_wc2) THEN 
#        LET l_wc2="where ",l_wc2.subString(4,l_wc2.getLength())
#     END IF
#      
#     
#     LET l_end=l_text.getIndexOf('group',1) 
#     IF l_end=0 THEN
#        LET l_end=l_text.getIndexOf('order',1)
#     END IF
#     
#     IF l_end=0 THEN
#       LET l_text=g_gzia_m.gzia006
#      
#       LET l_end=l_text.getLength()+1
#     END IF
#     
#     LET l_str=g_gzia_m.gzia006
# 
#     LET l_str=l_str.subString(1,l_end-1)," ",l_wc2,l_str.subString(l_end,l_str.getLength())
#         
#     LET g_gzia_m.gzia006=l_str
            
   #160822-00021#1 add(e)
   #161125-00024#1 makr(e)  
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_parse_sqltable(p_cmd)
#                  RETURNING 回传参数
# Input parameter: p_cmd  # a:輸入 u:更改 
# Return code....: none
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi310_parse_sqltable(p_cmd)
 DEFINE p_cmd       LIKE type_t.chr1    # a:輸入 u:更改 
   DEFINE l_str       STRING
   DEFINE l_tmp       STRING
   DEFINE l_text      STRING
   DEFINE l_tab       DYNAMIC ARRAY OF RECORD
             tabname  LIKE dzea_t.dzea001,
             tabalias STRING
           END RECORD
   DEFINE l_table_tok base.StringTokenizer  
   DEFINE l_tok       base.StringTokenizer 
   DEFINE l_tabtmp    STRING
   DEFINE l_tab_cnt   LIKE type_t.num5 
   DEFINE l_start     LIKE type_t.num5        
   DEFINE l_end       LIKE type_t.num5 
   DEFINE l_i         LIKE type_t.num5       
   DEFINE l_j         LIKE type_t.num5      
   DEFINE l_k         LIKE type_t.num5 
   DEFINE l_n         LIKE type_t.num5 
   
   
    CALL g_tab.clear()
  #160711-00011#1 mark(s)  
#    LET l_str= g_gzia_m.gzia006 CLIPPED                               
#    LET l_str = l_str.toLowerCase()
#    LET l_end = l_str.getIndexOf(';',1)
#    IF l_end != 0 THEN
#       LET l_str=l_str.subString(1,l_end-1)
#    END IF
#    LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,"\n","",TRUE)
#    WHILE l_tok.hasMoreTokens()
#          LET l_tmp=l_tok.nextToken()
#          IF l_text is null THEN
#             LET l_text = l_tmp.trim()
#          ELSE
#             LET l_text = l_text CLIPPED,' ',l_tmp.trim()
#          END IF
#    END WHILE
     #160711-00011#1 mark(e)
    LET l_text=g_sqlcmd  #160711-00011#1 add(s)
    LET g_parsql=l_text 
    LET l_str=g_parsql
    
    LET l_start = l_str.getIndexOf('from',1)
    LET l_end   = l_str.getIndexOf('where',1)
    IF l_end=0 THEN
       LET l_end   = l_str.getIndexOf('group',1)
       IF l_end=0 THEN
          LET l_end   = l_str.getIndexOf('order',1)
          IF l_end=0 THEN
             LET l_end=l_str.getLength()
             LET l_str=l_str.subString(l_start+5,l_end)
          ELSE
             LET l_str=l_str.subString(l_start+5,l_end-2)
          END IF
       ELSE
          LET l_str=l_str.subString(l_start+5,l_end-2)
       END IF
    ELSE
       LET l_str=l_str.subString(l_start+5,l_end-2)
    END IF
    
    LET l_str=l_str.trim()
    LET g_tabs=l_str
    LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE) #表列表
    LET l_j=1
    WHILE l_tok.hasMoreTokens()
          #---FUN-AC0011---start-----
          #因為sql語法中FROM後面的table有可能會以 JOIN 的形式出現
          LET l_str = l_tok.nextToken()

          #依照關鍵字去除,取代成逗號,以利分割table
          LET l_text = "left outer join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
          LET l_text = "right outer join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
          LET l_text = "outer join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
          #151214-00004#1 add (s)
          LET l_text = "inner join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
          #151214-00004#1 add (e)
          LET l_text = "left join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
          LET l_text = "right join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
           LET l_text = "join"
          CALL cl_replace_str(l_str, l_text.toLowerCase(), ",") RETURNING l_str
          WHILE l_str.getIndexOf("on", 1) > 0
                #準備將on後面的條件式去除
                LET l_start = l_str.getIndexOf("on", 1) 

                #從剛才找出on關鍵字地方關始找下一個逗號,應該就是此次所要截取的table名稱和別名
                #如果後面已找不到逗號位置,代表應該已到字串的最尾端
                LET l_end = l_str.getIndexOf(",", l_start)  
                IF l_end = 0 THEN
                   LET l_end = l_str.getLength() + 1   #因為下面會減1,所以這裡先加1
                END IF
                LET l_text = l_str.subString(l_start, l_end - 1)        #on后面的条件
                CALL cl_replace_str(l_str, l_text, " ") RETURNING l_str #把条件替成空
          END WHILE

          #依逗號區隔出各table名稱和別名
          LET l_table_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)
          WHILE l_table_tok.hasMoreTokens()
                LET l_tabtmp= l_table_tok.nextToken()   #FUN-AC0011
                LET l_tabtmp=l_tabtmp.trim()
                IF l_tabtmp.getIndexOf(' ',1) THEN  #获取别名                   
                   LET l_tab[l_j].tabalias=l_tabtmp.subString(l_tabtmp.getIndexOf(' ',1)+1,l_tabtmp.getLength()) #别名
                   LET l_tab[l_j].tabname=l_tabtmp.subString(1,l_tabtmp.getIndexOf(' ',1)-1)  #表名
                ELSE
                	  #LET l_tab[l_j].tabalias=''
                	 LET l_tab[l_j].tabalias=l_tabtmp   #151214-00004#2 mod,若无别名，取表名的值
                   LET l_tab[l_j].tabname=l_tabtmp #表名
                END IF
                LET g_tab[l_j].tabname=l_tab[l_j].tabname 
                LET g_tab[l_j].tabalias=l_tab[l_j].tabalias.trim()
                LET l_j=l_j+1
          END WHILE   
    END WHILE
    LET g_tab_cnt=l_j-1
    CALL g_tab.deleteElement(l_j)
    LET l_j=l_j-1
    
        
    #160523-00002#1 add(s)
     FOR l_j =1 TO g_tab_cnt
         LET l_n=0
         SELECT count(*) INTO l_n FROM dzea_t WHERE dzea001=g_tab[l_j].tabname
         IF l_n=0 THEN
             LET g_tab[l_j].views='v'
         END IF
     END FOR
    #160523-00002#1 add(e)
    
END FUNCTION

################################################################################
# Descriptions...: 依照有無資料動態切換指定功能鍵
# Memo...........:
# Usage..........: CALL azzi310_set_action_active_by_datasize(ps_array, ps_action)
# Input parameter: ps_array        要檢測的array名稱
#                : ps_action       要開關的功能鍵
# Return code....: none
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_set_action_active_by_datasize(ps_array,ps_action)
  DEFINE ps_array        STRING
   DEFINE ps_action       STRING

   IF gdig_curr.getArrayLength(ps_array) <= 0 THEN
      CALL gdig_curr.setActionActive(ps_action, FALSE)
   ELSE
      CALL gdig_curr.setActionActive(ps_action, TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 動態切換調整順序功能鍵
# Memo...........:
# Usage..........: CALL azzi310_set_seqaction_active(ps_array, ps_upaction, ps_downaction,ps_seq)
#                  RETURNING 回传参数
# Input parameter: ps_array        要檢測的array名稱
#                : ps_upaction     往上功能鍵id
#                : ps_downaction   往下功能鍵id
#                : ps_seq          栏位目前的顺序
# Return code....: None
# Date & Author..: 2015/07/13
# Modify.........: 2016/10/12 #160926-00005#1 .3  增加ps_seq
################################################################################
PRIVATE FUNCTION azzi310_set_seqaction_active(ps_array,ps_upaction,ps_downaction,ps_seq)
   DEFINE ps_array        STRING
   DEFINE ps_upaction     STRING
   DEFINE ps_downaction   STRING
   DEFINE ps_seq          LIKE type_t.num5 #160926-00005#1 .3 add
   DEFINE li_idx          LIKE type_t.num5
   DEFINE l_max_idx       LIKE type_t.num5
   

   IF gdig_curr.getArrayLength(ps_array) = 0 THEN
      CALL gdig_curr.setActionActive(ps_upaction, FALSE)
      CALL gdig_curr.setActionActive(ps_downaction, FALSE)
   ELSE
      CALL gdig_curr.setActionActive(ps_upaction, TRUE)
      CALL gdig_curr.setActionActive(ps_downaction, TRUE)

     # IF gdig_curr.getCurrentRow(ps_array) = 1 THEN   
     IF ps_seq=1 THEN   #160926-00005#1 .3 mod
         CALL gdig_curr.setActionActive(ps_upaction, FALSE)
      END IF
     # IF gdig_curr.getCurrentRow(ps_array) = gdig_curr.getArrayLength(ps_array) THEN
      IF ps_seq= gdig_curr.getArrayLength(ps_array) THEN #160926-00005#1 .3 mod
         CALL gdig_curr.setActionActive(ps_downaction, FALSE)
      END IF
      LET li_idx = gdig_curr.getCurrentRow(ps_array)       
   END IF
END FUNCTION

################################################################################
# Descriptions...: 汇总页签-左树状列表
# Memo...........:
# Usage..........: CALL azzi310_sumy1_b_fill()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/13
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sumy1_b_fill()
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_cnt       LIKE type_t.num5 
   DEFINE lc_tablename LIKE dzeal_t.dzeal003
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_userdef    LIKE type_t.chr10

   CALL g_sumylist1.clear()  

   LET li_cnt = 1   
   LET li_cnt = 1
   FOR li_i = 1 TO g_tab_cnt

       SELECT dzeal003 INTO lc_tablename FROM dzeal_t 
        WHERE dzeal001 = g_tab[li_i].tabname AND dzeal002 = g_dlang 
   
       LET g_sumylist1[li_cnt].sumyname1 = g_tab[li_i].tabname,":", lc_tablename
       #151214-00004#2  add(s)  #增加资料表别名的信息，解决一表多用问题
       IF g_tab[li_i].tabname != g_tab[li_i].tabalias AND g_tab[li_i].tabalias IS NOT NULL 
       AND g_tab[li_i].tabalias !=" " AND g_tab[li_i].tabalias IS NOT NULL !="" THEN
           LET g_sumylist1[li_cnt].sumyname1 = g_tab[li_i].tabname,"(",g_tab[li_i].tabalias,"):", lc_tablename
       END IF
       #151214-00004#2  add(e)
       #151214-00004#2  mod(s)  #增加资料表别名的信息，解决一表多用问题
       LET g_sumylist1[li_cnt].sumyid1 = g_tab[li_i].tabalias
       IF cl_null(g_tab[li_i].tabalias) THEN       
           LET g_sumylist1[li_cnt].sumyid1 = g_tab[li_i].tabname  
       END IF
       #151214-00004#2  mod(s)  
       LET g_sumylist1[li_cnt].sumyexp1 = TRUE   #預設全開
       LET g_sumylist1[li_cnt].sumyisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
        
       #151214-00004#2  mod(s)  #增加资料表别名的信息，解决一表多用问题 
       #CALL azzi310_sumy1_b_fill_child(g_tab[li_i].tabname, li_cnt) RETURNING li_cnt
       CALL azzi310_sumy1_b_fill_child(g_sumylist1[li_cnt].sumyid1, li_cnt) RETURNING li_cnt
       #151214-00004#2  mod(e)  
#       IF li_i=g_tab_cnt THEN
#          EXIT FOR
#       END IF
   END FOR 

  #自定义栏位
     LET l_userdef='user-def'
     SELECT COUNT(*) INTO l_n FROM gzid_t WHERE gzid001=g_gzia_m.gzia001 AND gzid003=l_userdef
     IF l_n>0 THEN       
       LET g_sumylist1[li_cnt].sumyname1 = l_userdef,":", g_ze768
       LET g_sumylist1[li_cnt].sumyid1 = l_userdef
       LET g_sumylist1[li_cnt].sumyexp1 = TRUE   #預設全開
       LET g_sumylist1[li_cnt].sumyisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線        
       CALL azzi310_sumy1_b_fill_child(l_userdef, li_cnt) RETURNING li_cnt
     END IF     

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_sumy1_b_fill_child(pc_dzea001, pi_idx)
#                  RETURNING pi_idx
# Input parameter: pc_dzea001   資料表
#                : pi_idx       最後節點位置
# Return code....: pi_idx       接下來的節點位置
# Date & Author..: 2015/07/13 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sumy1_b_fill_child(pc_dzea001,pi_idx)
DEFINE pc_dzea001      LIKE dzea_t.dzea001
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_prefix    STRING     
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002

 
       LET lc_prefix = pc_dzea001
       LET lc_prefix = lc_prefix.subString(1,lc_prefix.getIndexOf("_",1)-1) 

                  
     LET g_sql="SELECT gzid004,gzidl004 FROM gzid_t ",
               "       LEFT OUTER JOIN gzidl_t ON gzidl001=gzid001 AND gzidl002=gzid002 AND gzidl003='",g_dlang,"'",
               "  WHERE gzid001='",g_gzia_m.gzia001,"' AND gzid003='",pc_dzea001,"'"
      PREPARE azzi310_sumy1_b_fill_pre FROM g_sql
      DECLARE azzi310_sumy1_b_fill_curs CURSOR FOR azzi310_sumy1_b_fill_pre       
       LET pi_idx = pi_idx + 1
        FOREACH azzi310_sumy1_b_fill_curs INTO lc_dzeb002, lc_dzebl003
           IF cl_null(lc_dzebl003) THEN
           #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
              #SELECT dzebl003 INTO lc_dzebl003 FROM dzebl_t WHERE dzebl000=pc_dzea001 AND dzebl001=lc_dzeb002 AND dzebl002=g_dlang
              #160523-00002#1 mod (s)
              SELECT dzebl003 INTO lc_dzebl003 
                FROM dzebl_t,gzig_t 
               WHERE DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=pc_dzea001 
                 AND dzebl001=lc_dzeb002 
                 AND dzebl002=g_dlang
                 AND gzig001=g_gzia_m.gzia001
#               WHERE dzebl000=gzig002
#                 AND DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=pc_dzea001 
#                 AND dzebl001=lc_dzeb002 
#                 AND dzebl002=g_dlang
#                 AND gzig001=g_gzia_m.gzia001
               #160523-00002#1 mod (e)  
                   
              IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "search lc_dzebl003:" 
                 LET g_errparam.code   = SQLCA.sqlcode 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              #151214-00004#1 mod(e) 
           END IF
              #151214-00004#1 add(e)       
       ##若欄位說明null，代表是自定義欄位
      IF cl_null(lc_dzebl003) OR lc_dzebl003 IS NULL THEN        
           LET lc_dzebl003=g_ze768                                    
      END IF
          ##彙總畫面左邊樹也是相同來源
          LET g_sumylist1[pi_idx].sumyname1 = lc_dzeb002,":", lc_dzebl003
          LET g_sumylist1[pi_idx].sumyid1 = lc_dzeb002
          LET g_sumylist1[pi_idx].sumypid1 = pc_dzea001
          LET g_sumylist1[pi_idx].sumyexp1 = FALSE
          LET g_sumylist1[pi_idx].sumyisnode1 = FALSE        

          LET pi_idx = pi_idx + 1
       END FOREACH
       #151214-00004#1 add(s) 
        IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach azzi310_sumy1_b_fill_curs:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
       #151214-00004#1 add(e) 
    RETURN pi_idx
END FUNCTION

################################################################################
# Descriptions...: 汇总页签-已挑选栏位树状
# Memo...........:
# Usage..........: CALL azzi310_sumy2_b_fill()
#                  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sumy2_b_fill()
  DEFINE lc_cnt       LIKE type_t.num5   
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_id2       LIKE type_t.chr20
   DEFINE lc_pid2      LIKE type_t.chr20
   DEFINE lc_exp2      LIKE type_t.chr10
   DEFINE lc_isnode2   LIKE type_t.chr10
   DEFINE lc_type2     LIKE type_t.chr1 
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_type_str   STRING 

 
  
    #sumy2畫面樣版資料


   CALL g_sumylist2.clear()
   LET g_sum_idx = 0
   LET li_cnt = 1

   
     LET lc_id2="node"
     
     LET g_sum_idx=g_sum_idx+1
     LET g_sumylist2[g_sum_idx].sumyname2 = lc_id2,":",g_gzze06,l_type_str
     LET g_sumylist2[g_sum_idx].sumyid2 = lc_id2 
     LET g_sumylist2[g_sum_idx].sumyexp2 = TRUE  #開
     LET g_sumylist2[g_sum_idx].sumyisnode2 = TRUE  #有欄位了  
     LET g_sumylist2[g_sum_idx].sumytype2 = '6'
   
   LET lc_dzebl003 =''
#151214-00004#1 mod(s)    
#   LET g_sql = " SELECT id2, dzebl003, type2 FROM azzi310_sum2_tmp ",   
#               "   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_dlang,"'",   
#               " WHERE gzic001 ='",g_gzia_m.gzia001,"'",                 
#               " AND pid2 ='0' AND type2 != '6' "
   LET g_sql = " SELECT id2, gzidl004, type2 FROM azzi310_tmp01 ",        #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
               "   LEFT OUTER JOIN gzidl_t ON gzidl002 = gzic002 AND gzidl003 ='",g_dlang,"' AND gzidl001='",g_gzia_m.gzia001,"'",   
               " WHERE gzic001 ='",g_gzia_m.gzia001,"'",                 
               " AND pid2 ='0' AND type2 != '6' "
 
   PREPARE sumylist2_b_fill_pre1 FROM g_sql 
   DECLARE sumylist2_b_fill_curs1 CURSOR FOR sumylist2_b_fill_pre1
   FOREACH sumylist2_b_fill_curs1 INTO lc_id2, lc_dzebl003, lc_type2
         
           LET l_type_str = ""
           CASE lc_type2
              WHEN '0'
                LET l_type_str = "(",g_gzze00,")"     #(azz-800),总和
              WHEN '1'
                LET l_type_str = "(",g_gzze01,")"     #(azz-801),最小值
              WHEN '2'
                LET l_type_str = "(",g_gzze02,")"     #(azz-802),最大值
              WHEN '3'
                LET l_type_str = "(",g_gzze03,")"     #(azz-803),数量
              WHEN '4'
                LET l_type_str = "(",g_gzze04,")"     #(azz-804),平均                
           END CASE 
         #151214-00004#1 add(s)  
          IF cl_null(lc_dzebl003) OR lc_dzebl003 IS NULL THEN                 
             SELECT dzebl003 INTO lc_dzebl003 
               FROM dzebl_t 
              WHERE dzebl001=lc_id2 AND dzebl002=g_dlang
          END IF
          #151214-00004#1 add(e)
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) OR lc_dzebl003 IS NULL THEN                 
             LET lc_dzebl003=g_ze768
          END IF     
           
           LET g_sum_idx=g_sum_idx+1
           LET g_sumylist2[g_sum_idx].sumyname2 = lc_id2,":",lc_dzebl003,l_type_str
           LET g_sumylist2[g_sum_idx].sumyid2 = lc_id2 
           LET g_sumylist2[g_sum_idx].sumyexp2 = FALSE  #開
           LET g_sumylist2[g_sum_idx].sumyisnode2 = FALSE  #沒有欄位了  
           LET g_sumylist2[g_sum_idx].sumytype2 = lc_type2
           LET g_sumylist2[g_sum_idx].sumypid2 ="node"        
           LET g_sumylist2[g_sum_idx].sumypidseq2 = "0"
   END FOREACH
   
   LET lc_dzebl003 =''                       
   LET g_sql = " SELECT id2, dzebl003, type2 FROM azzi310_tmp01 ",        #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
               "   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_dlang,"'",   
               " WHERE gzic001 ='",g_gzia_m.gzia001,"'",                 
               " AND pid2 ='0' AND type2='6'"
   PREPARE sumylist2_b_fill_pre FROM g_sql 
   DECLARE sumylist2_b_fill_curs CURSOR FOR sumylist2_b_fill_pre
   FOREACH sumylist2_b_fill_curs INTO lc_id2, lc_dzebl003, lc_type2
         
           LET l_type_str = ""
#           CASE lc_type2
#              WHEN '0'
#                LET l_type_str = "(",g_gzze00,")"     #(azz-800),总和
#              WHEN '1'
#                LET l_type_str = "(",g_gzze01,")"     #(azz-801),最小值
#              WHEN '2'
#                LET l_type_str = "(",g_gzze02,")"     #(azz-802),最大值
#              WHEN '3'
#                LET l_type_str = "(",g_gzze03,")"     #(azz-803),数量
#              WHEN '4'
#                LET l_type_str = "(",g_gzze04,")"     #(azz-804),平均                
#           END CASE 
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) OR lc_dzebl003 IS NULL THEN                 
             LET lc_dzebl003=g_ze768
          END IF     
           
           LET g_sum_idx=g_sum_idx+1
           LET g_sumylist2[g_sum_idx].sumyname2 = lc_id2,":",lc_dzebl003,l_type_str
           LET g_sumylist2[g_sum_idx].sumyid2 = lc_id2 
#           LET g_sumylist2[g_sum_idx].sumyexp2 = FALSE  #開
#           LET g_sumylist2[g_sum_idx].sumyisnode2 = FALSE  #沒有欄位了  
           LET g_sumylist2[g_sum_idx].sumytype2 = lc_type2
          
#           IF lc_type2=='6' THEN
              LET g_sumylist2[g_sum_idx].sumyexp2 = TRUE  #開
              LET g_sumylist2[g_sum_idx].sumyisnode2 = TRUE  
              CALL azzi310_sumy2_b_fill_child(g_sumylist2[g_sum_idx].sumyid2,g_sum_idx) 
#           END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...:  汇总页签-已挑选栏位树状(子节点)
# Memo...........:
# Usage..........: CALL azzi310_sumy2_b_fill_child(ps_pid,ps_cnt)
# Input parameter: ps_pid   父亲节点
#                : ps_cnt   父亲节点位置
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sumy2_b_fill_child(ps_pid,ps_cnt)
 DEFINE ps_pid       LIKE type_t.chr20 
   DEFINE ps_cnt       LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_gzic002   LIKE gzic_t.gzic002
   DEFINE lc_id2       LIKE type_t.chr20
   DEFINE lc_type2     LIKE type_t.chr1 
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_type_str   STRING 
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_sumy_data DYNAMIC ARRAY OF RECORD 
            id2        VARCHAR(20),
            dzebl003   LIKE dzebl_t.dzebl003,
            type2      VARCHAR(1),
            pidseq2    INTEGER  
            END RECORD 
                


   #在FOREACH中直接使用recursive,資料會錯亂,所以先將資料放到陣列後處理
   LET li_cnt = 1
   CALL l_sumy_data.clear()
   #FOREACH azzi310_sumy_getid_cs1 USING g_gzia_m.gzia001,ps_pid INTO l_sumy_data[li_cnt].*
   FOREACH azzi310_sumy_getid_cs1 USING g_gzia_m.gzia001,g_gzia_m.gzia001,ps_pid INTO l_sumy_data[li_cnt].*  #151214-00004#1 mod 
       #151214-00004#1 add(s)  
          IF cl_null(l_sumy_data[li_cnt].dzebl003) OR l_sumy_data[li_cnt].dzebl003 IS NULL THEN                 
             SELECT dzebl003 INTO l_sumy_data[li_cnt].dzebl003
               FROM dzebl_t 
              WHERE dzebl001=l_sumy_data[li_cnt].id2 AND dzebl002=g_dlang
              
          IF SQLCA.sqlcode AND SQLCA.SQLCODE !=100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'search l_sumy_data[li_cnt].dzebl003:'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
          END IF
          #151214-00004#1 add(e)       
       ##若欄位說明null，代表是自定義欄位
      IF cl_null(l_sumy_data[li_cnt].dzebl003) OR l_sumy_data[li_cnt].dzebl003 IS NULL THEN        
           LET l_sumy_data[li_cnt].dzebl003=g_ze768                                    
      END IF       
  
      LET li_cnt = li_cnt + 1
   END FOREACH

   CALL l_sumy_data.deleteElement(li_cnt)
   LET li_cnt = li_cnt - 1

   FOR l_i = 1 TO li_cnt
           LET l_type_str = ""
        CASE l_sumy_data[l_i].type2
              WHEN '0'
                LET l_type_str = g_gzze00     #(azz-800),总和
              WHEN '1'
                LET l_type_str = g_gzze01     #(azz-801),最小值
              WHEN '2'
                LET l_type_str = g_gzze02     #(azz-802),最大值
              WHEN '3'
                LET l_type_str = g_gzze03     #(azz-803),数量
              WHEN '4'
                LET l_type_str = g_gzze04     #(azz-804),平均                
           END CASE            
           LET g_sum_idx = g_sum_idx + 1
           IF l_sumy_data[l_i].pidseq2 < 1 THEN  #不需細展
              LET g_sumylist2[g_sum_idx].sumyexp2 = FALSE  #不開
              LET g_sumylist2[g_sum_idx].sumyisnode2 = FALSE #沒有欄位了
              LET g_sumylist2[g_sum_idx].sumyname2 = l_sumy_data[l_i].id2,":",l_sumy_data[l_i].dzebl003,"(",l_type_str,")"
           ELSE 
              LET g_sumylist2[g_sum_idx].sumyname2 = l_sumy_data[l_i].id2,":",l_sumy_data[l_i].dzebl003
              LET g_sumylist2[g_sum_idx].sumyexp2 = TRUE   #開
              LET g_sumylist2[g_sum_idx].sumyisnode2 = TRUE #有欄位了
           END IF 
           LET g_sumylist2[g_sum_idx].sumyid2 = l_sumy_data[l_i].id2 
           LET g_sumylist2[g_sum_idx].sumypid2 = ps_pid          
           LET g_sumylist2[g_sum_idx].sumytype2 = l_sumy_data[l_i].type2
           LET g_sumylist2[g_sum_idx].sumypidseq2 = l_sumy_data[l_i].pidseq2
           IF l_sumy_data[l_i].pidseq2 > 0 THEN
              CALL azzi310_sumy2_b_fill_child(g_sumylist2[g_sum_idx].sumyid2,g_sum_idx) 
           END IF       
   END FOR 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_sumy2_default()
#                  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/14
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sumy2_default()
DEFINE lc_gzib002   LIKE gzib_t.gzib002
   DEFINE lc_gzib003   LIKE gzib_t.gzib003
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_gzic_cnt   LIKE type_t.num5
   DEFINE lc_type      LIKE type_t.chr1 
   DEFINE lc_gzid004   LIKE gzid_t.gzid004 
   DEFINE lc_gzid002   LIKE gzid_t.gzid002 
   DEFINE lc_dzeb007   LIKE dzeb_t.dzeb007
   DEFINE lc_gzib002_t LIKE gzib_t.gzib002
   DEFINE lc_gzib003_t LIKE gzib_t.gzib003
   DEFINE l_k          LIKE type_t.num5      

   

   CALL g_sumylist2.clear()
   CALL azzi310_delete_temptable() #160523-00002#1 add

   LET g_sql = " INSERT INTO azzi310_tmp01 ",       #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01               
               "VALUES('",g_gzia_m.gzia001,"',?,?,?,?,?,?,?,?,?)"
   PREPARE azzi310_sum2_tmp_ins_pre1 FROM g_sql
   
   LET li_cnt = 1 
      LET g_sql = " SELECT xabd001,xabd003 FROM azzi310_xabd",    #待确定,xabc是否要增加查询单ID呢
                  " WHERE xabd006='number' OR xabd006='NUMBER' ORDER BY xabd001"         
      LET lc_gzib003=0
      LET lc_gzib002='0'    
      PREPARE sumysel_b_fill_pre FROM g_sql
      DECLARE sumysel_b_fill_curs CURSOR FOR sumysel_b_fill_pre                   
      FOREACH sumysel_b_fill_curs INTO lc_gzid002,lc_gzid004             
          IF  lc_gzid004 != lc_gzib002 THEN  #先只做數字型態，搭配(總和) , 也不能於父節點     
              LET l_k = 0  
              EXECUTE azzi310_sum2_tmp_ins_pre1 USING lc_gzid002,lc_gzid004,'N',lc_gzib003,lc_gzib002,'0' ,l_k,'c','1'
              LET li_cnt = li_cnt + 1
          END IF 
      END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_sumylist2_del(ps_idx,p_cnt)
#                  RETURNING p_cnt
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sumylist2_del(ps_idx,p_cnt)
  DEFINE ps_idx      LIKE type_t.num5
	DEFINE p_cnt       LIKE type_t.num5
	DEFINE l_k         LIKE type_t.num5
	DEFINE l_n         LIKE type_t.num5
	DEFINE pi_idx      LIKE type_t.num5
	DEFINE l_sumypid   LIKE gzid_t.gzid004
	DEFINE l_cnt       LIKE type_t.num5
	DEFINE l_i         LIKE type_t.num5
	
	LET l_k=0
	LET l_n=0
	LET l_sumypid=''
	
	#删除父节点下的非父节点
	 SELECT count(*) INTO l_n FROM azzi310_tmp01    #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01
 	  WHERE gzic001=g_gzia_m.gzia001
 	    AND pid2=g_sumylist2[ps_idx].sumyid2
 	    AND type2 !='6'
 	    AND pidseq2=l_k
 	 IF l_n >0 THEN
	    DELETE FROM azzi310_tmp01                #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01 
	     WHERE gzic001=g_gzia_m.gzia001
	       AND  pid2=g_sumylist2[ps_idx].sumyid2
	       AND type2 !='6'
	       AND  pidseq2=l_k
	     LET p_cnt=p_cnt+l_n
	 END IF  
	       
	 #查询父节点下的父节点
	  LET l_k=1
	  LET l_n=0
	  SELECT count(*) INTO l_n FROM azzi310_tmp01        #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01 
 	  WHERE gzic001=g_gzia_m.gzia001
 	    AND pid2=g_sumylist2[ps_idx].sumyid2
 	    AND type2 ='6'
 	    AND pidseq2=l_k 
 	     
	  IF l_n>0 THEN
	  	  DECLARE azzi310_sumy2_del_curs CURSOR FOR 
	  	  	 SELECT id2 FROM azzi310_tmp01        #160727-00019#26 Mod  azzi310_sum2_tmp--> azzi310_tmp01 
	  	  	 WHERE gzic001=g_gzia_m.gzia001
 	           AND pid2=g_sumylist2[ps_idx].sumyid2
 	            AND type2 ='6'
 	           AND pidseq2=l_k 
 	      FOREACH azzi310_sumy2_del_curs INTO l_sumypid
 	      	
	  	     FOR pi_idx = ps_idx+1 TO g_sumylist2.getLength()
	             IF g_sumylist2[pi_idx].sumyid2=l_sumypid THEN          #找父节点位置
	                 CALL azzi310_sumylist2_del(pi_idx,p_cnt) RETURNING p_cnt
	                 EXIT FOR
	             END IF	  	
	  	     END FOR
       	  END FOREACH
	   LET p_cnt=p_cnt+l_n
	  END IF
	  
	  RETURN p_cnt	
END FUNCTION

################################################################################
# Descriptions...: 汇总页签-检查挑选的字段是否有重复, 重复就不进"汇总已选数据表"
# Memo...........:
# Usage..........: CALL azzi310_check_sumy_repeat(pi_idx)
#                  RETURNING li_repeat
# Input parameter: pi_idx    s_tablelist上focus的行數
# Return code....: li_repeat  true/false
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_check_sumy_repeat(pi_idx)
 DEFINE pi_idx     LIKE type_t.num5
   DEFINE li_i       LIKE type_t.num5
   DEFINE li_repeat  LIKE type_t.num5

   FOR li_i = 1 TO g_sumylist2.getLength()
       #先檢查是否有重覆
       IF g_sumylist2[li_i].sumyid2 = g_sumylist1[pi_idx].sumyid1 THEN
          LET li_repeat = TRUE
          EXIT FOR
       END IF
   END FOR

   RETURN li_repeat
END FUNCTION

################################################################################
# Descriptions...: 生成临时表的唯一ID
# Memo...........:
# Usage..........: CALL azzi310_get_tmptbl_id()
#                   
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi310_get_tmptbl_id()
DEFINE li_serial LIKE type_t.num10
   DEFINE ls_serial STRING

   SELECT USERENV('SESSIONID') INTO li_serial FROM DUAL
   LET ls_serial = li_serial

   RETURN ls_serial
END FUNCTION

################################################################################
# Descriptions...: 验证sql
# Memo...........:
# Usage..........: CALL azzi310_sqlverify(p_sql)
#                   
# Input parameter: p_sql   待验证的sql语句
# Return code....: none
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_sqlverify(p_sql)
 DEFINE l_i,l_cnt INTEGER
 DEFINE l_sql     STRING
 DEFINE l_selcnt,l_fromst STRING
 DEFINE l_execmd   STRING
 DEFINE p_sql      STRING
 DEFINE l_tmp      STRING
 DEFINE l_str      STRING
 DEFINE l_text      STRING
 DEFINE l_end      LIKE type_t.num5
 DEFINE l_tok       base.StringTokenizer

 #判断是否嵌套sql
  #有两个SELECT则是嵌套sql
    LET l_sql=p_sql.toLowerCase()
    LET l_selcnt=l_sql.getIndexOf("select",l_sql.getIndexOf("select",1)+1)

    IF l_selcnt >0 THEN
        #包含两个select,报错
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = '!' 
        LET g_errparam.extend = "Nested SQL is not allowed "
        LET g_errparam.popup = FALSE
        CALL cl_err()
        #DISPLAY 'result:',l_selcnt
        RETURN 0
    END IF


 LET l_str= l_sql CLIPPED
    LET l_str = l_str.toLowerCase()
    LET l_end = l_str.getIndexOf(';',1)
    IF l_end != 0 THEN
       LET l_str=l_str.subString(1,l_end-1)
    END IF
    LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,"\n","",TRUE)
    WHILE l_tok.hasMoreTokens()
          LET l_tmp=l_tok.nextToken()
          IF l_text is null THEN
             LET l_text = l_tmp.trim()
          ELSE
             LET l_text = l_text CLIPPED,' ',l_tmp.trim()
          END IF
    END WHILE
    LET l_sql=l_text

  IF NOT azzi310_chk_arg(l_sql) THEN
     RETURN 0
  END IF

  #判断sql的可执行性
  #151214-00004#1 mod(s)
  #LET l_execmd="select count(*) FROM (",g_sqlcmd," )"
  LET l_execmd="select * FROM (",g_sqlcmd," ) where 1=2"
  #151214-00004#1 mod(e)
  PREPARE sql_pre1 FROM l_execmd
  IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "check sql prepare:"
      LET g_errparam.code   = sqlca.sqlcode 
      LET g_errparam.popup  = TRUE
      LET g_errparam.sqlerr   =sqlca.sqlcode
      CALL cl_err()
     RETURN 0
  END IF

  EXECUTE sql_pre1 INTO l_cnt
  IF SQLCA.SQLCODE  AND SQLCA.SQLCODE !=100 THEN  #151214-00004#1 mod
  	  INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "check sql:"
      LET g_errparam.code   = sqlca.sqlcode 
      IF sqlca.sqlerrd[2]='-918' THEN
          LET g_errparam.code   = 'azz-00984'
      END IF
      LET g_errparam.popup  = TRUE
      LET g_errparam.sqlerr   =sqlca.sqlerrd[2]
      
      CALL cl_err()
     RETURN 0
  END IF
  RETURN 1
END FUNCTION

################################################################################
# Descriptions...:参数检测
# Memo...........:
# Usage..........: CALL azzi310_chk_arg(p_sql)
#                  RETURNING l_flag
# Input parameter: p_sql    待检测sql语句
# Return code....: l_flag   true/false
# Date & Author..: 2015/07/14 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_chk_arg(p_sql)
DEFINE l_i         LIKE type_t.num5
DEFINE l_p         LIKE type_t.num5
DEFINE l_arg       STRING
DEFINE l_k         LIKE type_t.num5
DEFINE l_str       STRING
DEFINE p_sql       STRING 
DEFINE l_gzia006   base.StringBuffer

DEFINE l_tag1,l_tag2 STRING
DEFINE l_len         LIKE type_t.num5

#160711-00011#1 add(s)
DEFINE l_tok       base.StringTokenizer 
DEFINE l_tmp       STRING    
DEFINE l_text      STRING
#160711-00011#1 add(e)
    
      LET l_gzia006 = base.StringBuffer.create()
 
      CALL l_gzia006.append(p_sql)
      CALL l_gzia006.toUpperCase()

   #替換掉預設的外部變數名稱，避免影響SQL指令的執行
      #CALL l_gzia006.replace("arg1", "1", 0)
      #CALL l_gzia006.replace("arg2", "1", 0)
      #CALL l_gzia006.replace("arg3", "1", 0)
      #CALL l_gzia006.replace("arg4", "1", 0)
      #CALL l_gzia006.replace("arg5", "1", 0)
      #CALL l_gzia006.replace("arg6", "1", 0)
      #CALL l_gzia006.replace("arg7", "1", 0)
      #CALL l_gzia006.replace("arg8", "1", 0)
      #CALL l_gzia006.replace("arg9", "1", 0)

    
      #SQL允許使用的公用變數代碼
      CALL l_gzia006.replace(":DLANG", "'1'", 0)
      CALL l_gzia006.replace(":LANG", "'1'", 0)
      CALL l_gzia006.replace(":LEGAL", "'1'", 0)
      CALL l_gzia006.replace(":SITE", "'1'", 0)
      CALL l_gzia006.replace(":USER", "'1'", 0)
      CALL l_gzia006.replace(":DEPT", "'1'", 0)
      CALL l_gzia006.replace(":ENT", "'1'", 0)
      #CALL l_gzia006.replace(":TODAY", " TO_DATE('2013/11/20','yyyy/mm/dd') ", 0)
      CALL l_gzia006.replace(":TODAY", "'2013/11/20'", 0)
 
      #CALL l_gzia006.replace(":TODAY", " TO_DATE('2013/11/20','yyyy/mm/dd') ", 0)
      CALL l_gzia006.replace(":TODAY", "'2013/11/20'", 0)
      #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
      CALL l_gzia006.replace(";", "", 1)
      CALL l_gzia006.toLowerCase()
     LET p_sql = l_gzia006.toString()
     LET l_str = p_sql
     #替換掉預設的外部變數名稱，避免影響SQL指令的執行
     LET l_k=1
     FOR l_i = 1 TO 9 
       LET l_arg = "arg",l_i USING '<<<<<'
       LET l_p  = l_str.getIndexOf(l_arg,1)
       IF l_p > 0  THEN 
          LET l_len=l_p-1
          LET l_tag1=l_str.subString(1,l_len)
          LET l_tag2=l_tag1.trimRight() 
          LET l_tag1=l_tag2.subString(l_tag2.getLength()-1,l_tag2.getLength())
          IF l_tag1 matches "*=" OR l_tag1 matches "*'" THEN
             CALL cl_replace_str(l_str, l_arg, '1') RETURNING l_str     
          ELSE
             CALL cl_replace_str(l_str, l_arg, '1=1') RETURNING l_str     
          END IF
          LET g_args[l_k]=l_arg
          LET l_k=l_k+1
       ELSE
          EXIT FOR 
       END IF
      END FOR
     CALL g_args.deleteElement(l_k)
   #超过10个arg参数，报错
   IF l_str.getIndexOf('arg',1) > 0  THEN 
      LET g_sqlcmd=p_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "azz-00765"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN  0
   END IF
   
   #160711-00011#1 add(s)
    LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,"\n","",TRUE)
    WHILE l_tok.hasMoreTokens()
          LET l_tmp=l_tok.nextToken()
          IF l_text is null THEN
             LET l_text = l_tmp.trim()
          ELSE
             LET l_text = l_text CLIPPED,' ',l_tmp.trim()
          END IF
    END WHILE
   LET g_sqlcmd=l_text
   #160711-00011#1 add(e)
  # LET g_sqlcmd=l_str #160711-00011#1 mark
   RETURN  1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
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
PRIVATE FUNCTION azzi310_chk_gzie003()
   DEFINE l_i     LIKE type_t.num5

   LET g_errno = ''

   FOR l_i = 1 TO g_gzib2_d.getLength()
      IF l_i != l_ac THEN
         IF g_gzib2_d[l_ac].gzie003 = g_gzib2_d[l_i].gzie003 THEN
            LET g_errno = 'adz-00041'
            EXIT FOR
         END IF
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 描述说明
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
PRIVATE FUNCTION azzi310_gen_include_4gl()
   DEFINE lchannel_write          base.Channel
#   DEFINE ls_readline             STRING
   DEFINE ls_text                 STRING
   DEFINE ls_code_filename        STRING
#   DEFINE ls_sample_filename      STRING
#   DEFINE lchannel_check          base.Channel
#   DEFINE ls_mdlpath              STRING 
   DEFINE l_pcode_path            STRING
   DEFINE ls_cmd                  STRING
   DEFINE l_chk        LIKE type_t.num5
   DEFINE l_msg        STRING
   DEFINE l_type       STRING    
#   DEFINE l_module     STRING       
   DEFINE  l_sql         STRING
   DEFINE  l_cnt         LIKE type_t.num5
   DEFINE  l_gzid009     LIKE gzid_t.gzid009

 

   #產出程式路徑
 
      SELECT gzza003 INTO g_gzia001_module FROM gzza_t
       WHERE gzza001 =g_prog AND gzzastus ='Y'
         AND gzza002 ='I'
 

   ##$COM/inc/erp/azz/azzi310_qry.4gl
   LET ls_code_filename = os.Path.join(FGL_GETENV("COM"),"inc")
   LET ls_code_filename = os.Path.join(ls_code_filename,"erp")
   LET ls_code_filename = os.Path.join(ls_code_filename,DOWNSHIFT(g_gzia001_module))
   LET ls_code_filename = os.Path.join(ls_code_filename,g_prog||"_qry" CLIPPED||".4gl")  #副檔名改成tgx
   
   #赋给权限
   #IF NOT os.Path.exists(ls_code_filename) THEN
   IF os.Path.exists(ls_code_filename) THEN #160711-00011# mod
       LET ls_cmd = "chmod 777 ",ls_code_filename
       run ls_cmd
   END IF
   
   #先行移除4gl
   IF os.Path.delete(ls_code_filename) THEN
      DISPLAY "刪除舊檔案:",ls_code_filename
   END IF

   #判斷是否砍除成功
   IF NOT os.Path.exists(ls_code_filename) THEN
      DISPLAY "舊檔案刪除成功:",ls_code_filename
   ELSE
      DISPLAY "Error:舊檔案刪除失敗:",ls_code_filename 
       RETURN 
   END IF

   DISPLAY "產生檔位置:",ls_code_filename
 
   LET lchannel_write = base.Channel.create()
   CALL lchannel_write.setDelimiter("")
   
   CALL lchannel_write.openFile( ls_code_filename, "w" )

   LET l_cnt=0
   SELECT count(gzid009) INTO l_cnt FROM  gzid_t WHERE gzid008='Y'
   IF l_cnt=0 THEN
      RETURN 
   END IF
   
    LET ls_text=" DISPLAY 'CASE'"
    CALL lchannel_write.write(ls_text)
    
    LET ls_text="  CASE g_qryparam.ordercons"
    CALL lchannel_write.write(ls_text)
    
    LET l_sql="SELECT distinct gzid009 FROM gzid_t WHERE gzid008='Y' "
    PREPARE azzi310_gen_pb FROM l_sql
    DECLARE gen_inc_cs CURSOR FOR azzi310_gen_pb
                                                    
      FOREACH gen_inc_cs INTO l_gzid009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "GEN_FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
          LET ls_text = "      WHEN '",l_gzid009,"'"
          CALL lchannel_write.write(ls_text)
         
          LET ls_text =" DISPLAY '",l_gzid009,"'"
          CALL lchannel_write.write(ls_text)
         
         LET ls_text= "        CALL ",l_gzid009,"()"
          CALL lchannel_write.write(ls_text)
          
       END FOREACH 
      
       LET ls_text="  OTHERWISE"
       CALL lchannel_write.write(ls_text)
        LET ls_text="DISPLAY 'OTHERWISE'"
       CALL lchannel_write.write(ls_text)
       
       LET ls_text="  END CASE"
       CALL lchannel_write.write(ls_text)

   CALL lchannel_write.close()

   #對產生器寫出的檔案權限在UNIX下均全部打開
   IF os.Path.separator() = "/" THEN
      IF os.Path.chrwx(ls_code_filename,511) THEN
      END IF
   END IF

  
#   LET l_type = sadzp060_2_chk_spec_type(p_code)
#   IF l_type="N" THEN
#      LET l_msg = "ERROR:程式",p_code,"找不到類別,請確認是否已經註冊"
#      DISPLAY "E",l_msg
#      RETURN FALSE
#   END IF
#
#   #取得模組別
#   LET g_gzia001_module = sadzp062_1_find_module(p_code, l_type)
#   LET g_gzia001_module = DOWNSHIFT(g_gzia001_module)
#   IF cl_null(g_gzia001_module) THEN
#      LET l_msg = "ERROR:程式",p_code,"找不到模組,請確認是否已經註冊"
#      DISPLAY "E",l_msg
#      RETURN FALSE
#   END IF
  
       
   LET l_pcode_path = os.Path.join(FGL_GETENV(UPSHIFT(g_gzia001_module)), "4gl")  
   IF os.Path.chdir(l_pcode_path) THEN
       LET ls_cmd = "r.c ",g_prog
       CALL cl_cmdrun_openpipe("r.c",ls_cmd, FALSE) RETURNING l_chk,l_msg
       LET ls_cmd = "r.c azzi310_01" 
       CALL cl_cmdrun_openpipe("r.c",ls_cmd, FALSE) RETURNING l_chk,l_msg
       LET ls_cmd = "r.l ",g_prog
       CALL cl_cmdrun_openpipe("r.l",ls_cmd, FALSE) RETURNING l_chk,l_msg
   END IF
   
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "azz-00922" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
END FUNCTION

################################################################################
# Descriptions...: 从views解析sql栏位
# Memo...........:
# Usage..........: CALL azzi310_get_column_info_fromview(p_viewname,p_viewalias,p_colname,p_colalias,p_flag)
#                 
# Input parameter: p_viewname  资料档名
#                : p_viewalias 资料档别名
#                : p_colname  栏位名
#                : p_colalias 栏位别名
#                : p_flag     标志是否要insert
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........: 160523-00002#1
# Modify.........: 160721-00005#1
################################################################################
PRIVATE FUNCTION azzi310_get_column_info_fromview(p_viewname,p_viewalias,p_colname,p_colalias,p_flag)
DEFINE p_viewname      VARCHAR(20)         
   DEFINE p_viewalias  VARCHAR(20)         
   DEFINE p_colname    VARCHAR(20)
   DEFINE p_colalias   VARCHAR(40)
   DEFINE p_flag      STRING              
   DEFINE l_colname1  STRING
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING
   DEFINE l_exesql    STRING
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_len       LIKE type_t.num5
   DEFINE l_feld  RECORD
       tabname     LIKE dzeb_t.dzeb001,
       feldname    LIKE dzeb_t.dzeb002,
       feldnamec   LIKE dzeb_t.dzeb003,
       feldtype    LIKE dzeb_t.dzeb007,
       feldlen     LIKE gztd_t.gztd010,        #画面宽度
       feldpreci   LIKE type_t.chr10,           #小数位数
       feldalias   LIKE dzgc_t.dzgc007,
       feldprop    LIKE gztd_t.gztd001         #栏位属性
END RECORD
   

    LET p_colname = p_colname CLIPPED
    LET p_colalias = p_colalias CLIPPED #160721-00005#1 add
    LET l_sql = "   SELECT LOWER(column_name),LOWER(data_type),data_length,data_scale ",
               "     FROM user_tab_columns ",
               "    WHERE LOWER(table_name) = '",p_viewname,"' "

   IF p_colname = "*" THEN
      LET l_sql=l_sql," ORDER BY column_id "
   ELSE
      LET l_sql=l_sql," AND LOWER(column_name) = '",p_colname,"' ORDER BY column_id "
   END IF
   
   LET l_sql1="SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE azzi310_vcol_cnt_p FROM l_sql1
   EXECUTE azzi310_vcol_cnt_p INTO l_cnt
   IF l_cnt = 0 THEN
       LET l_sql = "   SELECT LOWER(column_name),LOWER(data_type),data_length,data_scale ",
                   "          ,NVL('",p_colalias,"',LOWER(column_name)) ", #160721-00005#1 add
               "     FROM all_tab_columns ",
               "    WHERE LOWER(table_name) = '",p_viewname,"' "

       IF p_colname = "*" THEN
         LET l_sql=l_sql," ORDER BY column_id "
       ELSE
         LET l_sql=l_sql," AND LOWER(column_name) = '",p_colname,"' ORDER BY column_id "
       END IF
   END IF
   
   LET l_len=g_feld.getLength()+1
   DECLARE get_cols_vc CURSOR FROM l_sql
   
    FOREACH get_cols_vc INTO g_feld[l_len].feldname,g_feld[l_len].feldtype,g_feld[l_len].feldlen,g_feld[l_len].feldpreci
       # SELECT dzebl003 INTO g_feld[l_len].feldnamec FROM dzebl_t WHERE dzebl001=g_feld[l_len].feldname AND dzebl002=g_dlang
#       LET l_colname1 = l_feld.feldname
#       LET l_feld.feldname = l_colname1.toLowerCase()       
#       
#       IF cl_null(g_feld[l_len].feldname) THEN
#          LET g_feld[l_len].feldname=l_feld.feldname
#       END IF
#       
#        IF cl_null(g_feld[l_len].feldlen) THEN
#          LET g_feld[l_len].feldlen=l_feld.feldlen
#       END IF
# 
#       IF cl_null(g_feld[l_len].feldtype) THEN
#          LET g_feld[l_len].feldtype=l_feld.feldtype
#       END IF
#       
#       IF cl_null(g_feld[l_len].feldpreci) THEN
#          LET g_feld[l_len].feldpreci=l_feld.feldpreci
#       END IF
       
      # IF cl_null(g_feld[l_len].feldnamec) THEN
      #    LET g_feld[l_len].feldname='user-def'
      # END IF
      #160721-00005#1 add(s)
      IF cl_null(p_colalias) THEN
          LET g_feld[l_len].feldalias=g_feld[l_len].feldname
      ELSE
          LET g_feld[l_len].feldalias=p_colalias
      END IF
      #160721-00005#1 add(e)
      
       #INSERT INTO azzi310_xabd VALUES(l_len,p_viewalias,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',g_feld[l_len].feldname,g_feld[l_len].feldnamec,g_feld[l_len].feldprop) #160721-00005#1 mark
       INSERT INTO azzi310_xabd VALUES(l_len,p_viewalias,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',g_feld[l_len].feldalias,g_feld[l_len].feldnamec,g_feld[l_len].feldprop) #160721-00005#1 mod
       LET l_len = l_len + 1
   END FOREACH
#   FOREACH get_cols_vc INTO l_feld.feldname,l_feld.feldtype,l_feld.feldlen,l_feld.feldpreci
#    
#       LET l_colname1 = l_feld.feldname
#       LET l_feld.feldname = l_colname1.toLowerCase()       
#    
#    
#      # CALL azzi310_get_column_info(g_dbs,'','',l_feld.feldname,"view")
#       
#       IF cl_null(g_feld[l_len].feldname) THEN
#          LET g_feld[l_len].feldname=l_feld.feldname
#       END IF
#       
#        IF cl_null(g_feld[l_len].feldlen) THEN
#          LET g_feld[l_len].feldlen=l_feld.feldlen
#       END IF
# 
#       IF cl_null(g_feld[l_len].feldtype) THEN
#          LET g_feld[l_len].feldtype=l_feld.feldtype
#       END IF
#       
#       IF cl_null(g_feld[l_len].feldpreci) THEN
#          LET g_feld[l_len].feldpreci=l_feld.feldpreci
#       END IF
#       
#       IF cl_null(g_feld[l_len].feldnamec) THEN
#          LET g_feld[l_len].feldname='user-def'
#       END IF
#
#       
#       INSERT INTO azzi310_xabd VALUES(l_len,p_viewalias,g_feld[l_len].feldname,g_feld[l_len].feldlen,g_feld[l_len].feldpreci,g_feld[l_len].feldtype,'feld',g_feld[l_len].feldname,g_feld[l_len].feldnamec,g_feld[l_len].feldprop)
#
#       LET l_len = l_len + 1
#   END FOREACH
   	CALL g_feld.deleteElement(l_len)
   	LET l_len=l_len-1
END FUNCTION

################################################################################
# Descriptions...: 从VIEW中解析
# Memo...........:
# Usage..........: CALL azzi310_grouplist_b_fill_child_view(pc_dzea001,pi_
#                  RETURNING li_cnt
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:160523-00002#1 增加获取view的栏位的讯息
################################################################################
PRIVATE FUNCTION azzi310_grouplist_b_fill_child_view(pc_dzea001,pi_idx)
DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_prefix    STRING     
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002
   DEFINE lp_idx       LIKE type_t.num5   
   DEFINE l_cnt        LIKE type_t.num5
   
   LET lp_idx=pi_idx 
   LET lc_prefix = pc_dzea001
   LET lc_prefix = lc_prefix.subString(1,lc_prefix.getIndexOf("_",1)-1) 
   LET l_cnt=0
   SELECT count(*) INTO l_cnt FROM USER_VIEWS WHERE LOWER(VIEW_NAME) = pc_dzea001
   IF l_cnt>0 THEN
        LET g_sql="SELECT DISTINCT LOWER(column_name),dzebl003 FROM USER_VIEWS a JOIN USER_TAB_COLUMNS b ON a.VIEW_NAME=b.TABLE_NAME",
             "       LEFT OUTER JOIN dzebl_t ON dzebl001=LOWER(column_name) AND dzebl002='",g_dlang,"'",
             " WHERE LOWER(a.VIEW_NAME)='",pc_dzea001,"'"  
   ELSE
        LET g_sql="SELECT DISTINCT LOWER(column_name),dzebl003 FROM ALL_VIEWS a JOIN ALL_TAB_COLUMNS b ON a.OWNER=b.OWNER AND a.VIEW_NAME=b.TABLE_NAME",
             "       LEFT OUTER JOIN dzebl_t ON dzebl001=LOWER(column_name) AND dzebl002='",g_dlang,"'",
             " WHERE LOWER(a.VIEW_NAME)='",pc_dzea001,"'" 
   END IF                
      PREPARE azzi310_grouplist_b_fill_view_pre FROM g_sql
      DECLARE azzi310_grouplist_b_fill_view_curs CURSOR FOR azzi310_grouplist_b_fill_view_pre       
        LET pi_idx = pi_idx + 1     
        FOREACH azzi310_grouplist_b_fill_view_curs INTO lc_dzeb002, lc_dzebl003 
          IF cl_null(lc_dzebl003) THEN
              LET lc_dzebl003=g_ze768
          END IF          
          LET g_grouplist[pi_idx].groupname = lc_dzeb002,":", lc_dzebl003
          LET g_grouplist[pi_idx].groupid = lc_dzeb002
               
          LET g_grouplist[pi_idx].grouppid = g_grouplist[lp_idx].groupid
          LET g_grouplist[pi_idx].groupexp = FALSE
          LET g_grouplist[pi_idx].groupisnode = FALSE

          LET pi_idx = pi_idx + 1
       END FOREACH
 
   RETURN pi_idx
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL azzi310_chk_json(p_jsonstr)
#                  RETURNING bool
# Input parameter: p_jsonstr     json格式字符串        
# Return code....: bool          true/false
# Date & Author..: #160901-00030#1 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_chk_json(p_jsonstr)
DEFINE p_jsonstr                 STRING
#DEFINE obj                       util.JSONObject
DEFINE jarr                       util.JSONArray


   #LET obj = util.JSONObject.parse(p_jsonstr)
   LET jarr = util.JSONArray.parse(p_jsonstr)
   IF STATUS=-8109 THEN
   　　INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend =""
      LET g_errparam.code   = "azz-01148" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN false
   END IF
   RETURN TRUE
END FUNCTION

 
{</section>}
 
