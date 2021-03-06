#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp540_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-12-27 11:12:01), PR版次:0009(2017-02-13 15:03:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: axmp540_03
#+ Description: 多庫儲批維護
#+ Creator....: 01588(2014-10-21 16:38:02)
#+ Modifier...: 01534 -SD/PR- 02040
 
{</section>}
 
{<section id="axmp540_03.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#22   2016/04/21 BY 07900     校验代码重复错误讯息的修改
#160727-00019#23   2016/08/11 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                          Mod   p540_02_xmdm_temp --> p540_tmp04
#160727-00019#24   2016/08/11 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                          Mod   axmp580_02_temp_d3--> axmp580_tmp03
#161006-00018#25   2016/12/26 By lixh      增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改
#170209-00026#1    2017/02/09 By 02040     1.調整l_num型態LIKE xmdl018，以免簽收數量/出貨數量過大導致錯誤
#                                          2.170117-00044#2延續，簽收單 帶多庫儲批時，依原出貨單帶出儲位、庫存管理特微、只需替代掉成本庫即可
#                                          3.調整簽收量控卡，只需提示訊息，告知總簽收量不等於，待離開畫面時，再控卡嚴僅，以免多次簽收，數量小於無法修改
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
PRIVATE TYPE type_g_xmdm_d        RECORD
       linkno LIKE type_t.chr500, 
   xmdmseq LIKE xmdm_t.xmdmseq, 
   xmdmseq1 LIKE xmdm_t.xmdmseq1, 
   xmdm001 LIKE xmdm_t.xmdm001, 
   xmdm002 LIKE xmdm_t.xmdm002, 
   xmdm003 LIKE xmdm_t.xmdm003, 
   xmdm004 LIKE xmdm_t.xmdm004, 
   cost LIKE type_t.chr500, 
   xmdm005 LIKE xmdm_t.xmdm005, 
   xmdm005_desc LIKE type_t.chr500, 
   xmdm006 LIKE xmdm_t.xmdm006, 
   xmdm006_desc LIKE type_t.chr500, 
   xmdm007 LIKE xmdm_t.xmdm007, 
   xmdm033 LIKE xmdm_t.xmdm033, 
   xmdm008 LIKE xmdm_t.xmdm008, 
   xmdm008_desc LIKE type_t.chr500, 
   inag008 LIKE type_t.chr500, 
   inan010 LIKE type_t.chr500, 
   ready LIKE type_t.chr500, 
   xmdm009 LIKE xmdm_t.xmdm009, 
   xmdm031 LIKE xmdm_t.xmdm031, 
   xmdm010 LIKE xmdm_t.xmdm010, 
   xmdm010_desc LIKE type_t.chr500, 
   xmdm011 LIKE xmdm_t.xmdm011, 
   xmdm032 LIKE xmdm_t.xmdm032
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdm_d_o        type_g_xmdm_d

TYPE type_g_xmdm_data      RECORD
   cost      LIKE type_t.chr1,           #成本庫否
   xmdmseq1  LIKE xmdm_t.xmdmseq1,
   xmdm001   LIKE xmdm_t.xmdm001,
   xmdm002   LIKE xmdm_t.xmdm002,
   xmdm003   LIKE xmdm_t.xmdm003,
   xmdm004   LIKE xmdm_t.xmdm004,
   xmdm005   LIKE xmdm_t.xmdm005,
   xmdm006   LIKE xmdm_t.xmdm006,
   xmdm007   LIKE xmdm_t.xmdm007,
   xmdm008   LIKE xmdm_t.xmdm008,
   xmdm009   LIKE xmdm_t.xmdm009,
   xmdm010   LIKE xmdm_t.xmdm010,
   xmdm011   LIKE xmdm_t.xmdm011,
   xmdm012   LIKE xmdm_t.xmdm012,
   xmdm013   LIKE xmdm_t.xmdm013,
   xmdm014   LIKE xmdm_t.xmdm014,
   xmdm031   LIKE xmdm_t.xmdm031,
   xmdm032   LIKE xmdm_t.xmdm032,
   xmdm033   LIKE xmdm_t.xmdm033
       END RECORD

DEFINE g_xmdl    RECORD   #單頭display欄位
   linkno     LIKE type_t.num5,
   xmdldocno LIKE xmdl_t.xmdldocno,
   xmdlseq   LIKE xmdl_t.xmdlseq,
   xmdl001   LIKE xmdl_t.xmdl001,
   xmdl002   LIKE xmdl_t.xmdl002,
   xmdl003   LIKE xmdl_t.xmdl003,
   xmdl004   LIKE xmdl_t.xmdl004,
   xmdl008   LIKE xmdl_t.xmdl008,
   xmdl009   LIKE xmdl_t.xmdl009,
   xmdl011   LIKE xmdl_t.xmdl011,
   xmdl012   LIKE xmdl_t.xmdl012,
   xmdl017   LIKE xmdl_t.xmdl017,
   xmdl018   LIKE xmdl_t.xmdl018,
   xmdl019   LIKE xmdl_t.xmdl019,
   xmdl020   LIKE xmdl_t.xmdl020,
   xmdl081   LIKE xmdl_t.xmdl081,
   xmdl082   LIKE xmdl_t.xmdl082
                 END RECORD
                 
DEFINE g_booking         LIKE type_t.chr1     #是否使用在揀量(Y/N)
DEFINE g_hidden_ref      LIKE type_t.chr1     #是否使用參考單位(Y/N)
DEFINE g_xmdksite        LIKE xmdk_t.xmdksite #營運據點
DEFINE g_xmdk082         LIKE xmdk_t.xmdk082  #銷退方式
DEFINE g_xmdl013         LIKE xmdl_t.xmdl013  #多庫儲批
DEFINE g_xmdl014         LIKE xmdl_t.xmdl014  #限制庫位
DEFINE g_xmdl015         LIKE xmdl_t.xmdl015  #限制儲位
DEFINE g_xmdl016         LIKE xmdl_t.xmdl016  #限制批號
DEFINE g_xmdl052         LIKE xmdl_t.xmdl052  #限制庫存管理特徵
#end add-point
 
DEFINE g_xmdm_d          DYNAMIC ARRAY OF type_g_xmdm_d
DEFINE g_xmdm_d_t        type_g_xmdm_d
 
 
DEFINE g_xmdmdocno_t   LIKE xmdm_t.xmdmdocno    #Key值備份
DEFINE g_xmdmseq_t      LIKE xmdm_t.xmdmseq    #Key值備份
DEFINE g_xmdmseq1_t      LIKE xmdm_t.xmdmseq1    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
#請依照順序呼叫此Function
#1.CALL axmp540_03_create_temp_table()
#2.CALL s_transaction_begin()
#3.CALL axmp540_03()
#4.CALL s_transaxtion_end('Y',0)
#5.CALL axmp540_03_drop_temp_table()

#傳入參數說明
#p_control       #呼叫此子程式之程式 1.axmt540或axmt541  出貨單
#                                   2.axmt520          出通單
#                                   4.axmt580          簽收單
#                                   5.axmt590          簽退單
#                                   6.axmt600          銷退單
#p_xmdksite      #營運據點
#p_xmdk082       #銷退方式(銷退單使用，其它傳Null)
#p_linkno         #暫存檔之key
#p_xmdmdocno     #單據別
#p_xmdmseq       #項次
#p_xmdl008       #料件編號
#p_xmdl009       #產品特徵
#p_xmdl011       #作業編號
#p_xmdl012       #製程序
#p_xmdl017       #出貨單位
#p_xmdl018       #數量
#p_xmdl081       #簽退數量(簽收、簽退單用)
#p_xmdl019       #參考單位
#p_xmdl020       #參考數量
#p_xmdl082       #簽退參考數量(簽收、簽退單用)
#p_xmdl001       #出通單號(出貨)/出貨、簽收單號(銷退)
#p_xmdl002       #出通項次(出貨)/出貨、簽收項次(銷退)
#p_xmdl003       #來源訂單
#p_xmdl004       #來源訂單項次

#回傳變數說明
#r_success       #執行結果
#r_rollback      #若為TRUE則代表多庫儲批損毀失敗必須在主程式rollback並離開input(因與呼叫來源共用transaction)
#r_xmdl014       #庫位(只有一筆時回傳)
#r_xmdl015       #儲位(只有一筆時回傳)
#r_xmdl016       #批號(只有一筆時回傳)
#r_xmdl052       #庫存管理特徵(只有一筆時回傳)

#end add-point    
 
{</section>}
 
{<section id="axmp540_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmp540_03(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_control,
   p_xmdksite,
   p_xmdk082,
   p_linkno,
   p_xmdmdocno,
   p_xmdmseq,
   p_xmdl008,
   p_xmdl009,
   p_xmdl011,
   p_xmdl012,
   p_xmdl017,
   p_xmdl018,
   p_xmdl081,
   p_xmdl019,
   p_xmdl020,
   p_xmdl082,
   p_xmdl001,
   p_xmdl002,
   p_xmdl003,
   p_xmdl004

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
   DEFINE p_control       LIKE type_t.chr5           #呼叫此子程式之程式
   DEFINE p_xmdksite      LIKE xmdk_t.xmdksite
   DEFINE p_xmdk082       LIKE xmdk_t.xmdk082        #銷退方式(銷退單用)     
   DEFINE p_linkno         LIKE type_t.num5
   DEFINE p_xmdmdocno     LIKE xmdm_t.xmdmdocno
   DEFINE p_xmdmseq       LIKE xmdm_t.xmdmseq
   DEFINE p_xmdl008       LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009       LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011       LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012       LIKE xmdl_t.xmdl012
   DEFINE p_xmdl017       LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018       LIKE xmdl_t.xmdl018
   DEFINE p_xmdl081       LIKE xmdl_t.xmdl081
   DEFINE p_xmdl019       LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020       LIKE xmdl_t.xmdl020
   DEFINE p_xmdl082       LIKE xmdl_t.xmdl082   
   DEFINE p_xmdl001       LIKE xmdl_t.xmdl001
   DEFINE p_xmdl002       LIKE xmdl_t.xmdl002   

   DEFINE p_xmdl003       LIKE xmdl_t.xmdl003
   DEFINE p_xmdl004       LIKE xmdl_t.xmdl004

   DEFINE r_success       LIKE type_t.num5
   DEFINE r_rollback      LIKE type_t.num5
   
   DEFINE r_xmdl014       LIKE xmdl_t.xmdl014
   DEFINE r_xmdl015       LIKE xmdl_t.xmdl015
   DEFINE r_xmdl016       LIKE xmdl_t.xmdl016
   DEFINE r_xmdl052       LIKE xmdl_t.xmdl052   
   
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ship          LIKE ooba_t.ooba001
  #DEFINE l_num           LIKE type_t.num5        #170209-00026#1  mark
   DEFINE l_num           LIKE xmdl_t.xmdl018     #170209-00026#1  add
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmp540_03 WITH FORM cl_ap_formpath("axm","axmp540_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET r_rollback = FALSE
   LET r_xmdl014 = ''
   LET r_xmdl015 = ''
   LET r_xmdl016 = ''
   LET r_xmdl052 = ''

#   #必須包在transaction裡面
#   IF NOT s_transaction_chk('Y',1) THEN
#      LET r_success = FALSE
#
#      CLOSE WINDOW w_axmp540_03
#      RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
#   END IF
   
   LET l_num = 0
   IF cl_null(p_xmdl081) THEN #簽退數量0
      LET l_num = p_xmdl018
   ELSE
      LET l_num = p_xmdl018 + p_xmdl081
   END IF
   
   LET g_errno = ''
   CASE
      WHEN cl_null(p_control) OR cl_null(p_xmdksite)
         LET g_errno = 'sub-00280'  #傳入參數為空或傳入值不正確!
      WHEN cl_null(p_xmdmseq)
         LET g_errno = 'sub-00406'  #傳入的項次為空!
      WHEN cl_null(p_xmdl008)
         LET g_errno = 'sub-00123'  #料件編號不可為空
      WHEN cl_null(p_xmdl017)
         LET g_errno = 'axm-00199'  #單位不可為空！
      WHEN cl_null(p_xmdl018)
         LET g_errno = 'axm-00200'  #數量不可為空！
      WHEN l_num <= 1
         LET g_errno = 'axm-00377'  #數量必須大於2才可做多庫儲批！
   END CASE
          
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE WINDOW w_axmp540_03
      LET r_success = FALSE

      RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052      
   END IF

   INITIALIZE g_xmdl.* TO NULL
   #將主程式的資訊帶入
   LET g_xmdksite = p_xmdksite          #營運據點
   LET g_xmdk082 = p_xmdk082            #銷退方式
   
   LET g_xmdl.linkno   = p_linkno         #暫存檔之key
   LET g_xmdl.xmdldocno = p_xmdmdocno   #單據別
   LET g_xmdl.xmdlseq = p_xmdmseq       #項次
   LET g_xmdl.xmdl008 = p_xmdl008       #料件編號
   LET g_xmdl.xmdl009 = p_xmdl009       #產品特徵
   LET g_xmdl.xmdl011 = p_xmdl011       #作業編號
   LET g_xmdl.xmdl012 = p_xmdl012       #製程序
   LET g_xmdl.xmdl017 = p_xmdl017       #出貨單位
   LET g_xmdl.xmdl018 = p_xmdl018       #數量
   LET g_xmdl.xmdl081 = p_xmdl081       #簽退數量
   LET g_xmdl.xmdl019 = p_xmdl019       #參考單位
   LET g_xmdl.xmdl020 = p_xmdl020       #參考數量
   LET g_xmdl.xmdl082 = p_xmdl082       #簽退參考數量
   LET g_xmdl.xmdl001 = p_xmdl001       #來源單號
   LET g_xmdl.xmdl002 = p_xmdl002       #來源項次
   LET g_xmdl.xmdl003 = p_xmdl003       #來源訂單單號
   LET g_xmdl.xmdl004 = p_xmdl004       #來源訂單項次

   #產品特徵為Null要補' '
   IF cl_null(g_xmdl.xmdl009) THEN LET g_xmdl.xmdl009 = ' ' END IF

   CALL axmp540_03_display_xmdl()        #單頭display      

   #隱藏、替換畫面說明
   CALL axmp540_03_window_show(p_control)

   #檢查是否存在來源限制條件
   LET g_xmdl013 = 'N'  #多庫儲批
   LET g_xmdl014 = ''  #庫位
   LET g_xmdl015 = ''  #儲位
   LET g_xmdl016 = ''  #批號
   LET g_xmdl052 = ''  #庫存管理特徵

   #唯"出通單"與"出貨單"做限制
   IF p_control = '1' OR p_control = '2' THEN      
      CALL s_axmt540_source_define(g_xmdl.xmdl001,g_xmdl.xmdl002,g_xmdl.xmdl003,g_xmdl.xmdl004)
      RETURNING g_xmdl013,g_xmdl014,g_xmdl015,g_xmdl016,g_xmdl052
   END IF

   #清空temp_table
   DELETE FROM axmp540_03_temp

   #塞temp_table
   IF axmp540_03_xmdm_count(p_control) THEN       #檢查是否已有多庫儲批資料
      CALL axmp540_03_insert_temp_table() RETURNING r_success   #僅列出已輸入資料
   ELSE
      CALL axmp540_03_insert_temp_table1(p_control) RETURNING r_success  #將來源、庫存列出
   END IF
   
   IF NOT r_success THEN
      CLOSE WINDOW w_axmp540_03

      RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   END IF

   #顯示單身
   CALL axmp540_03_b_fill(p_control)
      
   CASE p_control
      WHEN '1'  #出貨單
         IF g_xmdl013 = 'Y' THEN #出通單已做多庫儲批
            #列出所有庫存僅供輸入數量
            LET l_allow_insert = FALSE
            LET l_allow_delete = FALSE
         END IF

         #出庫單據考慮在揀量
         CALL s_aooi200_get_slip(g_xmdl.xmdldocno) RETURNING r_success,l_ship
         IF NOT r_success THEN
            CLOSE WINDOW w_axmp540_03

            RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
         ELSE
            CALL cl_get_doc_para(g_enterprise,g_xmdksite,l_ship,'D-BAS-0070') RETURNING g_booking
         END IF
         
      WHEN '2'   #出通單
         #出庫單據考慮在揀量
         CALL s_aooi200_get_slip(g_xmdl.xmdldocno) RETURNING r_success,l_ship
         IF NOT r_success THEN
            CLOSE WINDOW w_axmp540_03
            
            RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
         ELSE
            CALL cl_get_doc_para(g_enterprise,g_xmdksite,l_ship,'D-BAS-0070') RETURNING g_booking
         END IF

      WHEN '6'   #銷退單
         LET l_allow_insert = TRUE
         LET l_allow_delete = TRUE

      OTHERWISE  #簽收單、簽退單
         LET l_allow_insert = FALSE
         LET l_allow_delete = FALSE
            
   END CASE

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdm_d FROM s_detail1.*
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
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx

            IF g_rec_b >= l_ac THEN
               LET l_cmd = 'u'
               LET g_xmdm_d_t.* = g_xmdm_d[l_ac].*  #BACKUP
               LET g_xmdm_d_o.* = g_xmdm_d[l_ac].*
            ELSE
               LET l_cmd = 'a'
            END IF

            CALL axmp540_03_set_entry()
            CALL axmp540_03_set_no_entry(p_control)
                        
         BEFORE INSERT                  
            LET l_cmd = 'a'
            INITIALIZE g_xmdm_d_t.* TO NULL
            INITIALIZE g_xmdm_d_o.* TO NULL
            INITIALIZE g_xmdm_d[l_ac].* TO NULL
            
            LET g_xmdm_d[l_ac].linkno = g_xmdl.linkno
            LET g_xmdm_d[l_ac].xmdmseq = g_xmdl.xmdlseq
            
            LET g_xmdm_d[l_ac].xmdm001 = g_xmdl.xmdl008   #料件編號
            LET g_xmdm_d[l_ac].xmdm002 = g_xmdl.xmdl009   #產品特徵
            LET g_xmdm_d[l_ac].xmdm003 = g_xmdl.xmdl011   #作業編號
            LET g_xmdm_d[l_ac].xmdm004 = g_xmdl.xmdl012   #製程序

            LET g_xmdm_d[l_ac].xmdm005 = g_xmdl014        #庫位
            CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            
            LET g_xmdm_d[l_ac].xmdm006 = g_xmdl015        #儲位
            CALL s_desc_get_locator_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            
            LET g_xmdm_d[l_ac].xmdm007 = g_xmdl016        #批號
            LET g_xmdm_d[l_ac].xmdm033 = g_xmdl052        #庫存管理特徵

            LET g_xmdm_d[l_ac].xmdm008 = g_xmdl.xmdl017   #單位
            LET g_xmdm_d[l_ac].xmdm010 = g_xmdl.xmdl019   #參考單位

            #成本庫否
            CALL s_axmt540_inag012_chk(g_xmdksite,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,
                                       g_xmdm_d[l_ac].xmdm033,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,
                                       g_xmdm_d[l_ac].xmdm008)
                 RETURNING g_xmdm_d[l_ac].cost

            CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].xmdm008_desc
            CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm010) RETURNING g_xmdm_d[l_ac].xmdm010_desc
                        
            SELECT MAX(xmdmseq1)+1 INTO g_xmdm_d[l_ac].xmdmseq1
              FROM axmp540_03_temp
             WHERE xmdment = g_enterprise
               AND xmdmdocno = g_xmdl.xmdldocno
               AND xmdmseq = g_xmdl.xmdlseq

            IF cl_null(g_xmdm_d[l_ac].xmdmseq1) THEN
               LET g_xmdm_d[l_ac].xmdmseq1 = 1
            END IF

            LET g_xmdm_d_t.* = g_xmdm_d[l_ac].*
            LET g_xmdm_d_o.* = g_xmdm_d[l_ac].*
            CALL cl_show_fld_cont()
            
            CALL axmp540_03_set_entry()
            CALL axmp540_03_set_no_entry(p_control)            
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '9001'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = FALSE
               CANCEL INSERT
            END IF  

            #庫儲批補空格及資料重複輸入檢查
            IF NOT axmp540_03_repeat_chk() THEN
               LET INT_FLAG = FALSE
               CANCEL INSERT
            END IF

            #批號檢查
            IF NOT axmp540_03_xmdm007_chk(p_control) THEN               
               LET INT_FLAG = FALSE
               CANCEL INSERT
            END IF

            INSERT INTO axmp540_03_temp(cost,
                                        xmdment,xmdmsite,linkno,xmdmseq,xmdmseq1,
                                        xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                        xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                        xmdm011,xmdm031,xmdm032,xmdm033)
                 VALUES (g_xmdm_d[l_ac].cost,
                         g_enterprise,g_xmdksite,g_xmdm_d[l_ac].linkno,g_xmdm_d[l_ac].xmdmseq,g_xmdm_d[l_ac].xmdmseq1,
                         g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm003,g_xmdm_d[l_ac].xmdm004,g_xmdm_d[l_ac].xmdm005,
                         g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm009,g_xmdm_d[l_ac].xmdm010,
                         g_xmdm_d[l_ac].xmdm011,g_xmdm_d[l_ac].xmdm031,g_xmdm_d[l_ac].xmdm032,g_xmdm_d[l_ac].xmdm033)
                 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INSERT:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CANCEL INSERT
            ELSE
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                     
            IF NOT cl_null(g_xmdm_d[l_ac].linkno) AND
               NOT cl_null(g_xmdm_d[l_ac].xmdmseq) AND
               NOT cl_null(g_xmdm_d[l_ac].xmdmseq1) THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               
               DELETE FROM axmp540_03_temp
               WHERE xmdment = g_enterprise
                 AND xmdmdocno = g_xmdm_d_t.linkno
                 AND xmdmseq = g_xmdm_d_t.xmdmseq
                 AND xmdmseq1 = g_xmdm_d_t.xmdmseq1

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "DELETE:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b - 1
               END IF
            END IF
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xmdm_d[l_ac].* = g_xmdm_d_t.*
               EXIT DIALOG
            END IF

            #庫儲批補空格及資料重複輸入檢查
            IF NOT axmp540_03_repeat_chk() THEN
               NEXT FIELD xmdm009
            END IF

            #批號檢查
            IF NOT axmp540_03_xmdm007_chk(p_control) THEN               
               NEXT FIELD xmdm007
            END IF

            UPDATE axmp540_03_temp SET cost = g_xmdm_d[l_ac].cost,
                                       xmdm001 = g_xmdm_d[l_ac].xmdm001,
                                       xmdm002 = g_xmdm_d[l_ac].xmdm002,
                                       xmdm003 = g_xmdm_d[l_ac].xmdm003,
                                       xmdm004 = g_xmdm_d[l_ac].xmdm004,
                                       xmdm005 = g_xmdm_d[l_ac].xmdm005,
                                       xmdm006 = g_xmdm_d[l_ac].xmdm006,
                                       xmdm007 = g_xmdm_d[l_ac].xmdm007,
                                       xmdm008 = g_xmdm_d[l_ac].xmdm008,
                                       xmdm009 = g_xmdm_d[l_ac].xmdm009,
                                       xmdm010 = g_xmdm_d[l_ac].xmdm010,
                                       xmdm011 = g_xmdm_d[l_ac].xmdm011,
                                       xmdm031 = g_xmdm_d[l_ac].xmdm031,
                                       xmdm032 = g_xmdm_d[l_ac].xmdm032,
                                       xmdm033 = g_xmdm_d[l_ac].xmdm033
             WHERE linkno = g_xmdm_d_t.linkno
               AND xmdmseq = g_xmdm_d_t.xmdmseq
               AND xmdmseq1 = g_xmdm_d_t.xmdmseq1
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPDATE:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xmdm_d[l_ac].* = g_xmdm_d_t.*
            END IF

         AFTER ROW
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD linkno
            #add-point:BEFORE FIELD linkno name="input.b.page1.linkno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD linkno
            
            #add-point:AFTER FIELD linkno name="input.a.page1.linkno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE linkno
            #add-point:ON CHANGE linkno name="input.g.page1.linkno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdmseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdmseq
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdmseq name="input.a.page1.xmdmseq"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmseq
            #add-point:BEFORE FIELD xmdmseq name="input.b.page1.xmdmseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdmseq
            #add-point:ON CHANGE xmdmseq name="input.g.page1.xmdmseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmseq1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdmseq1,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdmseq1
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdmseq1 name="input.a.page1.xmdmseq1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmseq1
            #add-point:BEFORE FIELD xmdmseq1 name="input.b.page1.xmdmseq1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdmseq1
            #add-point:ON CHANGE xmdmseq1 name="input.g.page1.xmdmseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm001
            #add-point:BEFORE FIELD xmdm001 name="input.b.page1.xmdm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm001
            
            #add-point:AFTER FIELD xmdm001 name="input.a.page1.xmdm001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm001
            #add-point:ON CHANGE xmdm001 name="input.g.page1.xmdm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm002
            #add-point:BEFORE FIELD xmdm002 name="input.b.page1.xmdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm002
            
            #add-point:AFTER FIELD xmdm002 name="input.a.page1.xmdm002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm002
            #add-point:ON CHANGE xmdm002 name="input.g.page1.xmdm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm003
            #add-point:BEFORE FIELD xmdm003 name="input.b.page1.xmdm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm003
            
            #add-point:AFTER FIELD xmdm003 name="input.a.page1.xmdm003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm003
            #add-point:ON CHANGE xmdm003 name="input.g.page1.xmdm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm004
            #add-point:BEFORE FIELD xmdm004 name="input.b.page1.xmdm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm004
            
            #add-point:AFTER FIELD xmdm004 name="input.a.page1.xmdm004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm004
            #add-point:ON CHANGE xmdm004 name="input.g.page1.xmdm004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cost
            #add-point:BEFORE FIELD cost name="input.b.page1.cost"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cost
            
            #add-point:AFTER FIELD cost name="input.a.page1.cost"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cost
            #add-point:ON CHANGE cost name="input.g.page1.cost"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm005
            
            #add-point:AFTER FIELD xmdm005 name="input.a.page1.xmdm005"
            
            CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm005) THEN
               IF g_xmdm_d[l_ac].xmdm005 <> g_xmdm_d_o.xmdm005 OR cl_null(g_xmdm_d_o.xmdm005) THEN 
               
                  IF NOT axmp540_03_xmdm005_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm005 = g_xmdm_d_o.xmdm005
                     CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
                     
                     NEXT FIELD CURRENT
                  END IF

                  #檢查儲位
                  IF NOT axmp540_03_xmdm006_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm005 = g_xmdm_d_o.xmdm005
                     CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
                     
                     NEXT FIELD CURRENT
                  END IF

                  #成本庫否
                  CALL s_axmt540_inag012_chk(g_xmdksite,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm033,g_xmdm_d[l_ac].xmdm005,
                                             g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].cost

                  #儲位控管若為5.不使用儲位控管  
                  IF NOT s_axmt540_inaa007_chk(g_xmdm_d[l_ac].xmdm005) THEN
                     LET g_xmdm_d[l_ac].xmdm006 = ' '
                     LET g_xmdm_d_o.xmdm006 = g_xmdm_d[l_ac].xmdm006      
                  END IF

               END IF
            END IF
            
            LET g_xmdm_d_o.xmdm005 = g_xmdm_d[l_ac].xmdm005

            CALL axmp540_03_set_entry()
            CALL axmp540_03_set_no_entry(p_control)

            IF p_control MATCHES '[12]' THEN  #出貨單、出通單            
               CALL axmp540_03_inan010_display()
               CALL axmp540_03_inag_display()
               CALL axmp540_03_ready_display()               
            END IF           
            
            IF NOT axmp540_03_num_chk(p_control) THEN
               LET g_xmdm_d_o.xmdm009 = ''
               NEXT FIELD xmdm009
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm005
            #add-point:BEFORE FIELD xmdm005 name="input.b.page1.xmdm005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm005
            #add-point:ON CHANGE xmdm005 name="input.g.page1.xmdm005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm006
            
            #add-point:AFTER FIELD xmdm006 name="input.a.page1.xmdm006"
            
            CALL s_desc_get_locator_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc

            IF NOT cl_null(g_xmdm_d[l_ac].xmdm006) THEN
               IF g_xmdm_d[l_ac].xmdm006 <> g_xmdm_d_o.xmdm006 OR cl_null(g_xmdm_d_o.xmdm006) THEN 

                  IF NOT axmp540_03_xmdm006_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm006 = g_xmdm_d_o.xmdm006
                     CALL s_desc_get_locator_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc

                     NEXT FIELD CURRENT

                  END IF

                  #成本庫否
                  CALL s_axmt540_inag012_chk(g_xmdksite,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm033,g_xmdm_d[l_ac].xmdm005,
                                             g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].cost 

               END IF
            END IF
            
            LET g_xmdm_d_o.xmdm006 = g_xmdm_d[l_ac].xmdm006

            IF p_control MATCHES '[12]' THEN  #出貨單、出通單

               CALL axmp540_03_inan010_display()
               CALL axmp540_03_inag_display()
               CALL axmp540_03_ready_display()
            END IF

            IF NOT axmp540_03_num_chk(p_control) THEN
               LET g_xmdm_d_o.xmdm009 = ''            
               NEXT FIELD xmdm009
            END IF                  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm006
            #add-point:BEFORE FIELD xmdm006 name="input.b.page1.xmdm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm006
            #add-point:ON CHANGE xmdm006 name="input.g.page1.xmdm006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm007
            
            #add-point:AFTER FIELD xmdm007 name="input.a.page1.xmdm007"
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm007) THEN  
               IF g_xmdm_d[l_ac].xmdm007 <> g_xmdm_d_o.xmdm007 OR cl_null(g_xmdm_d_o.xmdm007) THEN 
               
                  IF NOT axmp540_03_xmdm007_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm007 = g_xmdm_d_o.xmdm007
                     NEXT FIELD CURRENT
                  END IF

                  #成本庫否
                  CALL s_axmt540_inag012_chk(g_xmdksite,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm033,g_xmdm_d[l_ac].xmdm005,
                                             g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].cost
                  
               END IF
            END IF
            
            LET g_xmdm_d_o.xmdm007 = g_xmdm_d[l_ac].xmdm007

            IF p_control MATCHES '[12]' THEN  #出貨單、出通單
               CALL axmp540_03_inan010_display()
               CALL axmp540_03_inag_display()
               CALL axmp540_03_ready_display()
            END IF            
                        
            IF NOT axmp540_03_num_chk(p_control) THEN
               LET g_xmdm_d_o.xmdm009 = ''
               NEXT FIELD xmdm009
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm007
            #add-point:BEFORE FIELD xmdm007 name="input.b.page1.xmdm007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm007
            #add-point:ON CHANGE xmdm007 name="input.g.page1.xmdm007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm033
            #add-point:BEFORE FIELD xmdm033 name="input.b.page1.xmdm033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm033
            
            #add-point:AFTER FIELD xmdm033 name="input.a.page1.xmdm033"
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm033) THEN  
               IF g_xmdm_d[l_ac].xmdm033 <> g_xmdm_d_o.xmdm033 OR cl_null(g_xmdm_d_o.xmdm033) THEN 
               
                  #成本庫否
                  CALL s_axmt540_inag012_chk(g_xmdksite,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm033,g_xmdm_d[l_ac].xmdm005,
                                             g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].cost
                  
               END IF
            END IF
            
            LET g_xmdm_d_o.xmdm033 = g_xmdm_d[l_ac].xmdm033

            IF p_control MATCHES '[12]' THEN  #出貨單、出通單
               CALL axmp540_03_inan010_display()
               CALL axmp540_03_inag_display()
               CALL axmp540_03_ready_display()
            END IF            
                        
            IF NOT axmp540_03_num_chk(p_control) THEN
               LET g_xmdm_d_o.xmdm009 = ''
               NEXT FIELD xmdm009
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm033
            #add-point:ON CHANGE xmdm033 name="input.g.page1.xmdm033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm008
            
            #add-point:AFTER FIELD xmdm008 name="input.a.page1.xmdm008"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm008
            #add-point:BEFORE FIELD xmdm008 name="input.b.page1.xmdm008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm008
            #add-point:ON CHANGE xmdm008 name="input.g.page1.xmdm008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inag008
            #add-point:BEFORE FIELD inag008 name="input.b.page1.inag008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inag008
            
            #add-point:AFTER FIELD inag008 name="input.a.page1.inag008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inag008
            #add-point:ON CHANGE inag008 name="input.g.page1.inag008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inan010
            #add-point:BEFORE FIELD inan010 name="input.b.page1.inan010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inan010
            
            #add-point:AFTER FIELD inan010 name="input.a.page1.inan010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inan010
            #add-point:ON CHANGE inan010 name="input.g.page1.inan010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ready
            #add-point:BEFORE FIELD ready name="input.b.page1.ready"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ready
            
            #add-point:AFTER FIELD ready name="input.a.page1.ready"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ready
            #add-point:ON CHANGE ready name="input.g.page1.ready"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm009
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm009 name="input.a.page1.xmdm009"
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm009) THEN  

               IF NOT axmp540_03_num_chk(p_control) THEN
                 #LET g_xmdm_d[l_ac].xmdm009 = g_xmdm_d_o.xmdm009  #170209-00026#1 mark
                 #NEXT FIELD CURRENT                               #170209-00026# mark 
               END IF

               #取位
               CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm009) RETURNING l_success,g_xmdm_d[l_ac].xmdm009
               
               #推算參考數量
               IF NOT cl_null(g_xmdm_d[l_ac].xmdm010) AND g_hidden_ref = 'Y' THEN
                  CALL s_aooi250_convert_qty(g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm009)
                  RETURNING l_success,g_xmdm_d[l_ac].xmdm011
               END IF
                  
            END IF

            LET g_xmdm_d_o.xmdm009 = g_xmdm_d[l_ac].xmdm009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm009
            #add-point:BEFORE FIELD xmdm009 name="input.b.page1.xmdm009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm009
            #add-point:ON CHANGE xmdm009 name="input.g.page1.xmdm009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm031,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm031
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm031 name="input.a.page1.xmdm031"
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm031) THEN  
            
               IF NOT axmp540_03_num_chk(p_control) THEN
                  LET g_xmdm_d[l_ac].xmdm031 = g_xmdm_d_o.xmdm031
                  NEXT FIELD CURRENT
               END IF
                                 
               #取位
               CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm031) RETURNING l_success,g_xmdm_d[l_ac].xmdm031
               
               #推算參考數量
               IF NOT cl_null(g_xmdm_d[l_ac].xmdm010) THEN
                  CALL s_aooi250_convert_qty(g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm031)
                  RETURNING l_success,g_xmdm_d[l_ac].xmdm032
               END IF            
            END IF               

            LET g_xmdm_d_o.xmdm031 = g_xmdm_d[l_ac].xmdm031
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm031
            #add-point:BEFORE FIELD xmdm031 name="input.b.page1.xmdm031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm031
            #add-point:ON CHANGE xmdm031 name="input.g.page1.xmdm031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm010
            
            #add-point:AFTER FIELD xmdm010 name="input.a.page1.xmdm010"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm010
            #add-point:BEFORE FIELD xmdm010 name="input.b.page1.xmdm010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm010
            #add-point:ON CHANGE xmdm010 name="input.g.page1.xmdm010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm011
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm011 name="input.a.page1.xmdm011"

            IF NOT cl_null(g_xmdm_d[l_ac].xmdm011) THEN
               IF NOT axmp540_03_sum_chk(p_control,'1') THEN
                  LET g_xmdm_d[l_ac].xmdm011 = g_xmdm_d_o.xmdm011
                  NEXT FIELD xmdm011
               END IF
               
               #參考數量取位
               CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm011) RETURNING l_success,g_xmdm_d[l_ac].xmdm011
            END IF 

            LET g_xmdm_d_o.xmdm011 = g_xmdm_d[l_ac].xmdm011
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm011
            #add-point:BEFORE FIELD xmdm011 name="input.b.page1.xmdm011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm011
            #add-point:ON CHANGE xmdm011 name="input.g.page1.xmdm011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm032
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm032,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm032
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm032 name="input.a.page1.xmdm032"
            
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm032) THEN                
               IF NOT axmp540_03_sum_chk(p_control,'1') THEN
                  LET g_xmdm_d[l_ac].xmdm032 = g_xmdm_d_o.xmdm032
                  NEXT FIELD xmdm032
               END IF            
            
               #參考數量取位
               CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm032) RETURNING l_success,g_xmdm_d[l_ac].xmdm032
            END IF
            
            LET g_xmdm_d_o.xmdm032 = g_xmdm_d[l_ac].xmdm032
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm032
            #add-point:BEFORE FIELD xmdm032 name="input.b.page1.xmdm032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm032
            #add-point:ON CHANGE xmdm032 name="input.g.page1.xmdm032"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.linkno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD linkno
            #add-point:ON ACTION controlp INFIELD linkno name="input.c.page1.linkno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmseq
            #add-point:ON ACTION controlp INFIELD xmdmseq name="input.c.page1.xmdmseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdmseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmseq1
            #add-point:ON ACTION controlp INFIELD xmdmseq1 name="input.c.page1.xmdmseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm001
            #add-point:ON ACTION controlp INFIELD xmdm001 name="input.c.page1.xmdm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm002
            #add-point:ON ACTION controlp INFIELD xmdm002 name="input.c.page1.xmdm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm003
            #add-point:ON ACTION controlp INFIELD xmdm003 name="input.c.page1.xmdm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm004
            #add-point:ON ACTION controlp INFIELD xmdm004 name="input.c.page1.xmdm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.cost
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cost
            #add-point:ON ACTION controlp INFIELD cost name="input.c.page1.cost"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm005
            #add-point:ON ACTION controlp INFIELD xmdm005 name="input.c.page1.xmdm005"

            #開窗i段
            CALL axmp540_03_xmdm005_xmdm006_xmdm007_xmdm033_qry('1')
            NEXT FIELD xmdm005                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm006
            #add-point:ON ACTION controlp INFIELD xmdm006 name="input.c.page1.xmdm006"
            
            #開窗i段
            CALL axmp540_03_xmdm005_xmdm006_xmdm007_xmdm033_qry('2')
            NEXT FIELD xmdm006                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm007
            #add-point:ON ACTION controlp INFIELD xmdm007 name="input.c.page1.xmdm007"
            
            #開窗i段
            CALL axmp540_03_xmdm005_xmdm006_xmdm007_xmdm033_qry('3')
            NEXT FIELD xmdm007                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm033
            #add-point:ON ACTION controlp INFIELD xmdm033 name="input.c.page1.xmdm033"
            
            #開窗i段
            CALL axmp540_03_xmdm005_xmdm006_xmdm007_xmdm033_qry('4')
            NEXT FIELD xmdm007                          #返回原欄位
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm008
            #add-point:ON ACTION controlp INFIELD xmdm008 name="input.c.page1.xmdm008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inag008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inag008
            #add-point:ON ACTION controlp INFIELD inag008 name="input.c.page1.inag008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inan010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inan010
            #add-point:ON ACTION controlp INFIELD inan010 name="input.c.page1.inan010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ready
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ready
            #add-point:ON ACTION controlp INFIELD ready name="input.c.page1.ready"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm009
            #add-point:ON ACTION controlp INFIELD xmdm009 name="input.c.page1.xmdm009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm031
            #add-point:ON ACTION controlp INFIELD xmdm031 name="input.c.page1.xmdm031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm010
            #add-point:ON ACTION controlp INFIELD xmdm010 name="input.c.page1.xmdm010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm011
            #add-point:ON ACTION controlp INFIELD xmdm011 name="input.c.page1.xmdm011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm032
            #add-point:ON ACTION controlp INFIELD xmdm032 name="input.c.page1.xmdm032"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            IF NOT axmp540_03_sum_chk(p_control,'2') THEN
               NEXT FIELD xmdm009
            END IF
                        
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
   CLOSE WINDOW w_axmp540_03 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL axmp540_03_xmdm_t_insert(p_control) RETURNING r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
      IF NOT r_success THEN
         LET r_rollback = TRUE  #多庫儲批資料出現錯誤必須rollback
      END IF
   ELSE
      LET INT_FLAG = FALSE
      LET r_success = FALSE
   END IF    
   
   RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmp540_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmp540_03.other_function" readonly="Y" >}
#檢查是否已有多庫儲批資料
PRIVATE FUNCTION axmp540_03_xmdm_count(p_control)
   DEFINE p_control    LIKE type_t.chr5   
   DEFINE l_n          LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE   
   LET l_n = 0
   
   CASE p_control
      WHEN '5'   #簽退單
         RETURN r_success     #直接列出簽退單資料
            
      WHEN '6'   #銷退單
         SELECT COUNT(xmdmseq1) INTO l_n
           FROM p540_tmp04            #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
          WHERE linkno = g_xmdl.linkno
            AND xmdmseq = g_xmdl.xmdlseq
            
      OTHERWISE  #出通單、出貨單、簽收單
         LET r_success = FALSE  #一律列出所有庫存或來源
         RETURN r_success
         
   END CASE

   IF cl_null(l_n) OR l_n < 2 THEN   #一筆也視作無多庫儲批
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#僅列出已輸入的資料
PRIVATE FUNCTION axmp540_03_insert_temp_table()
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
            
   LET l_sql = "SELECT xmdmseq1,",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm031,xmdm032,xmdm033",
               "  FROM p540_tmp04",          #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
               " ORDER BY xmdmseq1"
   
   PREPARE axmp540_03_temp_pre FROM l_sql
   DECLARE axmp540_03_temp_cs CURSOR FOR axmp540_03_temp_pre
   
   INITIALIZE l_xmdm.* TO NULL

   FOREACH axmp540_03_temp_cs INTO l_xmdm.xmdmseq1,
                                   l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                                   l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                                   l_xmdm.xmdm011,l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #成本庫否
      CALL s_axmt540_inag012_chk(g_xmdksite,l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm033,l_xmdm.xmdm005,l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008)
      RETURNING l_xmdm.cost

      INSERT INTO axmp540_03_temp(cost,
                                  xmdment,xmdmsite,linkno,xmdmseq,xmdmseq1,
                                  xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                  xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                  xmdm011,
                                  xmdm031,xmdm032,xmdm033)
           VALUES(l_xmdm.cost,
                  g_enterprise,g_xmdksite,g_xmdl.linkno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                  l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                  l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                  l_xmdm.xmdm011,
                  l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   CLOSE axmp540_03_temp_cs
   FREE axmp540_03_temp_pre
      
   RETURN r_success
END FUNCTION
#單頭display
PRIVATE FUNCTION axmp540_03_display_xmdl()
   DEFINE l_imaal003   LIKE imaal_t.imaal003
   DEFINE l_imaal004   LIKE imaal_t.imaal004
   DEFINE l_oocal003   LIKE oocal_t.oocal003
   
   DISPLAY BY NAME g_xmdl.xmdlseq
   DISPLAY BY NAME g_xmdl.xmdl008
   DISPLAY BY NAME g_xmdl.xmdl009
   DISPLAY BY NAME g_xmdl.xmdl011
   DISPLAY BY NAME g_xmdl.xmdl012
   DISPLAY BY NAME g_xmdl.xmdl017
   DISPLAY BY NAME g_xmdl.xmdl018
   DISPLAY BY NAME g_xmdl.xmdl019
   DISPLAY BY NAME g_xmdl.xmdl020  
   
   DISPLAY BY NAME g_xmdl.xmdl081
   DISPLAY BY NAME g_xmdl.xmdl082
   
   #品名、規格desc
   LET l_imaal003 = ''
   LET l_imaal004 = ''
   CALL s_desc_get_item_desc(g_xmdl.xmdl008) RETURNING l_imaal003,l_imaal004
   DISPLAY l_imaal003 TO FORMONLY.xmdl008_desc
   DISPLAY l_imaal004 TO FORMONLY.xmdl008_desc1
   
   #單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl017) RETURNING l_oocal003
   DISPLAY l_oocal003 TO FORMONLY.xmdl017_display
   
   #參考單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl019) RETURNING l_oocal003
   DISPLAY l_oocal003 TO FORMONLY.xmdl019_display
   
END FUNCTION

#建立axmp540_03要用到的Temp_table
PUBLIC FUNCTION axmp540_03_create_temp_table()
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   CALL axmp540_03_drop_temp_table() RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF

   CREATE TEMP TABLE axmp540_03_temp
          (cost         VARCHAR(1),           #成本庫否
           linkno        SMALLINT,
           xmdmseq      INTEGER,
           xmdmseq1     INTEGER,
           xmdm001      VARCHAR(40),
           xmdm002      VARCHAR(256),
           xmdm003      VARCHAR(10),
           xmdm004      VARCHAR(10),
           xmdm005      VARCHAR(10),
           xmdm006      VARCHAR(10),
           xmdm007      VARCHAR(30),
           xmdm008      VARCHAR(10),
           xmdm009      DECIMAL(20,6),
           xmdm010      VARCHAR(10),
           xmdm011      DECIMAL(20,6),
           xmdm031      DECIMAL(20,6),
           xmdm032      DECIMAL(20,6),
           xmdm033      VARCHAR(30));
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmp540_03_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
#將來源、庫存資料列出
PRIVATE FUNCTION axmp540_03_insert_temp_table1(p_control)
   DEFINE p_control    LIKE type_t.chr5  
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_xmdm009    LIKE xmdm_t.xmdm009
   DEFINE l_xmdm011    LIKE xmdm_t.xmdm011
   DEFINE l_xmdm031    LIKE xmdm_t.xmdm031
   DEFINE l_xmdm032    LIKE xmdm_t.xmdm032
   DEFINE l_seq        LIKE type_t.num5
   DEFINE l_num        LIKE type_t.num5
   DEFINE l_xmdk039    LIKE xmdk_t.xmdk039
   DEFINE l_xmdk040    LIKE xmdk_t.xmdk040

   LET r_success = TRUE

   IF p_control = '6' THEN   #銷退單不自動帶出資料
      RETURN r_success
   END IF

   CASE p_control
      WHEN '1'  #出貨單
         IF g_xmdl013 = 'Y' THEN #出通單已做多庫儲批
            #先列出出通單庫儲批，之後再替換上已輸入的資料
            LET l_sql = "SELECT DISTINCT '','',",
                        "                xmdi005,xmdi006,xmdi007,xmdi013",
                        "  FROM xmdi_t",
                        " WHERE xmdient = '",g_enterprise,"'",
                        "   AND xmdidocno = '",g_xmdl.xmdl001,"'",
                        "   AND xmdiseq = '",g_xmdl.xmdl002,"'",
                        " ORDER BY xmdi005,xmdi006,xmdi007,xmdi013"

         ELSE
            #先列出所有庫存庫儲批，之後再替換上已輸入的資料
            LET l_sql = "SELECT DISTINCT '','',",
                        "                inag004,inag005,inag006,inag003",
                        "  FROM inag_t",
                        " WHERE inagent = '",g_enterprise,"'",
                        "   AND inagsite = '",g_xmdksite,"'",
                        "   AND inag001 = '",g_xmdl.xmdl008,"'",
                        "   AND inag002 = '",g_xmdl.xmdl009,"'",
                        "   AND inag007 = '",g_xmdl.xmdl017,"'"

            #有限定庫位
            IF NOT cl_null(g_xmdl014) THEN
               LET l_sql = l_sql," AND inag004 = '",g_xmdl014,"'"
            END IF
            
            #有限定儲位
            IF NOT cl_null(g_xmdl015) THEN
               LET l_sql = l_sql," AND inag005 = '",g_xmdl015,"'"
            END IF
            
            #有限定批號
            IF NOT cl_null(g_xmdl016) THEN
               LET l_sql = l_sql," AND inag006 = '",g_xmdl016,"'"
            END IF
            
            #有限定庫存管理特徵
            IF NOT cl_null(g_xmdl052) THEN   
               LET l_sql = l_sql," AND inag003 = '",g_xmdl052,"'"
            END IF 
                          
            LET l_sql = l_sql," ORDER BY inag004,inag005,inag006,inag003"
         END IF
         
      WHEN '2'  #出通單
         #先列出所有庫存庫儲批，之後再替換上已輸入的資料
         LET l_sql = "SELECT DISTINCT '','',",
                     "                inag004,inag005,inag006,inag003", 
                     "  FROM inag_t",
                     " WHERE inagent = '",g_enterprise,"'",
                     "   AND inagsite = '",g_xmdksite,"'",
                     "   AND inag001 = '",g_xmdl.xmdl008,"'",
                     "   AND inag002 = '",g_xmdl.xmdl009,"'",
                     "   AND inag007 = '",g_xmdl.xmdl017,"'"

         #有限定庫位
         IF NOT cl_null(g_xmdl014) THEN
            LET l_sql = l_sql," AND inag004 = '",g_xmdl014,"'"
         END IF
         
         #有限定儲位
         IF NOT cl_null(g_xmdl015) THEN
            LET l_sql = l_sql," AND inag005 = '",g_xmdl015,"'"
         END IF
         
         #有限定批號
         IF NOT cl_null(g_xmdl016) THEN
            LET l_sql = l_sql," AND inag006 = '",g_xmdl016,"'"
         END IF
         
         #有限定庫存管理特徵
         IF NOT cl_null(g_xmdl052) THEN   
            LET l_sql = l_sql," AND inag003 = '",g_xmdl052,"'"
         END IF 
                       
         LET l_sql = l_sql," ORDER BY inag004,inag005,inag006,inag003"

      WHEN '4'  #簽收單
         #列出來源單據批號
         LET l_sql = "SELECT DISTINCT xmdk039,xmdk040,",
                     "                xmdm005,xmdm006,xmdm007,xmdm033",   #簽收用"批號"來呈現來源資料
                     "  FROM xmdk_t,xmdm_t",
                     " WHERE xmdkent = xmdment AND xmdment = '",g_enterprise,"'",
                     "   AND xmdkdocno = xmdmdocno AND xmdmdocno = '",g_xmdl.xmdl001,"'",
                     "   AND xmdmseq = '",g_xmdl.xmdl002,"'",
                     " ORDER BY xmdm007"

#      WHEN '6'  #銷退單
#         #列出來源單據批號
#         LET l_sql = "SELECT DISTINCT ' ',' ',xmdm007,' '",   #銷退用"批號"來呈現來源資料
#                     "  FROM xmdm_t",
#                     " WHERE xmdment = '",g_enterprise,"'",
#                     "   AND xmdmdocno = '",g_xmdl.xmdl001,"'",
#                     "   AND xmdmseq = '",g_xmdl.xmdl002,"'",
#                     " ORDER BY xmdm007"
   END CASE

   PREPARE axmp540_03_temp_pre1 FROM l_sql
   DECLARE axmp540_03_temp_cs1 CURSOR FOR axmp540_03_temp_pre1

   CASE p_control
      WHEN '2'  #出通單
#         LET l_sql = "SELECT xmdi009,xmdi011,'',''",
#                     "  FROM xmdi_t",
#                     " WHERE xmdient = '",g_enterprise,"'",
#                     "   AND xmdidocno = '",g_xmdl.xmdldocno,"'",
#                     "   AND xmdiseq = '",g_xmdl.xmdlseq,"'",
#                     "   AND COALESCE(xmdi005,' ') = COALESCE(?,' ')",
#                     "   AND COALESCE(xmdi006,' ') = COALESCE(?,' ')",
#                     "   AND COALESCE(xmdi007,' ') = COALESCE(?,' ')",
#                     "   AND COALESCE(xmdi013,' ') = COALESCE(?,' ')"
                     
      WHEN '4'   #簽收單
         LET l_sql = "SELECT xmdm009,xmdm011,xmdm031,xmdm032",
                     "  FROM axmp580_tmp03",             #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                     " WHERE keyno = '",g_xmdl.linkno,"'",
                     "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
                     "   AND COALESCE(xmdm005,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm006,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm007,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm033,' ') = COALESCE(?,' ')"
                     

      OTHERWISE  #出貨單
         LET l_sql = "SELECT xmdm009,xmdm011,'',''",
                     "  FROM p540_tmp04",        #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                     " WHERE linkno = '",g_xmdl.linkno,"'",
                     "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
                     "   AND COALESCE(xmdm005,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm006,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm007,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm033,' ') = COALESCE(?,' ')"
                     
   END CASE
   
   PREPARE axmp540_03_temp_pre2 FROM l_sql

   LET l_sql = "SELECT COUNT(xmdmseq1)",
               "  FROM axmp540_03_temp",
               " WHERE COALESCE(xmdm007,' ') = COALESCE(?,' ')"
   PREPARE axmp540_03_temp_pre4 FROM l_sql

   LET l_seq = 0
   INITIALIZE l_xmdm.* TO NULL
   
   FOREACH axmp540_03_temp_cs1 INTO l_xmdk039,l_xmdk040,
                                    l_xmdm.xmdm005,l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm033  #來源庫儲批 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
     #170209-00026#1-s-mark      
     #IF p_control = '4' THEN #簽收單用"批號"來呈現來源資料
     #   EXECUTE axmp540_03_temp_pre4 USING l_xmdm.xmdm007 INTO l_num
     #   
     #   IF l_num > 0 THEN
     #      CONTINUE FOREACH
     #   END IF
     #END IF
     #170209-00026#1-e-mark 
      LET l_seq = l_seq + 1
      
      LET l_xmdm.xmdmseq1 = l_seq #項序
      LET l_xmdm.xmdm001 = g_xmdl.xmdl008  #料件編號
      LET l_xmdm.xmdm002 = g_xmdl.xmdl009  #產品特徵
      LET l_xmdm.xmdm003 = g_xmdl.xmdl011  #作業編號
      LET l_xmdm.xmdm004 = g_xmdl.xmdl012  #製程序
      
      LET l_xmdm.xmdm008 = g_xmdl.xmdl017  #單位
      LET l_xmdm.xmdm010 = g_xmdl.xmdl019  #參考單位
      
      LET l_xmdm.xmdm031 = ''  #簽退數量
      LET l_xmdm.xmdm032 = ''  #簽退參考數量

      #成本庫否
      CALL s_axmt540_inag012_chk(g_xmdksite,l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm033,l_xmdm.xmdm005,l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008)
      RETURNING l_xmdm.cost

      IF p_control = '4' THEN #簽收替換在途成本庫、非成本庫
         IF l_xmdm.cost = 'Y' THEN
            LET l_xmdm.xmdm005 = l_xmdk039
           #LET l_xmdm.xmdm006 = ' '  #170209-00026#1 mark
           #LET l_xmdm.xmdm033 = ' '  #170209-00026#1 mark
         ELSE
            LET l_xmdm.xmdm005 = l_xmdk040
           #LET l_xmdm.xmdm006 = ' '  #170209-00026#1 mark
           #LET l_xmdm.xmdm033 = ' '  #170209-00026#1 mark           
         END IF

      END IF

      #替代上已輸入的值
      LET l_xmdm009 = ''
      LET l_xmdm011 = ''
      LET l_xmdm031 = ''
      LET l_xmdm032 = ''
      EXECUTE axmp540_03_temp_pre2 USING l_xmdm.xmdm005,l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm033      
      INTO l_xmdm009,l_xmdm011,l_xmdm031,l_xmdm032

      LET l_xmdm.xmdm009 = l_xmdm009  #數量
      LET l_xmdm.xmdm011 = l_xmdm011  #參考數量
      LET l_xmdm.xmdm031 = l_xmdm031  #簽退數量
      LET l_xmdm.xmdm032 = l_xmdm032  #簽退參考數量
  
      INSERT INTO axmp540_03_temp(cost,
                                  linkno,xmdmseq,xmdmseq1,
                                  xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                  xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                  xmdm011,xmdm031,xmdm032,xmdm033)
           VALUES(l_xmdm.cost,
                  g_xmdl.linkno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                  l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                  l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                  l_xmdm.xmdm011,l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   CLOSE axmp540_03_temp_cs1
   FREE axmp540_03_temp_pre1 
   FREE axmp540_03_temp_pre2
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp540_03_b_fill(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE l_sql        STRING
   
   LET l_sql = "SELECT cost,",
               "       linkno,xmdmseq,xmdmseq1,",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm031,xmdm032,xmdm033",
               "  FROM axmp540_03_temp",
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
               " ORDER BY xmdm009,xmdm011,xmdm031,xmdm032"

   PREPARE axmp540_03_b_pre FROM l_sql
   DECLARE axmp540_03_b_cs CURSOR FOR axmp540_03_b_pre

   CALL g_xmdm_d.clear()
   LET l_ac = 1
   FOREACH axmp540_03_b_cs INTO g_xmdm_d[l_ac].cost,
                                g_xmdm_d[l_ac].linkno,g_xmdm_d[l_ac].xmdmseq,g_xmdm_d[l_ac].xmdmseq1,
                                g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm003,g_xmdm_d[l_ac].xmdm004,g_xmdm_d[l_ac].xmdm005,
                                g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm009,g_xmdm_d[l_ac].xmdm010,
                                g_xmdm_d[l_ac].xmdm011,g_xmdm_d[l_ac].xmdm031,g_xmdm_d[l_ac].xmdm032,g_xmdm_d[l_ac].xmdm033
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
      CALL s_desc_get_locator_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
      CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].xmdm008_desc
      CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm010) RETURNING g_xmdm_d[l_ac].xmdm010_desc

      IF p_control MATCHES '[12]' THEN  #出貨單、出通單
         CALL axmp540_03_inan010_display()
         CALL axmp540_03_inag_display()
         CALL axmp540_03_ready_display()
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET l_ac = l_ac - 1
   CALL g_xmdm_d.deleteElement(g_xmdm_d.getLength())
   LET g_rec_b = l_ac
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE axmp540_03_b_cs
   FREE axmp540_03_b_pre
END FUNCTION

PUBLIC FUNCTION axmp540_03_drop_temp_table()
DEFINE r_success        LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   DROP TABLE axmp540_03_temp
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmp540_03_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp540_03_xmdm005_chk(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_success    LIKE type_t.num5   
   DEFINE l_type       LIKE type_t.chr1

   LET r_success = TRUE

   IF NOT cl_null(g_xmdm_d[l_ac].xmdm005) THEN
      CASE p_control
         WHEN '5'  #簽退單
            #得出來源成本庫否
            CALL s_axmt600_warehouse_cost(g_xmdl.xmdl001,g_xmdl.xmdl002)
            RETURNING l_type

            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL

            #替換錯誤訊息
            LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_xmdksite
            LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005    #庫位
            LET g_chkparam.arg3 = l_type
            
            #呼叫檢查存在並帶值的library
            IF NOT cl_chk_exist("v_inaa001_6") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
      
         WHEN '6'  #銷退單
            #得出來源成本庫否
            CALL s_axmt600_warehouse_cost(g_xmdl.xmdl001,g_xmdl.xmdl002)
            RETURNING l_type

            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL

            #替換錯誤訊息
            LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_xmdksite
            LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005    #庫位
            LET g_chkparam.arg3 = l_type
            
            #呼叫檢查存在並帶值的library
            IF NOT cl_chk_exist("v_inaa001_6") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF

         OTHERWISE  #出貨單、出通單
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
                     
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_xmdksite
            LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
            #160318-00025#22  by 07900 --add-str
            LET g_errshow = TRUE #是否開窗                   
            LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
            #160318-00025#22  by 07900 --add-end 
            #呼叫檢查存在並帶值的library
            IF NOT cl_chk_exist("v_inaa001") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF

      END CASE
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp540_03_xmdm006_chk(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_success    LIKE type_t.num5 

   LET r_success = TRUE

   IF NOT cl_null(g_xmdm_d[l_ac].xmdm006) THEN
   
      IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00126'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF   
   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xmdksite
      LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
      LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm006
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inab002_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
            
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp540_03_xmdm007_chk(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_success    LIKE type_t.num5 
   DEFINE l_n          LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(g_xmdm_d[l_ac].xmdm007) THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xmdksite
      LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm001
      LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm002
      LET g_chkparam.arg4 = g_xmdm_d[l_ac].xmdm007

      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inad001_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   IF p_control = '6' THEN  #銷退單
      IF NOT cl_null(g_xmdl.xmdl001) AND NOT cl_null(g_xmdl.xmdl002) THEN
         LET l_n = 0
         SELECT COUNT(xmdmseq1) INTO l_n
           FROM xmdm_t
          WHERE xmdment = g_enterprise
            AND xmdmdocno = g_xmdl.xmdl001
            AND xmdmseq = g_xmdl.xmdl002
            AND COALESCE(xmdm007,' ') = COALESCE(g_xmdm_d[l_ac].xmdm007,' ')
            
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00388'    #該批號不存在來源單據！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
           
            LET r_success = FALSE
            RETURN r_success
      
         END IF

      END IF
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmp540_03_set_entry()
   CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm007,xmdm033",TRUE)
   CALL cl_set_comp_entry("xmdm009,xmdm031,xmdm011,xmdm032",TRUE)
END FUNCTION

PRIVATE FUNCTION axmp540_03_set_no_entry(p_control)
   DEFINE p_control    LIKE type_t.chr5
   #161006-00018#20-S
   DEFINE l_flag       LIKE type_t.num5
   DEFINE l_ooac002    LIKE ooac_t.ooac002
   DEFINE l_ooac004    LIKE ooac_t.ooac004
   #161006-00018#20-E
   
   #來源已做多庫儲批
   IF g_xmdl013 = 'Y' THEN
      CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm007,xmdm033",FALSE)
   END IF
   #161006-00018#25-S
   CALL s_aooi200_get_slip(g_xmdl.xmdldocno) RETURNING l_flag,l_ooac002
   CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
   #161006-00018#25-E
   #來源有限制庫位
   IF NOT cl_null(g_xmdl014) THEN
      IF l_ooac004 = 'N' THEN   #161006-00018#25
         CALL cl_set_comp_entry("xmdm005",FALSE)
      END IF                    #161006-00018#25
   END IF
   
   #來源有限制儲位
   IF NOT cl_null(g_xmdl015) THEN
      IF l_ooac004 = 'N' THEN   #161006-00018#25
         CALL cl_set_comp_entry("xmdm006",FALSE)
      END IF                    #161006-00018#25
   END IF
   
   #來源有限制批號
   IF NOT cl_null(g_xmdl016) THEN
      IF l_ooac004 = 'N' THEN   #161006-00018#25
         CALL cl_set_comp_entry("xmdm007",FALSE)
      END IF                    #161006-00018#25
   END IF
   
   #來源有限制庫存管理特徵
   IF NOT cl_null(g_xmdl052) THEN
      CALL cl_set_comp_entry("xmdm033",FALSE)
   END IF

   #檢查料件是否使用批號
   IF NOT s_axmt540_imaf061_chk(g_xmdm_d[l_ac].xmdm001) THEN
      CALL cl_set_comp_entry("xmdm007",FALSE)
   END IF
   
   #參考數量
   IF cl_null(g_xmdl.xmdl020) THEN
      CALL cl_set_comp_entry("xmdm011,xmdm032",FALSE)
      LET g_xmdm_d[l_ac].xmdm011 = ''
      LET g_xmdm_d[l_ac].xmdm032 = ''
   END IF

   #儲位控管若為5.不使用儲位控管
   IF NOT s_axmt540_inaa007_chk(g_xmdm_d[l_ac].xmdm005) THEN
      CALL cl_set_comp_entry("xmdm006",FALSE)
   END IF

   CASE p_control         
      WHEN '4'  #簽收單
         CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm007,xmdm033",FALSE)
      
      WHEN '5'  #簽退單
         CALL cl_set_comp_entry("xmdm007",FALSE)
         CALL cl_set_comp_entry("xmdm009,xmdm031,xmdm011,xmdm032",FALSE)
      
      WHEN '6'  #銷退單
         IF g_xmdk082 = '4' THEN  #銷貨折讓
            CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm033",FALSE)
         END IF
         
   END CASE

END FUNCTION
#顯示在揀量
PRIVATE FUNCTION axmp540_03_inan010_display()
   DEFINE l_inan010     LIKE inan_t.inan010
      
   LET l_inan010 = 0
       
   SELECT SUM(inan010) INTO l_inan010
     FROM inan_t
    WHERE inanent = g_enterprise
      AND inansite = g_xmdksite
      AND inan001 = g_xmdm_d[l_ac].xmdm001
      AND inan002 = g_xmdm_d[l_ac].xmdm002
      AND COALESCE(inan003,' ') = COALESCE(g_xmdm_d[l_ac].xmdm033,' ')
      AND inan004 = g_xmdm_d[l_ac].xmdm005
      AND COALESCE(inan005,' ') = COALESCE(g_xmdm_d[l_ac].xmdm006,' ')
      AND COALESCE(inan006,' ') = COALESCE(g_xmdm_d[l_ac].xmdm007,' ')
      AND COALESCE(inan007,' ') = COALESCE(g_xmdm_d[l_ac].xmdm008,' ')
   
   IF cl_null(l_inan010) THEN
      LET l_inan010 = 0
   END IF
   
   LET g_xmdm_d[l_ac].inan010 = l_inan010
END FUNCTION

################################################################################
# Descriptions...: 找單身項序最大值+1
# Memo...........:
# Usage..........: CALL axmp540_03_seq1_max(p_linkno,p_xmdlseq,p_control)
#                  RETURNING r_xmdmseq1
# Input parameter: p_linkno       暫存檔之key
#                : p_xmdlseq      單身項次
#                : p_control      1為axmt540，2為axmt520
# Return code....: r_xmdmseq1     項序最大值+1
#                :
# Date & Author..: 140327 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_03_seq1_max(p_linkno,p_xmdlseq,p_control)
   DEFINE p_linkno        LIKE type_t.num5
   DEFINE p_xmdlseq       LIKE xmdl_t.xmdlseq
   DEFINE p_control       LIKE type_t.chr5
   DEFINE r_xmdmseq1      LIKE xmdm_t.xmdmseq1

   LET r_xmdmseq1 = ''

   CASE p_control         
      WHEN '2'   #出通單
#         SELECT MAX(xmdiseq1) + 1 INTO r_xmdmseq1
#           FROM xmdi_t
#          WHERE xmdient = g_enterprise
#            AND xmdidocno = p_xmdldocno
#            AND xmdiseq = p_xmdlseq
      
      WHEN '4'   #簽收單
         SELECT MAX(xmdmseq1) + 1 INTO r_xmdmseq1
           FROM axmp580_tmp03            #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
          WHERE keyno = p_linkno
            AND xmdmseq = p_xmdlseq

      OTHERWISE  #出貨單、銷退單
         SELECT MAX(xmdmseq1) + 1 INTO r_xmdmseq1
           FROM p540_tmp04          #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
          WHERE linkno = p_linkno
            AND xmdmseq = p_xmdlseq       
         
   END CASE
   
   IF cl_null(r_xmdmseq1) THEN
      LET r_xmdmseq1 = 1
   END IF
   
   RETURN r_xmdmseq1
         
END FUNCTION

#將資料寫入另一暫存table
PRIVATE FUNCTION axmp540_03_xmdm_t_insert(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_xmdl014    LIKE xmdl_t.xmdl014
   DEFINE r_xmdl015    LIKE xmdl_t.xmdl015
   DEFINE r_xmdl016    LIKE xmdl_t.xmdl016
   DEFINE r_xmdl052    LIKE xmdl_t.xmdl052  
   
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data
   DEFINE r_success    LIKE type_t.num5
  #DEFINE l_num        LIKE type_t.num5   #170209-00026#1
   DEFINE l_num        LIKE xmdm_t.xmdm009   #170209-00026#1

   LET r_success = TRUE

   LET r_xmdl014 = ''
   LET r_xmdl015 = ''
   LET r_xmdl016 = ''
   LET r_xmdl052 = ''

   #先將原有資料清除
   CASE p_control
      WHEN '2'   #出通單

      WHEN '4'   #簽收單
         DELETE FROM axmp580_tmp03            #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
          WHERE keyno = g_xmdl.linkno
            AND xmdmseq = g_xmdl.xmdlseq
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'DELETE axmp580_tmp03:'         #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
         END IF

      OTHERWISE  #出貨單、銷退單、簽退單
         DELETE FROM p540_tmp04          #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
          WHERE linkno = g_xmdl.linkno
            AND xmdmseq = g_xmdl.xmdlseq
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'DELETE p540_tmp04:'   #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
         END IF

   END CASE
           
   LET l_sql = "SELECT xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm031,xmdm032,xmdm033",
               "  FROM axmp540_03_temp",
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'"
   PREPARE axmp540_03_pre1 FROM l_sql
   DECLARE axmp540_03_cs1 CURSOR FOR axmp540_03_pre1   
   
   INITIALIZE l_xmdm.* TO NULL
   
   FOREACH axmp540_03_cs1 INTO l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                               l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                               l_xmdm.xmdm011,l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #要被回寫的欄位預設為0
      LET l_xmdm.xmdm012 = 0  #已簽收數量
      LET l_xmdm.xmdm013 = 0  #已簽退數量
      LET l_xmdm.xmdm014 = 0  #已銷退數量

      IF cl_null(l_xmdm.xmdm009) THEN LET l_xmdm.xmdm009 = 0 END IF  #數量
      IF cl_null(l_xmdm.xmdm011) THEN LET l_xmdm.xmdm011 = 0 END IF  #參考數量
         
      LET l_num = l_xmdm.xmdm009 + l_xmdm.xmdm011
      
      #判斷據點參數若使用參考單位時，則參考數量預帶(據點參數:S-BAS-0028)
      IF g_hidden_ref <> 'N' THEN
         IF cl_null(l_xmdm.xmdm031) THEN LET l_xmdm.xmdm031 = 0 END IF  #簽退數量
         IF cl_null(l_xmdm.xmdm032) THEN LET l_xmdm.xmdm032 = 0 END IF  #簽退參考數量
         
         LET l_num = l_num + l_xmdm.xmdm031 + l_xmdm.xmdm032
      END IF
      
      #無輸入任何資料不儲存
      IF l_num = 0 THEN
         CONTINUE FOREACH
      END IF

      CALL axmp540_03_seq1_max(g_xmdl.linkno,g_xmdl.xmdlseq,p_control) RETURNING l_xmdm.xmdmseq1
      
      CASE p_control                         
         WHEN '2'  #出通單

         WHEN '4'   #簽收單               
            INSERT INTO axmp580_tmp03(keyno,xmdmseq,xmdmseq1,              #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                                          xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                          xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                          xmdm011,xmdm012,xmdm013,xmdm014,
                                          xmdm031,xmdm032,xmdm033)
               VALUES(g_xmdl.linkno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                      l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                      l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                      l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,
                      l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033)

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INSERT axmp580_tmp03:"             #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
               LET g_errparam.popup = TRUE
               CALL cl_err()
           
               LET r_success = FALSE
               EXIT FOREACH
            END IF                      

         OTHERWISE #出貨單、銷退單、簽退單
            INSERT INTO p540_tmp04(linkno,xmdmseq,xmdmseq1,           #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                                          xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                          xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                          xmdm011,xmdm012,xmdm013,xmdm014,
                                          xmdm031,xmdm032,xmdm033)
               VALUES(g_xmdl.linkno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                      l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                      l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                      l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,
                      l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033)
                      
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INSERT p540_tmp04:"            #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
               LET g_errparam.popup = TRUE
               CALL cl_err()
           
               LET r_success = FALSE
               EXIT FOREACH
            END IF                      
      END CASE
      
   END FOREACH

   CLOSE axmp540_03_cs1
   FREE axmp540_03_pre1

   IF l_xmdm.xmdmseq1 = 1 THEN  #只有一筆
      LET r_xmdl014 = l_xmdm.xmdm005
      LET r_xmdl015 = l_xmdm.xmdm006
      LET r_xmdl016 = l_xmdm.xmdm007
      LET r_xmdl052 = l_xmdm.xmdm033
   END IF

   RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   
END FUNCTION
#可出貨量顯示
PRIVATE FUNCTION axmp540_03_ready_display()
   DEFINE l_ready    LIKE type_t.num5
   
   LET l_ready = 0
   
   IF NOT cl_null(g_xmdm_d[l_ac].inag008) THEN
      LET l_ready = l_ready + g_xmdm_d[l_ac].inag008
   END IF
   
   IF NOT cl_null(g_xmdm_d[l_ac].inan010) THEN
      LET l_ready = l_ready - g_xmdm_d[l_ac].inan010
   END IF
   
   LET g_xmdm_d[l_ac].ready = l_ready
END FUNCTION
#庫存量顯示
PRIVATE FUNCTION axmp540_03_inag_display()
   DEFINE l_inag008    LIKE inag_t.inag008
      
   LET l_inag008 = 0
         
   SELECT inag008
     INTO l_inag008
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inagsite = g_xmdksite
      AND inag001 = g_xmdm_d[l_ac].xmdm001
      AND inag002 = g_xmdm_d[l_ac].xmdm002
      AND COALESCE(inag003,' ') = COALESCE(g_xmdm_d[l_ac].xmdm033,' ')
      AND inag004 = g_xmdm_d[l_ac].xmdm005
      AND COALESCE(inag005,' ') = COALESCE(g_xmdm_d[l_ac].xmdm006,' ')
      AND COALESCE(inag006,' ') = COALESCE(g_xmdm_d[l_ac].xmdm007,' ')
      AND COALESCE(inag007,' ') = COALESCE(g_xmdm_d[l_ac].xmdm008,' ')
   
   IF cl_null(l_inag008) THEN
      LET l_inag008 = 0
   END IF

   LET g_xmdm_d[l_ac].inag008 = l_inag008
END FUNCTION

#數量檢查
PRIVATE FUNCTION axmp540_03_num_chk(p_control)
   DEFINE p_control  LIKE type_t.chr5 
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_num      LIKE xmdl_t.xmdl018
   DEFINE l_enter    LIKE type_t.num5    #輸入的數量
   DEFINE l_total    LIKE type_t.num5    #輸入該庫儲批總數量
   DEFINE l_xmdm009  LIKE xmdm_t.xmdm009 #數量
   DEFINE l_xmdm031  LIKE xmdm_t.xmdm031 #簽退數量
   DEFINE l_xmdm011  LIKE xmdm_t.xmdm011 #參考數量
   DEFINE l_xmdm032  LIKE xmdm_t.xmdm032 #簽退參考數量
   
   LET r_success = TRUE
   
   IF (NOT cl_null(g_xmdm_d[l_ac].xmdm009) AND g_xmdm_d[l_ac].xmdm009 <> 0) OR
      (NOT cl_null(g_xmdm_d[l_ac].xmdm031) AND g_xmdm_d[l_ac].xmdm031 <> 0) OR
      (NOT cl_null(g_xmdm_d[l_ac].xmdm011) AND g_xmdm_d[l_ac].xmdm011 <> 0) OR
      (NOT cl_null(g_xmdm_d[l_ac].xmdm032) AND g_xmdm_d[l_ac].xmdm032 <> 0) THEN

      LET l_enter = 0
      IF NOT cl_null(g_xmdm_d[l_ac].xmdm009) THEN LET l_enter = l_enter + g_xmdm_d[l_ac].xmdm009 END IF
      IF NOT cl_null(g_xmdm_d[l_ac].xmdm031) THEN LET l_enter = l_enter + g_xmdm_d[l_ac].xmdm031 END IF

#141002暫時拿掉控卡
#      IF p_control MATCHES '[12]' THEN  #出貨單、出通單
#         IF g_booking = 'Y' THEN         
#            IF l_enter > g_xmdm_d[l_ac].ready THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'axm-00172'         #出貨量不可大於庫存可出貨量！
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               LET r_success = FALSE
#               RETURN r_success
#            END IF
#         END IF      
#      END IF
      
      #檢查是否成本庫與非成本庫混和輸入
      LET l_num = 0
      LET l_xmdm009 = 0
      LET l_xmdm031 = 0
      LET l_xmdm011 = 0
      LET l_xmdm032 = 0
      SELECT SUM(xmdm009),SUM(xmdm031),SUM(xmdm011),SUM(xmdm032)
        INTO l_xmdm009,l_xmdm031,l_xmdm011,l_xmdm032
        FROM axmp540_03_temp
       WHERE linkno = g_xmdl.linkno
         AND xmdmseq = g_xmdl.xmdlseq
         AND cost <> g_xmdm_d[l_ac].cost
         AND xmdmseq1 <> g_xmdm_d_t.xmdmseq1

      IF NOT cl_null(l_xmdm009) THEN LET l_num = l_num + l_xmdm009 END IF
      IF NOT cl_null(l_xmdm031) THEN LET l_num = l_num + l_xmdm031 END IF
      IF NOT cl_null(l_xmdm011) THEN LET l_num = l_num + l_xmdm011 END IF
      IF NOT cl_null(l_xmdm032) THEN LET l_num = l_num + l_xmdm032 END IF

      IF NOT cl_null(l_num) AND l_num > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00375'   #成本庫與非成本庫不可混合輸入！
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #總數量與項次檢查
      IF NOT axmp540_03_sum_chk(p_control,'1') THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #檢查是否超過前張單據可輸入值
      IF NOT cl_null(g_xmdl.xmdl001) AND NOT cl_null(g_xmdl.xmdl002) THEN
         #計算庫儲批排除該項序總數
         LET l_total = 0
         LET l_num = 0
         LET l_xmdm009 = 0
         LET l_xmdm031 = 0      
         SELECT SUM(xmdm009),SUM(xmdm031) INTO l_xmdm009,l_xmdm031
           FROM axmp540_03_temp
          WHERE xmdment = g_enterprise
            AND xmdmdocno = g_xmdl.xmdldocno
            AND xmdmseq = g_xmdl.xmdlseq
            AND xmdmseq1 <> g_xmdm_d_t.xmdmseq1
       
         IF NOT cl_null(l_xmdm009) THEN LET l_num = l_num + l_xmdm009 END IF
         IF NOT cl_null(l_xmdm031) THEN LET l_num = l_num + l_xmdm031 END IF            
      
         #加上項序數量
         LET l_total = l_enter + l_num
     
         CASE p_control
            WHEN '1'  #出貨單            
               CALL s_axmt540_get_max_ship_qty1(g_xmdl.xmdldocno,g_xmdl.xmdlseq,
                                                g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm033,
                                                g_xmdl.xmdl001,g_xmdl.xmdl002) RETURNING l_num
               IF l_total > l_num THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00189'  #出貨量不可大於"申請出通數量" - "已轉出貨數量" - "已登打出貨單未確認的出貨量"！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success
               END IF

            WHEN '4'  #簽收單
               CALL s_axmt580_get_max_sign_qty1(g_xmdm_d[l_ac].xmdm007,g_xmdl.xmdl001,g_xmdl.xmdl002) RETURNING l_num

               IF l_total > l_num THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00225'    #簽收簽退量不可大於可轉簽收簽退量("出貨量" - "已簽收量" - "已簽退量")
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success
               END IF

            WHEN '6'  #銷退單
               CALL s_axmt600_return_max1(g_xmdl.xmdldocno,g_xmdl.xmdlseq,
                                          g_xmdm_d[l_ac].xmdm007,
                                          g_xmdl.xmdl001,g_xmdl.xmdl002) RETURNING l_num
               
               IF l_total > l_num THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00385'  #銷退數量不可大於"出貨數量" - "已銷退數量" - "已登打銷退單未過帳的銷退量"！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success
               END IF
               
         END CASE
      END IF
   END IF
  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 隱藏、替換畫面說明
# Memo...........:
# Usage..........: CALL axmp540_03_window_show(p_control)
#                  
# Input parameter: p_control   呼叫此子程式之程式
#                : 
# Return code....: 
#                : 
# Date & Author..: 140708 BY earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_03_window_show(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE l_gzze003    LIKE gzze_t.gzze003
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_xmdksite,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmdl009,xmdm002",FALSE)
   END IF

   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   CALL cl_get_para(g_enterprise,g_xmdksite,'S-BAS-0028') RETURNING g_hidden_ref
   IF g_hidden_ref = 'N' THEN
      CALL cl_set_comp_visible("xmdl019,xmdl019_display,xmdl020,xmdl082,
                                xmdm010,xmdm010_desc,xmdm011,xmdm032",FALSE)
   END IF

   CASE p_control
      WHEN '4'   #簽收單
         CALL cl_getmsg('axm-00474',g_dlang) RETURNING l_gzze003  #簽收資訊
         CALL cl_set_comp_att_text('group1',l_gzze003)
         
         CALL cl_getmsg('axm-00475',g_dlang) RETURNING l_gzze003  #簽收項次
         CALL cl_set_comp_att_text('xmdlseq',l_gzze003)         

         CALL cl_getmsg('axm-00476',g_dlang) RETURNING l_gzze003  #簽收數量
         CALL cl_set_comp_att_text('xmdl018',l_gzze003)
         CALL cl_set_comp_att_text('xmdm009',l_gzze003)

         CALL cl_getmsg('axm-00477',g_dlang) RETURNING l_gzze003  #簽收參考數量
         CALL cl_set_comp_att_text('xmdl020',l_gzze003)
         CALL cl_set_comp_att_text('xmdm011',l_gzze003)

         CALL cl_set_comp_visible("cost,inag008,inan010,ready",FALSE)
      
      WHEN '5'   #簽退單
         CALL cl_getmsg('axm-00480',g_dlang) RETURNING l_gzze003  #簽退資訊
         CALL cl_set_comp_att_text('group1',l_gzze003)

         CALL cl_getmsg('axm-00481',g_dlang) RETURNING l_gzze003  #簽退項次
         CALL cl_set_comp_att_text('xmdlseq',l_gzze003)

         CALL cl_getmsg('axm-00476',g_dlang) RETURNING l_gzze003  #簽收數量
         CALL cl_set_comp_att_text('xmdl018',l_gzze003)
         CALL cl_set_comp_att_text('xmdm009',l_gzze003)

         CALL cl_getmsg('axm-00477',g_dlang) RETURNING l_gzze003  #簽收參考數量
         CALL cl_set_comp_att_text('xmdl020',l_gzze003)
         CALL cl_set_comp_att_text('xmdm011',l_gzze003)

         CALL cl_set_comp_visible("cost,inag008,inan010,ready",FALSE)
      
      WHEN '6'   #銷退單      
         CALL cl_getmsg('axm-00378',g_dlang) RETURNING l_gzze003  #銷退資訊
         CALL cl_set_comp_att_text('group1',l_gzze003)
         
         CALL cl_getmsg('axm-00379',g_dlang) RETURNING l_gzze003  #銷退項次
         CALL cl_set_comp_att_text('xmdlseq',l_gzze003)
         
         CALL cl_getmsg('axm-00380',g_dlang) RETURNING l_gzze003  #銷退數量
         CALL cl_set_comp_att_text('xmdl018',l_gzze003)
         CALL cl_set_comp_att_text('xmdm009',l_gzze003)
   
         CALL cl_set_comp_visible("inag008,inan010,ready",FALSE)
         CALL cl_set_comp_visible("xmdl081,xmdl082,xmdm031,xmdm032",FALSE)
         
      OTHERWISE  #出貨單、出通單
         CALL cl_set_comp_visible("xmdl081,xmdl082,xmdm031,xmdm032",FALSE)
         
   END CASE

END FUNCTION
#庫儲批補空格及資料重複輸入檢查
PRIVATE FUNCTION axmp540_03_repeat_chk()
   DEFINE p_control  LIKE type_t.chr5
   DEFINE l_n        LIKE type_t.num5
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE

   #可能為Null的欄位
   CALL axmp540_03_null_defalt()

   #重複輸入檢查
   LET l_n = 0
   SELECT COUNT(xmdmseq1) INTO l_n
     FROM axmp540_03_temp
    WHERE xmdm005 = g_xmdm_d[l_ac].xmdm005
      AND xmdm006 = g_xmdm_d[l_ac].xmdm006
      AND xmdm007 = g_xmdm_d[l_ac].xmdm007
      AND xmdm033 = g_xmdm_d[l_ac].xmdm033
      AND xmdmseq1 <> g_xmdm_d_t.xmdmseq1   #排除當下這筆
   
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00095'  #庫儲批不可以重複輸入！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 輸入總數量與項次檢查
# Memo...........:
# Usage..........: CALL axmp540_03_sum_chk(p_control,p_type,p_xmdmseq1)
#                  RETURNING r_success
# Input parameter: p_control      呼叫子程式之程式
#                : p_type         1.AFTER FIELD 檢查  2.AFTER INPUT檢查
# Return code....: r_success      執行結果
#                : 
# Date & Author..: 140715 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_03_sum_chk(p_control,p_type)
   DEFINE p_control       LIKE type_t.chr5
   DEFINE p_type          LIKE type_t.chr1  #1.AFTER FIELD檢查  2.AFTER INPUT檢查
   DEFINE r_success       LIKE type_t.num5

   DEFINE l_xmdm009       LIKE xmdm_t.xmdm009
   DEFINE l_xmdm011       LIKE xmdm_t.xmdm011
   DEFINE l_xmdm031       LIKE xmdm_t.xmdm031
   DEFINE l_xmdm032       LIKE xmdm_t.xmdm032
   DEFINE l_xmdmseq1      LIKE xmdm_t.xmdmseq1
   DEFINE l_sql           STRING
   
   LET r_success = TRUE

   LET l_xmdm009 = ''
   LET l_xmdm011 = ''
   LET l_xmdm031 = ''
   LET l_xmdm032 = ''
   LET l_xmdmseq1 = ''
   
   LET l_sql = "SELECT SUM(COALESCE(xmdm009,0)),SUM(COALESCE(xmdm011,0)),SUM(COALESCE(xmdm031,0)),",
               "       SUM(COALESCE(xmdm032,0)),COUNT(xmdmseq1)",     
               "  FROM axmp540_03_temp",
               " WHERE linkno = '",g_xmdl.linkno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
               "   AND (xmdm009 > 0 OR xmdm011 > 0 OR xmdm031 > 0 OR xmdm032 > 0)"
               
   IF p_type = '1' THEN
      LET l_sql = l_sql," AND xmdmseq1 <> '",g_xmdm_d[l_ac].xmdmseq1,"'"
   END IF

   PREPARE axmp540_03_temp_pre3 FROM l_sql
   
   EXECUTE axmp540_03_temp_pre3 INTO l_xmdm009,l_xmdm011,l_xmdm031,l_xmdm032,l_xmdmseq1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'EXECUTE'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_xmdm009) THEN LET l_xmdm009 = 0 END IF
   IF cl_null(l_xmdm011) THEN LET l_xmdm011 = 0 END IF
   IF cl_null(l_xmdm031) THEN LET l_xmdm031 = 0 END IF
   IF cl_null(l_xmdm032) THEN LET l_xmdm032 = 0 END IF
   IF cl_null(l_xmdmseq1) THEN LET l_xmdmseq1 = 0 END IF

   CASE p_type
      WHEN '1'  #AFTER FIELD
         IF NOT cl_null(g_xmdm_d[l_ac].xmdm009) THEN LET l_xmdm009 = l_xmdm009 + g_xmdm_d[l_ac].xmdm009 END IF
         IF NOT cl_null(g_xmdm_d[l_ac].xmdm011) THEN LET l_xmdm011 = l_xmdm011 + g_xmdm_d[l_ac].xmdm011 END IF
         IF NOT cl_null(g_xmdm_d[l_ac].xmdm031) THEN LET l_xmdm031 = l_xmdm031 + g_xmdm_d[l_ac].xmdm031 END IF
         IF NOT cl_null(g_xmdm_d[l_ac].xmdm032) THEN LET l_xmdm032 = l_xmdm032 + g_xmdm_d[l_ac].xmdm032 END IF
            
         IF l_xmdm009 > g_xmdl.xmdl018 THEN
            INITIALIZE g_errparam TO NULL
            
            CASE p_control
               WHEN '6' #銷退單
                  LET g_errparam.code = 'axm-00392'   #多庫儲批總"銷退數量%1"不可大於項次%2"銷退數量%3"！
               OTHERWISE #出貨單、出通單
                  LET g_errparam.code = 'axm-00384'   #多庫儲批總"出貨數量%1"不可大於項次%2"出貨數量%3"！
            END CASE

            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm009
            LET g_errparam.replace[2] = g_xmdl.xmdlseq
            LET g_errparam.replace[3] = g_xmdl.xmdl018
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
               
         IF l_xmdm011 > g_xmdl.xmdl020 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00383'   #多庫儲批總"參考數量%1"不可大於項次%2"參考數量%3"！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm011 
            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
            LET g_errparam.replace[3] = g_xmdl.xmdl020
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

         IF l_xmdm031 > g_xmdl.xmdl081 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00390'   #多庫儲批總"簽退數量%1"不可大於項次%2"簽退數量%3"！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm031
            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
            LET g_errparam.replace[3] = g_xmdl.xmdl081
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

         IF l_xmdm032 > g_xmdl.xmdl082 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00391'   #多庫儲批總"簽退參考數量%1"不可大於項次%2"簽退參考數量%3"！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm032
            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
            LET g_errparam.replace[3] = g_xmdl.xmdl082
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

      WHEN '2'  #AFTER INPUT
         IF l_xmdm009 <> g_xmdl.xmdl018 THEN
            INITIALIZE g_errparam TO NULL
            CASE p_control
               WHEN '6' #銷退單
                  LET g_errparam.code = 'axm-00393'   #多庫儲批總"銷退數量%1"不可與項次%2"銷退數量%3"不相等！           
               OTHERWISE #出貨單、出通單
                  LET g_errparam.code = 'axm-00196'   #多庫儲批總"出貨數量%1"不可與項次%2"出貨數量%3"不相等！
            END CASE
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm009 
            LET g_errparam.replace[2] =  g_xmdl.xmdlseq 
            LET g_errparam.replace[3] =  g_xmdl.xmdl018
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
               
         IF l_xmdm011 <> g_xmdl.xmdl020 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00232'   #多庫儲批總"參考數量%1"不可與項次%2"參考數量%3"不相等！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm011 
            LET g_errparam.replace[2] =  g_xmdl.xmdlseq 
            LET g_errparam.replace[3] =  g_xmdl.xmdl020
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

         IF l_xmdm031 <> g_xmdl.xmdl081 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00243'   #多庫儲批總"簽退數量%1"不可與項次%2"簽退數量%3"不相等！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm031
            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
            LET g_errparam.replace[3] = g_xmdl.xmdl081
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

         IF l_xmdm032 <> g_xmdl.xmdl082 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00244'   #多庫儲批總"簽退參考數量%1"不可與項次%2"簽退參考數量%3"不相等！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_xmdm032
            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
            LET g_errparam.replace[3] = g_xmdl.xmdl082
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
         
   END CASE
        
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身可能為Null必須預設空格的欄位
# Memo...........:
# Usage..........: CALL axmp540_03_null_defalt()
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140715 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_03_null_defalt()
   #可能為Null的欄位
   
   #產品特徵
   IF cl_null(g_xmdm_d[l_ac].xmdm002) THEN LET g_xmdm_d[l_ac].xmdm002 = ' ' END IF   
   #庫位
   IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN LET g_xmdm_d[l_ac].xmdm005 = ' ' END IF   
   #儲位
   IF cl_null(g_xmdm_d[l_ac].xmdm006) THEN LET g_xmdm_d[l_ac].xmdm006 = ' ' END IF   
   #批號
   IF cl_null(g_xmdm_d[l_ac].xmdm007) THEN LET g_xmdm_d[l_ac].xmdm007 = ' ' END IF
   #庫存管理特徵
   IF cl_null(g_xmdm_d[l_ac].xmdm033) THEN LET g_xmdm_d[l_ac].xmdm033 = ' ' END IF
   
END FUNCTION
################################################################################
# Descriptions...: 多庫儲批資料修改及新增
# Memo...........:
# Usage..........: CALL axmp540_03_xmdm_modify(p_control,p_xmdmseq,p_xmdksite,p_linkno,p_xmdlseq,
#                                              p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,
#                                              p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl052,
#                                              p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
#                                              p_xmdl081,p_xmdl082)
#                  RETURNING r_success
# Input parameter: p_control       #呼叫此子程式之程式 1.axmt540或axmt541  出貨單
#                                                     2.axmt520          出通單
#                                                     4.axmt580          簽收單
#                                                     5.axmt590          簽退單
#                                                     6.axmt600          銷退單
#                : p_xmdmseq    #多庫儲批項次(建立多庫儲批時的項次)
#                : p_xmdksite   #營運據點
#                : p_linkno     #暫存檔之key
#                : p_xmdlseq    #項次
#                : p_xmdl008    #料件編號
#                : p_xmdl009    #產品特徵
#                : p_xmdl011    #作業編號
#                : p_xmdl012    #製程序
#                : p_xmdl014    #庫位
#                : p_xmdl015    #儲位
#                : p_xmdl016    #批號
#                : p_xmdl052    #庫存管理特徵
#                : p_xmdl017    #出貨單位
#                : p_xmdl018    #數量
#                : p_xmdl019    #參考單位
#                : p_xmdl020    #參考數量
#                : p_xmdl081    #簽退數量
#                : p_xmdl082    #簽退參考數量
# Return code....: r_success    #執行結果
#                : 
# Date & Author..: 141023 By stellar
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_03_xmdm_modify(p_control,p_xmdmseq,p_xmdksite,p_linkno,p_xmdlseq,p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl052,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,p_xmdl081,p_xmdl082)
   DEFINE p_control     LIKE type_t.chr5     
   DEFINE p_xmdmseq     LIKE xmdm_t.xmdmseq
   DEFINE p_xmdksite    LIKE xmdk_t.xmdksite
   DEFINE p_linkno       LIKE type_t.num5
   DEFINE p_xmdlseq     LIKE xmdl_t.xmdlseq      
   DEFINE p_xmdl008     LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009     LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011     LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012     LIKE xmdl_t.xmdl012
   
   DEFINE p_xmdl014     LIKE xmdl_t.xmdl014
   DEFINE p_xmdl015     LIKE xmdl_t.xmdl015
   DEFINE p_xmdl016     LIKE xmdl_t.xmdl016
   DEFINE p_xmdl052     LIKE xmdl_t.xmdl052
   
   DEFINE p_xmdl017     LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018     LIKE xmdl_t.xmdl018
   DEFINE p_xmdl019     LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020     LIKE xmdl_t.xmdl020 
   DEFINE p_xmdl081     LIKE xmdl_t.xmdl081
   DEFINE p_xmdl082     LIKE xmdl_t.xmdl082

   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(p_linkno) AND NOT cl_null(p_xmdmseq) THEN
      #檢查有無多庫儲批資料
      LET l_n = 0
      CASE p_control
         WHEN '2' #出通單     
         
         WHEN '4' #簽收單
            SELECT COUNT(xmdmseq1) INTO l_n
              FROM axmp580_tmp03            #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
             WHERE keyno = p_linkno
               AND xmdmseq = p_xmdmseq         
         
         OTHERWISE #出貨單、簽退單、銷退單
            SELECT COUNT(xmdmseq1) INTO l_n
              FROM p540_tmp04          #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
             WHERE linkno = p_linkno
               AND xmdmseq = p_xmdmseq
               
      END CASE
      
      CASE l_n
         WHEN 0   #無多庫儲批資料，新增一筆                                     
            CALL axmp540_03_xmdm_insert(p_control,p_xmdksite,p_linkno,p_xmdlseq,                                        
                                        p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,
                                        p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl052,
                                        p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
                                        p_xmdl081,p_xmdl082) RETURNING r_success
            IF NOT r_success THEN
               RETURN r_success
            END IF
                                    
         WHEN 1   #已有資料，但非多庫儲批出貨
            CASE p_control
               WHEN '2' #出通單

               WHEN '4' #簽收單
                  UPDATE axmp580_tmp03         #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                     SET xmdmseq = p_xmdlseq,  #項次
                         xmdm001 = p_xmdl008,  #料件編號
                         xmdm002 = p_xmdl009,  #產品特徵
                         xmdm003 = p_xmdl011,  #作業編號
                         xmdm004 = p_xmdl012,  #製程序                   
                         xmdm005 = p_xmdl014,  #庫位
                         xmdm006 = p_xmdl015,  #儲位
                         xmdm007 = p_xmdl016,  #批號
                         xmdm033 = p_xmdl052,  #庫存管理特徵
                         xmdm008 = p_xmdl017,  #單位
                         xmdm009 = p_xmdl018,  #出貨數量
                         xmdm010 = p_xmdl019,  #參考單位
                         xmdm011 = p_xmdl020,  #參考數量                   
                         xmdm031 = p_xmdl081,  #簽退數量
                         xmdm032 = p_xmdl082   #簽退參考數量
                   WHERE keyno = p_linkno
                     AND xmdmseq = p_xmdmseq
                 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "axmp580_tmp03"           #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF

               OTHERWISE #出貨單、簽退單、銷退單
                  UPDATE p540_tmp04            #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                     SET xmdmseq = p_xmdlseq,  #項次
                         xmdm001 = p_xmdl008,  #料件編號
                         xmdm002 = p_xmdl009,  #產品特徵
                         xmdm003 = p_xmdl011,  #作業編號
                         xmdm004 = p_xmdl012,  #製程序                   
                         xmdm005 = p_xmdl014,  #庫位
                         xmdm006 = p_xmdl015,  #儲位
                         xmdm007 = p_xmdl016,  #批號
                         xmdm033 = p_xmdl052,  #庫存管理特徵
                         xmdm008 = p_xmdl017,  #單位
                         xmdm009 = p_xmdl018,  #出貨數量
                         xmdm010 = p_xmdl019,  #參考單位
                         xmdm011 = p_xmdl020,  #參考數量                   
                         xmdm031 = p_xmdl081,  #簽退數量
                         xmdm032 = p_xmdl082   #簽退參考數量
                   WHERE linkno = p_linkno
                     AND xmdmseq = p_xmdmseq
                 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "p540_tmp04"         #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF
            END CASE

         OTHERWISE  #已有資料，且為多庫儲批出貨
            CASE p_control
               WHEN '2' #出通單
               
               WHEN '4' #簽收單                  
                  UPDATE axmp580_tmp03                         #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                     SET xmdmseq = p_xmdlseq,  #項次
                         xmdm003 = p_xmdl011,  #作業編號
                         xmdm004 = p_xmdl012   #製程序
                   WHERE keyno = p_linkno
                     AND xmdmseq = p_xmdmseq     
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "axmp580_tmp03"   #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
              
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF           
                  
               OTHERWISE #出貨單、簽退單、銷退單
                  UPDATE p540_tmp04                         #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                     SET xmdmseq = p_xmdlseq,  #項次
                         xmdm003 = p_xmdl011,  #作業編號
                         xmdm004 = p_xmdl012   #製程序
                   WHERE linkno = p_linkno
                     AND xmdmseq = p_xmdmseq     
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "p540_tmp04"   #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
              
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF           
                  
            END CASE      
      END CASE      
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 多庫儲批新增
# Memo...........:
# Usage..........: CALL axmp540_03_xmdm_insert(p_control,p_xmdksite,p_linkno,p_xmdlseq,
#                                              p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,
#                                              p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl052,
#                                              p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
#                                              p_xmdl081,p_xmdl082)
#                  RETURNING r_success
# Input parameter: p_control       #呼叫此子程式之程式 1.axmt540或axmt541  出貨單
#                                                     2.axmt520          出通單
#                                                     4.axmt580          簽收單
#                                                     5.axmt590          簽退單
#                                                     6.axmt600          銷退單 
#                : p_xmdksite   #營運據點
#                : p_linkno     #暫存檔之key
#                : p_xmdlseq    #項次
#                : p_xmdl008    #料件編號
#                : p_xmdl009    #產品特徵
#                : p_xmdl011    #作業編號
#                : p_xmdl012    #製程序
#                : p_xmdl014    #庫位
#                : p_xmdl015    #儲位
#                : p_xmdl016    #批號
#                : p_xmdl052    #庫存管理特徵
#                : p_xmdl017    #出貨單位
#                : p_xmdl018    #數量
#                : p_xmdl019    #參考單位
#                : p_xmdl020    #參考數量
#                : p_xmdl081    #簽退數量
#                : p_xmdl082    #簽退參考數量
# Return code....: r_success    #執行結果
#                : 
# Date & Author..: 141023 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_03_xmdm_insert(p_control,p_xmdksite,p_linkno,p_xmdlseq,p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl052,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,p_xmdl081,p_xmdl082)
   DEFINE p_control   LIKE type_t.chr5
   DEFINE p_xmdksite  LIKE xmdk_t.xmdksite
   DEFINE p_linkno     LIKE type_t.num5  
   DEFINE p_xmdlseq   LIKE xmdl_t.xmdlseq
   DEFINE p_xmdl008   LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009   LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011   LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012   LIKE xmdl_t.xmdl012
   DEFINE p_xmdl014   LIKE xmdl_t.xmdl014
   DEFINE p_xmdl015   LIKE xmdl_t.xmdl015
   DEFINE p_xmdl016   LIKE xmdl_t.xmdl016
   DEFINE p_xmdl052   LIKE xmdl_t.xmdl052
   DEFINE p_xmdl017   LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018   LIKE xmdl_t.xmdl018
   DEFINE p_xmdl019   LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020   LIKE xmdl_t.xmdl020   
   DEFINE p_xmdl081   LIKE xmdl_t.xmdl081
   DEFINE p_xmdl082   LIKE xmdl_t.xmdl082
   
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE

   CASE p_control
      WHEN '2'  #出通單

      WHEN '4'  #簽收單      
         INSERT INTO axmp580_tmp03(keyno,xmdmseq,xmdmseq1,          #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
                                       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                       xmdm011,xmdm012,xmdm013,xmdm014,
                                       xmdm031,xmdm032,xmdm033)
            VALUES(p_linkno,p_xmdlseq,1,
                   p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,
                   p_xmdl015,p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,
                   p_xmdl020,0,0,0,
                   p_xmdl081,p_xmdl082,p_xmdl052)       
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "axmp580_tmp03"                 #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            RETURN r_success            
         END IF                      
      
      OTHERWISE #出貨單、簽退單、銷退單
         INSERT INTO p540_tmp04(linkno,xmdmseq,xmdmseq1,        #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
                                       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                       xmdm011,xmdm012,xmdm013,xmdm014,
                                       xmdm031,xmdm032,xmdm033)
            VALUES(p_linkno,p_xmdlseq,1,
                   p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,
                   p_xmdl015,p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,
                   p_xmdl020,0,0,0,
                   p_xmdl081,p_xmdl082,p_xmdl052)       
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "p540_tmp04"                 #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            RETURN r_success            
         END IF                
         
   END CASE
                
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 刪除多庫儲批出貨資料
# Memo...........:
# Usage..........: CALL axmp540_03_xmdm_delete(p_control,p_linkno,p_xmdlseq,p_pop)
#                  RETURNING r_success
# Input parameter: p_control       #呼叫此子程式之程式 1.axmt540或axmt541  出貨單
#                                                     2.axmt520          出通單
#                                                     4.axmt580          簽收單
#                                                     5.axmt590          簽退單
#                                                     6.axmt600          銷退單 
#                : p_linkno    暫存檔之key
#                : p_xmdlseq   項次
#                : p_pop       是否彈出視窗詢問Y,N
# Return code....: r_success   執行狀態
#                : 
# Date & Author..: 141023 By stellar
# Modify.........:
################################################################################
PUBLIC FUNCTION axmp540_03_xmdm_delete(p_control,p_linkno,p_xmdlseq,p_pop)
   DEFINE p_control     LIKE type_t.chr5
   DEFINE p_linkno       LIKE type_t.num5
   DEFINE p_xmdlseq     LIKE xmdl_t.xmdlseq
   DEFINE p_pop         LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   
   LET r_success = TRUE

   IF NOT cl_null(p_xmdlseq) AND NOT cl_null(p_linkno) THEN
   
      #檢查有無多庫儲批資料
      LET l_n = 0      
      CASE p_control
         WHEN '2'  #出通單

         WHEN '4'  #簽收單
            SELECT COUNT(xmdmseq1) INTO l_n
              FROM axmp580_tmp03           #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
             WHERE keyno = p_linkno
               AND xmdmseq = p_xmdlseq         

         OTHERWISE #出貨單、簽退單、銷退單
            SELECT COUNT(xmdmseq1) INTO l_n
              FROM p540_tmp04      #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
             WHERE linkno = p_linkno
               AND xmdmseq = p_xmdlseq
               
      END CASE
   
      #詢問是否刪除多庫儲批
      IF p_pop = 'Y' AND l_n > 1 THEN
         IF NOT cl_ask_confirm('axm-00194') THEN   #是否取消多庫儲批出貨，且刪除對應的出通單多庫儲批出貨明細檔？
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      CASE p_control
         WHEN '2'  #出通單

         WHEN '4'  #簽收單
            DELETE FROM axmp580_tmp03           #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
             WHERE keyno = p_linkno
               AND xmdmseq = p_xmdlseq
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "axmp580_tmp03"            #160727-00019#24 Mod  axmp580_02_temp_d3--> axmp580_tmp03
               LET g_errparam.popup = TRUE
               CALL cl_err()
        
               LET r_success = FALSE
               RETURN r_success
            END IF

         OTHERWISE #出貨單、簽退單、銷退單
            DELETE FROM p540_tmp04                   #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
             WHERE linkno = p_linkno
               AND xmdmseq = p_xmdlseq
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "p540_tmp04"      #160727-00019#23 Mod   p540_02_xmdm_temp --> p540_tmp04
               LET g_errparam.popup = TRUE
               CALL cl_err()
        
               LET r_success = FALSE
               RETURN r_success
            END IF
            
      END CASE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 庫、儲、批、庫存管理特徵，輸入開窗
# Memo...........:
# Usage..........: CALL axmp540_03_xmdm005_xmdm006_xmdm007_xmdm033_qry(p_type)
#                  
# Input parameter: p_type 1.庫位2.儲位3.批號4.庫存管理特徵
#                : 
# Return code....: 
#                : 
# Date & Author..: 140915 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_03_xmdm005_xmdm006_xmdm007_xmdm033_qry(p_type)
   DEFINE p_type            LIKE type_t.chr1   
   DEFINE l_type            LIKE type_t.chr1

   #出通單若有做多庫儲批，輸入儲位必須存在
   IF g_xmdl013 = 'Y' THEN         
      #開窗i段
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
      LET g_qryparam.reqry = FALSE
    
      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值
      LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006
      LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007
      LET g_qryparam.default4 = g_xmdm_d[l_ac].xmdm033
        
      #給予arg
      LET g_qryparam.arg1 = g_xmdl.xmdl001
      LET g_qryparam.arg2 = g_xmdl.xmdl002
        
      CALL q_xmdi005()                                #呼叫開窗
    
      LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1              #將開窗取得的值回傳到變數
      LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2
      LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3
      LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return4
    
      DISPLAY g_xmdm_d[l_ac].xmdm005 TO xmdm005              #顯示到畫面上
      DISPLAY g_xmdm_d[l_ac].xmdm006 TO xmdm006
      DISPLAY g_xmdm_d[l_ac].xmdm007 TO xmdm007
      DISPLAY g_xmdm_d[l_ac].xmdm033 TO xmdm033

      CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
      CALL s_desc_get_locator_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
      
   ELSE
   
      #開窗i段
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
      LET g_qryparam.reqry = FALSE
      
      CASE p_type
         WHEN '1' #庫位
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值

            #得出來源成本庫否
            LET l_type = ''
            CALL s_axmt600_warehouse_cost(g_xmdl.xmdl001,g_xmdl.xmdl002)
            RETURNING l_type
            
            #串上成本庫否
            IF NOT cl_null(l_type) THEN
               LET g_qryparam.where = "inaa010 = '",l_type,"'"
            END IF

            CALL q_inaa001_2()
            
            LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdm_d[l_ac].xmdm005 TO xmdm005              #顯示到畫面上
            
            CALL s_desc_get_stock_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
         
         WHEN '2' #儲位
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm006             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_xmdm_d[l_ac].xmdm005
      
            CALL q_inab002_5()
            
            LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdm_d[l_ac].xmdm006 TO xmdm006
            
            CALL s_desc_get_locator_desc(g_xmdksite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            
         WHEN '3' #批號
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm007             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_xmdksite
            LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm001
            LET g_qryparam.arg3 = g_xmdm_d[l_ac].xmdm002
            
            CALL q_inad003()
      
            LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdm_d[l_ac].xmdm007 TO xmdm007            
         
         WHEN '4' #庫存管理特徵
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmdksite

            CALL q_xmdm033()
            LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdm_d[l_ac].xmdm033 TO xmdm033

      END CASE

   END IF
END FUNCTION

 
{</section>}
 
