#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt540_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-04-08 17:24:10), PR版次:0008(2016-08-31 17:33:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000249
#+ Filename...: adbt540_01
#+ Description: 分銷多庫儲批出貨
#+ Creator....: 04226(2014-05-19 09:33:39)
#+ Modifier...: 06815 -SD/PR- 02749
 
{</section>}
 
{<section id="adbt540_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#18   2016/04/13 BY 07900   校验代码重复错误讯息的修改
#160720-00002#1    2016/07/25 by 06814   錯誤訊息更改使用,建議執行作業,需改為流通使用(axm-00189->adb-00442)
#160826-00007#1    2016/08/31 by lori    有代送商時,庫位需檢查是否符合adbi202設定
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
       xmdmdocno LIKE xmdm_t.xmdmdocno, 
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
          xmdlsite  LIKE xmdl_t.xmdlsite,    #發貨組織
          xmdldocno LIKE xmdl_t.xmdldocno,   #單據編號
          xmdlseq   LIKE xmdl_t.xmdlseq,     #項次
          xmdl008   LIKE xmdl_t.xmdl008,     #商品編號
          xmdl009   LIKE xmdl_t.xmdl009,     #產品特徵
          xmdl011   LIKE xmdl_t.xmdl011,     #作業編號
          xmdl012   LIKE xmdl_t.xmdl012,     #製程序
          xmdl017   LIKE xmdl_t.xmdl017,     #出貨單位
          xmdl018   LIKE xmdl_t.xmdl018,     #數量
          xmdl001   LIKE xmdl_t.xmdl001,     #出通單號
          xmdl002   LIKE xmdl_t.xmdl002,     #出通項次
          xmdl019   LIKE xmdl_t.xmdl019,     #參考單位
          xmdl020   LIKE xmdl_t.xmdl020,     #參考數量
          xmdl081   LIKE xmdl_t.xmdl081,     #簽退數量
          xmdl082   LIKE xmdl_t.xmdl082,     #簽退參考數量
          xmdl204   LIKE xmdl_t.xmdl204,     #包裝單位
          xmdl205   LIKE xmdl_t.xmdl205,     #包裝數量
          xmdl206   LIKE xmdl_t.xmdl206,     #簽退包裝數量
          xmdl003   LIKE xmdl_t.xmdl003,     #訂單單號
          xmdl004   LIKE xmdl_t.xmdl004,     #訂單項次
          imaa104   LIKE imaa_t.imaa104,     #庫存單位
          xmdl0181  LIKE xmdl_t.xmdl018,     #庫存數量
          xmdl2061  LIKE xmdl_t.xmdl206,     #簽退庫存數量
          xmdl200   LIKE xmdl_t.xmdl200,     #銷售渠道
          xmdl222   LIKE xmdl_t.xmdl222,     #地區編號
          xmdl223   LIKE xmdl_t.xmdl223,     #縣市編號
          xmdl224   LIKE xmdl_t.xmdl224,     #省區編號
          xmdl225   LIKE xmdl_t.xmdl225,     #區域編號
          #lori522612  150225  add ----------------------(S)
          xmdl005   LIKE xmdl_t.xmdl005,     #訂單項序
          xmdl006   LIKE xmdl_t.xmdl006      #訂單分批序
          #lori522612  150225  add ----------------------(E)
                 END RECORD
DEFINE g_xmdk082         LIKE xmdk_t.xmdk082  #銷退方式
DEFINE g_booking         LIKE type_t.chr1     #是否使用在揀量
DEFINE g_win_curr ui.Window                   #現行畫面

DEFINE g_hidden_ref      LIKE type_t.chr1     #是否使用參考單位(Y/N)
DEFINE g_xmdl013         LIKE xmdl_t.xmdl013  #多庫儲批
DEFINE g_xmdl014         LIKE xmdl_t.xmdl014  #限制庫位
DEFINE g_xmdl015         LIKE xmdl_t.xmdl015  #限制儲位
DEFINE g_xmdl016         LIKE xmdl_t.xmdl016  #限制批號
DEFINE g_xmdl052         LIKE xmdl_t.xmdl052  #限制庫存管理特徵
DEFINE g_xmdk201         LIKE xmdk_t.xmdk201  #代送商   #160826-00007#1 160831 by lori add
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
#1.CALL adbt540_01_create_temp_table()
#2.CALL s_transaction_begin()
#3.CALL adbt540_01()
#4.CALL s_transaxtion_end('Y',0)
#5.CALL adbt540_01_drop_temp_table()

#傳入參數說明
#p_control       #呼叫此子程式之程式 1.adbt540或adbt541  出貨單
#                                   2.adbt520          出通單
#                                   4.adbt580          簽收單
#                                   5.adbt590          簽退單
#                                   6.adbt600          銷退單
#p_xmdlsite      #發貨組織
#p_xmdk082       #銷退方式(銷退單使用，其它傳Null)
#p_xmdkdocno     #單據單號
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
#p_xmdl001       #出通單號
#p_xmdl002       #出通項次
#p_xmdl003       #來源訂單
#p_xmdl004       #來源訂單項次
#p_xmdl005       #來源訂單項序      #150302-00004#11 150305 by lori522612 add
#p_xmdl006       #來源訂單分批序    #150302-00004#11 150305 by lori522612 add
#p_xmdl204       #包裝單位
#p_xmdl205       #包裝數量
#p_xmdl200       #銷售渠道
#p_xmdl222       #地區編號
#p_xmdl223       #縣市編號
#p_xmdl224       #省區編號
#p_xmdl225       #區域編號

#回傳變數說明
#r_success       #執行結果
#r_rollback      #若為TRUE則代表多庫儲批損毀失敗必須在主程式rollback並離開input(因與呼叫來源共用transaction)
#r_xmdl014       #庫位(只有一筆時回傳)
#r_xmdl015       #儲位(只有一筆時回傳)
#r_xmdl016       #批號(只有一筆時回傳)
#r_xmdl052       #庫存管理特徵(只有一筆時回傳)
#end add-point    
 
{</section>}
 
{<section id="adbt540_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION adbt540_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_control,
   p_xmdlsite,
   p_xmdk082,    
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
   p_xmdl004,
   p_xmdl005,    #150302-00004#11 150305 by lori522612 add
   p_xmdl006,    #150302-00004#11 150305 by lori522612 add
   p_xmdl204,
   p_xmdl205,
   p_xmdl200,
   p_xmdl222,
   p_xmdl223,
   p_xmdl224,
   p_xmdl225  
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
   DEFINE p_xmdlsite      LIKE xmdl_t.xmdlsite
   DEFINE p_xmdk082       LIKE xmdk_t.xmdk082        #銷退方式(銷退單用)     
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
   DEFINE p_xmdl005       LIKE xmdl_t.xmdl005   #來源訂單項序      #150302-00004#11 150305 by lori522612 add
   DEFINE p_xmdl006       LIKE xmdl_t.xmdl006   #來源訂單分批序    #150302-00004#11 150305 by lori522612 add
   DEFINE p_xmdl204       LIKE xmdl_t.xmdl204
   DEFINE p_xmdl205       LIKE xmdl_t.xmdl205
   DEFINE p_xmdl200       LIKE xmdl_t.xmdl200
   DEFINE p_xmdl222       LIKE xmdl_t.xmdl222
   DEFINE p_xmdl223       LIKE xmdl_t.xmdl223
   DEFINE p_xmdl224       LIKE xmdl_t.xmdl224
   DEFINE p_xmdl225       LIKE xmdl_t.xmdl225

   DEFINE r_success       LIKE type_t.num5
   DEFINE r_rollback      LIKE type_t.num5   
   DEFINE r_xmdl014       LIKE xmdl_t.xmdl014
   DEFINE r_xmdl015       LIKE xmdl_t.xmdl015
   DEFINE r_xmdl016       LIKE xmdl_t.xmdl016
   DEFINE r_xmdl052       LIKE xmdl_t.xmdl052   
   
   DEFINE l_forupd_sql    STRING
   DEFINE l_para_data     LIKE type_t.chr80          #接參數用
   DEFINE l_xmdm009       LIKE xmdm_t.xmdm009
   DEFINE l_xmdm011       LIKE xmdm_t.xmdm011
   DEFINE l_imaa104       LIKE imaa_t.imaa104
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_gzze003       LIKE gzze_t.gzze003
   DEFINE l_ship          LIKE ooba_t.ooba001
   DEFINE l_type          LIKE type_t.chr1
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_adbt540_01 WITH FORM cl_ap_formpath("adb","adbt540_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL adbt540_01_set_win_title(p_control)
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET r_rollback = FALSE
   LET r_xmdl014 = ''
   LET r_xmdl015 = ''
   LET r_xmdl016 = ''
   LET r_xmdl052 = ''
   
   #必須包在transaction裡面
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   END IF
   
   IF cl_null(p_xmdl081) THEN LET p_xmdl081 = 0 END IF  #簽退數量預設為0
   
   #取得庫存單位
   IF NOT cl_null(p_xmdl008) THEN
      LET l_imaa104 = ''
      SELECT imaa104
        INTO l_imaa104
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = p_xmdl008
   END IF
   
   LET g_errno = ''   
   CASE
      WHEN cl_null(p_control)
         LET g_errno = 'sub-00280'
      WHEN cl_null(p_xmdlsite)
         LET g_errno = 'adb-00093'
      WHEN cl_null(p_xmdmdocno)
         LET g_errno = 'adb-00015'
      WHEN cl_null(p_xmdmseq)
         LET g_errno = 'sub-00406'
      WHEN cl_null(p_xmdl008)
         LET g_errno = 'sub-00123'
      WHEN cl_null(p_xmdl017)
         LET g_errno = 'axm-00199'
      WHEN cl_null(p_xmdl018)
         LET g_errno = 'axm-00200'
      WHEN cl_null(p_xmdl204)
         LET g_errno = 'adb-00091'
      WHEN cl_null(p_xmdl205)
         LET g_errno = 'adb-00092'
      WHEN SQLCA.sqlcode = 100
         LET g_errno = 'aim-00066'
      WHEN cl_null(l_imaa104)
         LET g_errno = 'adb-00267'
   END CASE
          
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE WINDOW w_adbt540_01
      LET r_success = FALSE
      RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   END IF
   
   INITIALIZE g_xmdl.* TO NULL
   #包裝單位與庫存單位轉換
   IF NOT cl_null(p_xmdl008) AND NOT cl_null(p_xmdl204) AND 
      NOT cl_null(l_imaa104) AND NOT cl_null(p_xmdl205) THEN
      #                          料件      單位(原)   單位(轉換) 數量(原)
      CALL s_aooi250_convert_qty(p_xmdl008,p_xmdl204,l_imaa104,p_xmdl205)
           RETURNING l_success,g_xmdl.xmdl0181
      IF NOT l_success THEN
         CLOSE WINDOW w_adbt540_01
         LET r_success = FALSE
         RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
      END IF
   END IF
   
   LET g_xmdk082 = p_xmdk082            #銷退方式
   
   #將主程式的資訊帶入
   LET g_xmdl.xmdlsite = p_xmdlsite     #發貨組織
   LET g_xmdl.xmdldocno = p_xmdmdocno   #單據單號
   LET g_xmdl.xmdlseq = p_xmdmseq       #項次
   LET g_xmdl.xmdl008 = p_xmdl008       #料件編號
   LET g_xmdl.xmdl009 = p_xmdl009       #產品特徵
   LET g_xmdl.xmdl011 = p_xmdl011       #作業編號
   LET g_xmdl.xmdl012 = p_xmdl012       #製程序
   LET g_xmdl.xmdl017 = p_xmdl017       #出貨單位
   LET g_xmdl.xmdl018 = p_xmdl018       #數量
   LET g_xmdl.xmdl001 = p_xmdl001       #出通單號
   LET g_xmdl.xmdl002 = p_xmdl002       #出通項次
   LET g_xmdl.xmdl019 = p_xmdl019       #參考單位
   LET g_xmdl.xmdl020 = p_xmdl020       #參考數量
   LET g_xmdl.xmdl204 = p_xmdl204       #包裝單位
   LET g_xmdl.xmdl205 = p_xmdl205       #包裝數量
   LET g_xmdl.imaa104 = l_imaa104       #庫存單位
   LET g_xmdl.xmdl081 = p_xmdl081       #簽退數量
   LET g_xmdl.xmdl082 = p_xmdl082       #簽退參考數量   
   LET g_xmdl.xmdl200 = p_xmdl200       #銷售渠道
   LET g_xmdl.xmdl222 = p_xmdl222       #地區編號
   LET g_xmdl.xmdl223 = p_xmdl223       #縣市編號
   LET g_xmdl.xmdl224 = p_xmdl224       #省區編號
   LET g_xmdl.xmdl225 = p_xmdl225       #區域編號   
   #150302-00004#11 150305 by lori522612 add---(S)   
   LET g_xmdl.xmdl001 = p_xmdl001
   LET g_xmdl.xmdl002 = p_xmdl002
   LET g_xmdl.xmdl003 = p_xmdl003
   LET g_xmdl.xmdl004 = p_xmdl004
   LET g_xmdl.xmdl005 = p_xmdl005
   LET g_xmdl.xmdl006 = p_xmdl006
   #150302-00004#11 150305 by lori522612 add---(E)  
   
   #160826-00007#1 160831 by lori add---(S)
   LET g_xmdk201 = ''
   CASE p_control
      WHEN '1'   #出貨單
         SELECT xmdk201 INTO g_xmdk201 FROM xmdk_t WHERE xmdkent = g_enterprise AND xmdkdocno = p_xmdmdocno         
      WHEN '2'   #出通單
         SELECT xmdg201 INTO g_xmdk201 FROM xmdg_t WHERE xmdgent = g_enterprise AND xmdgdocno = p_xmdmdocno
   END CASE
   #160826-00007#1 160831 by lori add---(E)
   
   #產品特徵為Null要補' '
   IF cl_null(g_xmdl.xmdl009) THEN LET g_xmdl.xmdl009 = ' ' END IF

   #隱藏、替換畫面說明
   CALL adbt540_01_window_show(p_control)

   CALL adbt540_01_display_xmdl()        #單頭display   
   
   #檢查是否存在來源限制條件
   LET g_xmdl013 = ''  #多庫儲批
   LET g_xmdl014 = ''  #庫位
   LET g_xmdl015 = ''  #儲位
   LET g_xmdl016 = ''  #批號
   LET g_xmdl052 = ''  #庫存管理特徵
   
   #唯"出通單"與"出貨單"做限制
   #依來源單據取得 xmdl013(多庫儲批否),xmdl014(限定庫位),xmdl015(限定儲位),xmdl016(限定批號),xmdl052(庫存管理特徵)
   #若來源單據有做上述幾項限制,則多庫儲批維護時,可維護的庫儲批受限制在指定範圍內
   #例如：1) xmdl013=Y, 則庫儲批均不可修改,亦不可增刪, 只可維護數量
   #例如：2) xmdl014 IS NOT NULL, 則庫位不可修改, 儲位限定屬於該庫位
   IF p_control = '1' OR p_control = '2' THEN      
      CALL s_adbt540_source_define(g_xmdl.xmdl001,g_xmdl.xmdl002,
                                   g_xmdl.xmdl003,g_xmdl.xmdl004,g_xmdl.xmdl005,g_xmdl.xmdl006)   #lori522612  150225  mod 調整傳入參數 
         RETURNING g_xmdl013,g_xmdl014,g_xmdl015,g_xmdl016,g_xmdl052
   END IF
  
   #清空temp_table
   DELETE FROM adbt540_01_temp
   
   #塞temp_table
   IF adbt540_01_xmdm_count(p_control) THEN                             #檢查是否已有多庫儲批資料
      CALL adbt540_01_insert_temp_table() RETURNING r_success           #僅列出已輸入資料
   ELSE
      CALL adbt540_01_insert_temp_table1(p_control) RETURNING r_success  #將來源、庫存列出
   END IF
   
   IF NOT r_success THEN
      CLOSE WINDOW w_adbt540_01
      RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   END IF
   
   #顯示單身
   CALL adbt540_01_b_fill(p_control)
     
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
            CLOSE WINDOW w_adbt540_01

            RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
         ELSE
            CALL cl_get_doc_para(g_enterprise,g_xmdl.xmdlsite,l_ship,'D-BAS-0070') RETURNING g_booking
         END IF
         
      WHEN '2'   #出通單
         #出庫單據考慮在揀量
         CALL s_aooi200_get_slip(g_xmdl.xmdldocno) RETURNING r_success,l_ship
         IF NOT r_success THEN
            CLOSE WINDOW w_adbt540_01
            
            RETURN r_success,r_rollback,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
         ELSE
            CALL cl_get_doc_para(g_enterprise,g_xmdl.xmdlsite,l_ship,'D-BAS-0070') RETURNING g_booking
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
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx                        
            
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               LET g_xmdm_d_t.* = g_xmdm_d[l_ac].*  #BACKUP   
               LET g_xmdm_d_o.* = g_xmdm_d[l_ac].*               
            ELSE
               LET l_cmd='a'
            END IF
            
            CALL adbt540_01_set_entry()
            CALL adbt540_01_set_no_entry(p_control)
            
         BEFORE INSERT                  
            LET l_cmd = 'a'
            INITIALIZE g_xmdm_d_t.* TO NULL
            INITIALIZE g_xmdm_d_o.* TO NULL
            INITIALIZE g_xmdm_d[l_ac].* TO NULL
            LET g_xmdm_d[l_ac].xmdmdocno = g_xmdl.xmdldocno
            LET g_xmdm_d[l_ac].xmdmseq = g_xmdl.xmdlseq
            
            LET g_xmdm_d[l_ac].xmdm001 = g_xmdl.xmdl008
            LET g_xmdm_d[l_ac].xmdm002 = g_xmdl.xmdl009
            LET g_xmdm_d[l_ac].xmdm003 = g_xmdl.xmdl011
            LET g_xmdm_d[l_ac].xmdm004 = g_xmdl.xmdl012
            
            LET g_xmdm_d[l_ac].xmdm005 = g_xmdl014        #庫位
            CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            
            LET g_xmdm_d[l_ac].xmdm006 = g_xmdl015        #儲位
            CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            
            LET g_xmdm_d[l_ac].xmdm007 = g_xmdl016        #批號
            LET g_xmdm_d[l_ac].xmdm033 = g_xmdl052        #庫存管理特徵  
            
            LET g_xmdm_d[l_ac].xmdm008 = g_xmdl.xmdl017
            LET g_xmdm_d[l_ac].xmdm010 = g_xmdl.xmdl019 
            
            #成本庫否
            CALL s_adb_get_inaa010(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].cost   #150302-00004#14 150305 by lori522612 mod
            
            CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].xmdm008_desc
            CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm010) RETURNING g_xmdm_d[l_ac].xmdm010_desc
            
            SELECT MAX(xmdmseq1)+1 INTO g_xmdm_d[l_ac].xmdmseq1 
              FROM adbt540_01_temp
             WHERE xmdment = g_enterprise
               AND xmdmdocno = g_xmdl.xmdldocno
               AND xmdmseq = g_xmdl.xmdlseq
            
            IF cl_null(g_xmdm_d[l_ac].xmdmseq1) THEN
               LET g_xmdm_d[l_ac].xmdmseq1 = 1
            END IF
            
            LET g_xmdm_d_t.* = g_xmdm_d[l_ac].*
            LET g_xmdm_d_o.* = g_xmdm_d[l_ac].*
            CALL cl_show_fld_cont()
            CALL adbt540_01_set_entry()
            CALL adbt540_01_set_no_entry(p_control) 
            
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
             
            IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN
               CANCEL INSERT
            ELSE
               #庫儲批補空格及資料重複輸入檢查
               IF NOT adbt540_01_repeat_chk(p_control) THEN
                  LET INT_FLAG = FALSE
                  CANCEL INSERT
                  #benson-mark  
                  #NEXT FIELD xmdm005
               END IF
               
               #批號檢查
               IF NOT adbt540_01_xmdm007_chk(p_control) THEN               
                  LET INT_FLAG = FALSE
                  CANCEL INSERT
               END IF
               
               INSERT INTO adbt540_01_temp(cost,
                                           xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                                           xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                           xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                           xmdm011,xmdm031,xmdm032,xmdm033)
                    VALUES (g_xmdm_d[l_ac].cost,
                            g_enterprise,g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdmdocno,g_xmdm_d[l_ac].xmdmseq,g_xmdm_d[l_ac].xmdmseq1,
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
            END IF
            
         BEFORE DELETE                     
            IF NOT cl_null(g_xmdm_d[l_ac].xmdmdocno) AND
               NOT cl_null(g_xmdm_d[l_ac].xmdmseq) AND
               NOT cl_null(g_xmdm_d[l_ac].xmdmseq1) THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               
               DELETE FROM adbt540_01_temp
               WHERE xmdment = g_enterprise
                 AND xmdmdocno = g_xmdm_d_t.xmdmdocno
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
                  LET g_rec_b = g_rec_b-1
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
            IF NOT adbt540_01_repeat_chk(p_control) THEN
               NEXT FIELD xmdm005
            END IF
            
            #批號檢查
            IF NOT adbt540_01_xmdm007_chk(p_control) THEN               
               NEXT FIELD xmdm005
            END IF
            
            UPDATE adbt540_01_temp SET cost = g_xmdm_d[l_ac].cost,
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
             WHERE xmdment = g_enterprise
               AND xmdmdocno = g_xmdm_d_t.xmdmdocno
               AND xmdmseq = g_xmdm_d_t.xmdmseq
               AND xmdmseq1 = g_xmdm_d_t.xmdmseq1
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdm_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               LET g_xmdm_d[l_ac].* = g_xmdm_d_t.*
            END IF    
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
 
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmdocno
            #add-point:BEFORE FIELD xmdmdocno name="input.b.page1.xmdmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmdocno
            
            #add-point:AFTER FIELD xmdmdocno name="input.a.page1.xmdmdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdmdocno
            #add-point:ON CHANGE xmdmdocno name="input.g.page1.xmdmdocno"
            
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
            LET g_xmdm_d[l_ac].xmdm005_desc = ''
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm005) THEN
               IF g_xmdm_d[l_ac].xmdm005 <> g_xmdm_d_o.xmdm005 OR cl_null(g_xmdm_d_o.xmdm005) THEN   
                  #成本庫否
                  CALL s_adb_get_inaa010(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].cost   #150302-00004#14 150305 by lori522612 mod
                  
                  IF NOT adbt540_01_xmdm005_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm005 = g_xmdm_d_o.xmdm005
                     CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
                     NEXT FIELD CURRENT
                  END IF   
                  
                  ##檢查儲位
                  #IF NOT adbt540_01_xmdm006_chk(p_control) THEN
                  #   LET g_xmdm_d[l_ac].xmdm005 = g_xmdm_d_o.xmdm005
                  #   CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc                
                  #   NEXT FIELD CURRENT
                  #END IF
                  
                  ##儲位控管若為5.不使用儲位控管  
                  #IF NOT s_adbt600_inaa007_chk(g_xmdm_d[l_ac].xmdm005) THEN
                  #   LET g_xmdm_d[l_ac].xmdm006 = ' '
                  #   LET g_xmdm_d_o.xmdm006 = g_xmdm_d[l_ac].xmdm006                 
                  #END IF
               END IF
               
               IF p_control MATCHES '[12]' THEN  #出貨單、出通單
                  #benson-mark
                  #IF NOT adbt540_01_xmdm007_chk(p_control) THEN
                  #   NEXT FIELD xmdm007
                  #END IF
                  
                  CALL adbt540_01_inan010_display()
                  CALL adbt540_01_inag008_display()
                  CALL adbt540_01_ready_display()
               END IF 
            
               IF NOT adbt540_01_num_chk(p_control) THEN
                  LET g_xmdm_d_o.xmdm009 = ''
                  NEXT FIELD xmdm009
               END IF            
            
            ELSE
               LET g_xmdm_d[l_ac].cost = ''
               LET g_xmdm_d[l_ac].xmdm006 = ''
               LET g_xmdm_d[l_ac].xmdm006_desc = ''
               LET g_xmdm_d[l_ac].xmdm007 = ''
               LET g_xmdm_d[l_ac].xmdm033 = ''
               LET g_xmdm_d[l_ac].xmdm008 = ''
               LET g_xmdm_d[l_ac].xmdm008_desc = ''
               LET g_xmdm_d[l_ac].inag008 = ''
            END IF
            
            CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            LET g_xmdm_d_o.xmdm005 = g_xmdm_d[l_ac].xmdm005

            CALL adbt540_01_set_entry()
            CALL adbt540_01_set_no_entry(p_control)
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
            LET g_xmdm_d[l_ac].xmdm006_desc = ''
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm006) THEN
               IF g_xmdm_d[l_ac].xmdm006 <> g_xmdm_d_o.xmdm006 OR g_xmdm_d_o.xmdm006 IS NULL THEN 
                  IF NOT adbt540_01_xmdm006_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm006 = g_xmdm_d_o.xmdm006
                     CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
                     NEXT FIELD CURRENT
                  END IF
           
                  #成本庫否
                  CALL s_adb_get_inaa010(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].cost   #150302-00004#14 150305 by lori522612 mod
                                                       
               END IF
            END IF
              
            CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            LET g_xmdm_d_o.xmdm006 = g_xmdm_d[l_ac].xmdm006
 
            IF p_control MATCHES '[12]' THEN  #出貨單、出通單
               #benson-mark
               #IF NOT adbt540_01_xmdm007_chk(p_control) THEN
               #   NEXT FIELD xmdm007
               #END IF
               
               CALL adbt540_01_inan010_display()
               CALL adbt540_01_inag008_display()
               CALL adbt540_01_ready_display()
            END IF

            
            IF NOT adbt540_01_num_chk(p_control) THEN  
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
               IF g_xmdm_d[l_ac].xmdm007 <> g_xmdm_d_o.xmdm007 OR g_xmdm_d_o.xmdm007 IS NULL THEN 
                  IF NOT cl_null(g_xmdm_d[l_ac].xmdm007) THEN 
                     IF NOT adbt540_01_xmdm007_chk(p_control) THEN
                        LET g_xmdm_d[l_ac].xmdm007 = g_xmdm_d_o.xmdm007
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  #成本庫否
                  CALL s_adb_get_inaa010(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].cost   #150302-00004#14 150305 by lori522612 mod---(S)
               END IF
            END IF                 

            LET g_xmdm_d_o.xmdm007 = g_xmdm_d[l_ac].xmdm007
            
            IF p_control MATCHES '[12]' THEN  #出貨單、出通單
               CALL adbt540_01_inan010_display()
               CALL adbt540_01_inag008_display()
               CALL adbt540_01_ready_display()
            END IF                 
            
            IF NOT adbt540_01_num_chk(p_control) THEN   #140707
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
               IF g_xmdm_d[l_ac].xmdm033 <> g_xmdm_d_o.xmdm033 OR g_xmdm_d_o.xmdm033 IS NULL THEN 
               
                  #成本庫否
                  CALL s_adb_get_inaa010(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].cost   #150302-00004#14 150305 by lori522612 mod
               END IF
            END IF
            
            LET g_xmdm_d_o.xmdm033 = g_xmdm_d[l_ac].xmdm033

            IF p_control MATCHES '[12]' THEN  #出貨單、出通單
               CALL adbt540_01_inan010_display()
               CALL adbt540_01_inag008_display()
               CALL adbt540_01_ready_display()
            END IF            
                        
            IF NOT adbt540_01_num_chk(p_control) THEN
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
               IF g_xmdm_d[l_ac].xmdm009 <> g_xmdm_d_o.xmdm009 OR cl_null(g_xmdm_d_o.xmdm009) THEN
                  IF NOT adbt540_01_num_chk(p_control) THEN
                     LET g_xmdm_d[l_ac].xmdm009 = g_xmdm_d_o.xmdm009
                     NEXT FIELD CURRENT
                  END IF

                  #取位
                  CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm009) RETURNING l_success,g_xmdm_d[l_ac].xmdm009
                  
                  #推算參考數量
                  IF NOT cl_null(g_xmdm_d[l_ac].xmdm010) THEN
                     CALL s_aooi250_convert_qty(g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm009)
                     RETURNING l_success,g_xmdm_d[l_ac].xmdm011
                  END IF
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
               IF g_xmdm_d[l_ac].xmdm031 <> g_xmdm_d_o.xmdm031 OR cl_null(g_xmdm_d_o.xmdm031) THEN
            
                  IF NOT adbt540_01_num_chk(p_control) THEN
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
               IF NOT adbt540_01_sum_chk(p_control,'1') THEN
                  NEXT FIELD xmdm011
               END IF            
               #參考數量取位
               CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm011) RETURNING l_success,g_xmdm_d[l_ac].xmdm011
            END IF 

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
                IF NOT adbt540_01_sum_chk(p_control,'1') THEN
                   NEXT FIELD xmdm032
                END IF            
            
               #參考數量取位
               CALL s_aooi250_take_decimals(g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm032) RETURNING l_success,g_xmdm_d[l_ac].xmdm032
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm032
            #add-point:BEFORE FIELD xmdm032 name="input.b.page1.xmdm032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm032
            #add-point:ON CHANGE xmdm032 name="input.g.page1.xmdm032"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdmdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmdocno
            #add-point:ON ACTION controlp INFIELD xmdmdocno name="input.c.page1.xmdmdocno"
            
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
            #benson-mark
            ##開窗i段
            #CASE p_control
            #   WHEN '6' #銷退單
            #      #得出來源成本庫否
            #      CALL adbt540_01_warehouse_cost() RETURNING l_type
            #
		      #      INITIALIZE g_qryparam.* TO NULL
            #      LET g_qryparam.state = 'i'
		      #      LET g_qryparam.reqry = FALSE
            #   
            #      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值
            #
            #      #給予arg
            #      LET g_qryparam.arg1 = g_xmdl.xmdlsite
            #
            #      #串上成本庫否
            #      IF NOT cl_null(l_type) THEN
            #         LET g_qryparam.where = "inaa010 = '",l_type,"'"
            #      END IF
            #   
            #      CALL q_inaa001_4()                              #呼叫開窗
            #   
            #      LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #
            #   OTHERWISE  #出貨單、出通單
		      #     	INITIALIZE g_qryparam.* TO NULL
            #      LET g_qryparam.state = 'i'
		      #      LET g_qryparam.reqry = FALSE
            #  
            #      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值
            #      LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006             #儲位編號
            #      LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007             #批號
            #  
            #      #給予arg
            #      LET g_qryparam.arg1 = g_xmdl.xmdlsite
            #      LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm001
            #      LET g_qryparam.arg3 = g_xmdm_d[l_ac].xmdm002
            #      LET g_qryparam.arg4 = ' '
            #  
            #      CALL q_inag004_14()                                #呼叫開窗                  
            #  
            #      LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #      LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2   #儲位編號
            #      LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3   #批號
            #      
            #END CASE
            #
            #CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            #CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            CALL adbt540_01_xmdm005_xmdm006_xmdm007_xmdm033_qry('1',p_control)
            NEXT FIELD xmdm005                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm006
            #add-point:ON ACTION controlp INFIELD xmdm006 name="input.c.page1.xmdm006"
            #benson-mark
            ##開窗i段
            #CASE p_control
            #   WHEN '6'  #銷退單
            #      IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN
            #         INITIALIZE g_errparam TO NULL
            #         LET g_errparam.code = 'sub-00126'   #庫位不可為空
            #         LET g_errparam.extend = ''
            #         LET g_errparam.popup = TRUE
            #         CALL cl_err()
            #
            #         NEXT FIELD xmdm005
            #      END IF
            #
		      #      INITIALIZE g_qryparam.* TO NULL
            #      LET g_qryparam.state = 'i'
		      #      LET g_qryparam.reqry = FALSE
            #   
            #      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm006  #給予default值
            #
            #      #給予arg
            #      LET g_qryparam.arg1 = g_xmdl.xmdlsite
            #      LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm005
            #   
            #      CALL q_inab002_8()                                #呼叫開窗
            #   
            #      LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #
            #   OTHERWISE #出貨單、出通單
      		#      INITIALIZE g_qryparam.* TO NULL
            #      LET g_qryparam.state = 'i'
		      #      LET g_qryparam.reqry = FALSE
            #        
            #      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值
            #      LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006             #儲位編號
            #      LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007             #批號
            #        
            #      #給予arg
            #      LET g_qryparam.arg1 =g_xmdl.xmdlsite
            #      LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm001
            #      LET g_qryparam.arg3 = g_xmdm_d[l_ac].xmdm002
            #      LET g_qryparam.arg4 = ' '
            #        
            #      CALL q_inag004_14()                                #呼叫開窗 
            # 
            #      LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #      LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2   #儲位編號
            #      LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3   #批號
            #      
            #END CASE
            #
            #CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            #CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            CALL adbt540_01_xmdm005_xmdm006_xmdm007_xmdm033_qry('2',p_control)                  
            NEXT FIELD xmdm006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm007
            #add-point:ON ACTION controlp INFIELD xmdm007 name="input.c.page1.xmdm007"
            #benson-mark
            ##開窗i段
            #CASE p_control
            #   WHEN '6'  #銷退單 
		      #     	INITIALIZE g_qryparam.* TO NULL
            #      LET g_qryparam.state = 'i'
		      #      LET g_qryparam.reqry = FALSE
            #  
            #      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm007             #給予default值
            #  
            #      #給予arg
            #      LET g_qryparam.arg1 = g_xmdl.xmdlsite
            #      LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm001
            #      LET g_qryparam.arg3 = g_xmdm_d[l_ac].xmdm002
            #  
            #      #接上來源單據
            #      IF NOT cl_null(g_xmdl.xmdl001) AND NOT cl_null(g_xmdl.xmdl002) THEN
            #         LET g_qryparam.where = "inad003 IN (SELECT xmdm007 FROM xmdm_t",
            #                                "             WHERE xmdment = '",g_enterprise,"'",
            #                                "               AND xmdmdocno = '",g_xmdl.xmdl001,"'",
            #                                "               AND xmdmseq = '",g_xmdl.xmdl002,"')"
            #      END IF
            #  
            #      CALL q_inad003()                
            #   
            #      LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #                                
            #   OTHERWISE #出貨單、出通單               
		      #     	INITIALIZE g_qryparam.* TO NULL
            #      LET g_qryparam.state = 'i'
		      #      LET g_qryparam.reqry = FALSE
            #  
            #      LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值
            #      LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006             #儲位編號
            #      LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007             #批號
            #  
            #      #給予arg
            #      LET g_qryparam.arg1 = g_xmdl.xmdlsite
            #      LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm001
            #      LET g_qryparam.arg3 = g_xmdm_d[l_ac].xmdm002
            #      LET g_qryparam.arg4 = ' '
            #  
            #      CALL q_inag004_14()                                #呼叫開窗 
            #
            #      LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #      LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2   #儲位編號
            #      LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3   #批號
            #      
            #END CASE
            #
            #CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            #CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            #CALL adbt540_01_xmdm005_xmdm006_xmdm007_xmdm033_qry('3',p_control)
            #NEXT FIELD xmdm007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm033
            #add-point:ON ACTION controlp INFIELD xmdm033 name="input.c.page1.xmdm033"
            #benson-mark
            ##應用 a07 樣板自動產生(Version:1)   
            ##開窗i段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #
            #LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm033             #給予default值
            #
            ##給予arg
            #LET g_qryparam.arg1 = "" #s
            #
            #
            #CALL q_xmdm033()                                #呼叫開窗
            #
            #LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return1              
            #
            #DISPLAY g_xmdm_d[l_ac].xmdm033 TO xmdm033              #
            #CALL adbt540_01_xmdm005_xmdm006_xmdm007_xmdm033_qry('4',p_control)
            #NEXT FIELD xmdm033                          #返回原欄位


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
            IF NOT adbt540_01_sum_chk(p_control,'2') THEN
               NEXT FIELD xmdm009
            END IF
            #benson-mark
            #CALL adbt540_01_xmdm_t_insert(p_control) RETURNING r_success
            #IF NOT r_success THEN
            #   #LET r_rollback = TRUE  #多庫儲批資料出現錯誤必須rollback   
            #   NEXT FIELD xmdm009              
            #END IF
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      #benson-mark
      #BEFORE DIALOG
      #   NEXT FIELD xmdm005
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         #benson-mark
         #IF NOT adbt540_01_mutil_subinv_chk(p_control,p_xmdmdocno,p_xmdmseq) THEN
         #   CONTINUE DIALOG
         #END IF
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
   CLOSE WINDOW w_adbt540_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL adbt540_01_xmdm_t_insert(p_control) RETURNING r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
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
 
{<section id="adbt540_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="adbt540_01.other_function" readonly="Y" >}

PRIVATE FUNCTION adbt540_01_xmdm_count(p_control)
   DEFINE p_control    LIKE type_t.chr5   
   DEFINE l_n     LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE   
   LET l_n = 0
   
   CASE p_control

      WHEN '5'   #簽退單
         RETURN r_success       #直接列出簽退單資料
      WHEN '6'   #銷退單
         SELECT COUNT(xmdmseq1) INTO l_n
           FROM xmdm_t
          WHERE xmdment = g_enterprise
            AND xmdmdocno = g_xmdl.xmdldocno
            AND xmdmseq = g_xmdl.xmdlseq
      OTHERWISE  #出通單、出貨單、簽收單
         LET r_success = FALSE  #一律列出所有庫存或來源
         RETURN r_success
   END CASE
      
   IF l_n <= 1 THEN   #一筆也視作無多庫儲批
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_display_xmdl()
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
   DISPLAY BY NAME g_xmdl.xmdl204
   DISPLAY BY NAME g_xmdl.xmdl205
   DISPLAY BY NAME g_xmdl.imaa104
   DISPLAY BY NAME g_xmdl.xmdl0181
   
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
   
   #包裝單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl204) RETURNING l_oocal003
   DISPLAY l_oocal003 TO xmdl204_desc
   
   #庫存單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.imaa104) RETURNING l_oocal003
   DISPLAY l_oocal003 TO imaa104_desc
END FUNCTION

PUBLIC FUNCTION adbt540_01_create_temp_table()
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE  
     
   CALL adbt540_01_drop_temp_table()
   CREATE TEMP TABLE adbt540_01_temp
          (cost        LIKE type_t.chr1,      #成本庫否
           xmdment     LIKE xmdm_t.xmdment,
           xmdmsite    LIKE xmdm_t.xmdmsite,
           xmdmdocno   LIKE xmdm_t.xmdmdocno,
           xmdmseq     LIKE xmdm_t.xmdmseq,
           xmdmseq1    LIKE xmdm_t.xmdmseq1,
           xmdm001     LIKE xmdm_t.xmdm001,
           xmdm002     LIKE xmdm_t.xmdm002,
           xmdm003     LIKE xmdm_t.xmdm003,
           xmdm004     LIKE xmdm_t.xmdm004,
           xmdm005     LIKE xmdm_t.xmdm005,
           xmdm006     LIKE xmdm_t.xmdm006,
           xmdm007     LIKE xmdm_t.xmdm007,
           xmdm008     LIKE xmdm_t.xmdm008,
           xmdm009     LIKE xmdm_t.xmdm009,
           xmdm010     LIKE xmdm_t.xmdm010,
           xmdm011     LIKE xmdm_t.xmdm011,
           xmdm031     LIKE xmdm_t.xmdm031,
           xmdm032     LIKE xmdm_t.xmdm032,
           xmdm033     LIKE xmdm_t.xmdm033);
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'CREATE'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_insert_temp_table()
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
            
   LET l_sql = "SELECT xmdmseq1, ",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm031,xmdm032,xmdm033",
               "  FROM xmdm_t",
               " WHERE xmdment = '",g_enterprise,"'",
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
               " ORDER BY xmdmseq1"
   
   PREPARE adbt540_01_temp_pre FROM l_sql
   DECLARE adbt540_01_temp_cs CURSOR FOR adbt540_01_temp_pre
   
   INITIALIZE l_xmdm.* TO NULL
      
   FOREACH adbt540_01_temp_cs INTO l_xmdm.xmdmseq1,
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
      CALL s_adb_get_inaa010(g_xmdl.xmdlsite,l_xmdm.xmdm005) RETURNING l_xmdm.cost   #150302-00004#14 150305 by lori522612 mod
      
      INSERT INTO adbt540_01_temp(cost,
                                  xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                                  xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                  xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                  xmdm011,
                                  xmdm031,xmdm032,xmdm033)
           VALUES(l_xmdm.cost,
                  g_enterprise,g_xmdl.xmdlsite,g_xmdl.xmdldocno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                  l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                  l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                  l_xmdm.xmdm011,
                  l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:adbt540_01_temp"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   CLOSE adbt540_01_temp_cs
   FREE adbt540_01_temp_pre
      
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 多庫儲批維護
# Memo...........: 顯示既有庫存明細提供出貨維護
# Usage..........: adbt540_01_insert_temp_table1(p_control)
# Date & Author..: 
# Modify.........: 
################################################################################
PRIVATE FUNCTION adbt540_01_insert_temp_table1(p_control)
   DEFINE p_control        LIKE type_t.chr5  
   DEFINE l_sql            STRING
   DEFINE l_xmdm           type_g_xmdm_data
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_xmdm009        LIKE xmdm_t.xmdm009
   DEFINE l_xmdm011        LIKE xmdm_t.xmdm011 
   DEFINE l_xmdm031        LIKE xmdm_t.xmdm031
   DEFINE l_xmdm032        LIKE xmdm_t.xmdm032
   DEFINE l_seq            LIKE type_t.num5
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_xmdk039        LIKE xmdk_t.xmdk039
   DEFINE l_xmdk040        LIKE xmdk_t.xmdk040
   DEFINE l_where          STRING

   LET r_success = TRUE
   
   LET l_where = s_adbi260_sql_where(g_xmdl.xmdlsite,'inag004',g_xmdl.xmdl008,g_xmdl.xmdl200,
                                     g_xmdl.xmdl225,g_xmdl.xmdl224,g_xmdl.xmdl223,g_xmdl.xmdl222)                                 
   
   CASE p_control
      WHEN '1'  #出貨單
         IF g_xmdl013 = 'Y' THEN #出通單已做多庫儲批
            #先列出出通單庫儲批，之後再替換上已輸入的資料
            LET l_sql = "SELECT DISTINCT '','',xmdi005,xmdi006,xmdi007,xmdi013",
                        "  FROM xmdi_t",
                        " WHERE xmdient = ",g_enterprise,
                        "   AND xmdidocno = '",g_xmdl.xmdl001,"'",
                        "   AND xmdiseq = '",g_xmdl.xmdl002,"'",
                        " ORDER BY xmdi005,xmdi006,xmdi007,xmdi013"

         ELSE
            #先列出所有庫存庫儲批，之後再替換上已輸入的資料
            LET l_sql = "SELECT DISTINCT '','',inag004,inag005,inag006,inag003",
                        "  FROM inag_t",
                        " WHERE inagent = ",g_enterprise,
                        "   AND inagsite = '",g_xmdl.xmdlsite,"'",
                        "   AND inag001 = '",g_xmdl.xmdl008,"'",
                        "   AND inag002 = '",g_xmdl.xmdl009,"'",
                        "   AND inag007 = '",g_xmdl.xmdl017,"'"
                        
            #160826-00007#1 160831 by lori add---(S)
            IF NOT cl_null(g_xmdk201) THEN
               LET l_sql = l_sql,
                           " EXISTS(SELECT 1 FROM dbag_t WHERE dbagent = inagent ",
                           "           AND dbagsite = inagsite AND dbag001 = '1' ",
                           "           AND dbag002 = '",g_xmdk201,"' ",
                           "           AND (dbag004 = inag004 OR dbag006 = inag004)) " 
            END IF            
            #160826-00007#1 160831 by lori add---(S)   
            
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
            
            #將adbi260的設定條件加入            
            IF NOT cl_null(l_where) THEN
               LET L_sql = l_sql CLIPPED," AND ",l_where
            END IF            
            
            LET l_sql = l_sql," ORDER BY inag004,inag005,inag006,inag003"          
         END IF
         
      WHEN '2'  #出通單
         #先列出所有庫存庫儲批，之後再替換上已輸入的資料
         LET l_sql = "SELECT DISTINCT '','',inag004,inag005,inag006,inag003",
                     "  FROM inag_t",
                     " WHERE inagent = ",g_enterprise,
                     "   AND inagsite = '",g_xmdl.xmdlsite,"'",
                     "   AND inag001 = '",g_xmdl.xmdl008,"'",
                     "   AND inag002 = '",g_xmdl.xmdl009,"'",
                     "   AND inag007 = '",g_xmdl.xmdl017,"'"
                     
            #160826-00007#1 160831 by lori add---(S)
            IF NOT cl_null(g_xmdk201) THEN
               LET l_sql = l_sql,
                           " EXISTS(SELECT 1 FROM dbag_t WHERE dbagent = inagent ",
                           "           AND dbagsite = inagsite AND dbag001 = '1' ",
                           "           AND dbag002 = '",g_xmdk201,"' ",
                           "           AND (dbag004 = inag004 OR dbag006 = inag004)) " 
            END IF            
            #160826-00007#1 160831 by lori add---(S)  
            
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
         
         #將adbi260的設定條件加入            
         IF NOT cl_null(l_where) THEN
            LET L_sql = l_sql CLIPPED," AND ",l_where
         END IF
         
         LET l_sql = l_sql," ORDER BY inag004,inag005,inag006,inag003"
         
      WHEN '4'  #簽收單
         #列出來源單據批號
         LET l_sql = "SELECT DISTINCT xmdk039,xmdk040,",
                     "                xmdm005,xmdm006,xmdm007,xmdm033",
                     "  FROM xmdk_t,xmdm_t",
                     " WHERE xmdkent = xmdment AND xmdment = ",g_enterprise,
                     "   AND xmdkdocno = xmdmdocno AND xmdmdocno = '",g_xmdl.xmdl001,"'",
                     "   AND xmdmseq = '",g_xmdl.xmdl002,"'",
                     " ORDER BY xmdm005,xmdm006,xmdm007,xmdm033"
                     
      WHEN '6' #銷退單不自動帶出資料
         RETURN r_success

   END CASE

   PREPARE adbt540_01_temp_pre1 FROM l_sql
   DECLARE adbt540_01_temp_cs1 CURSOR FOR adbt540_01_temp_pre1

   CASE p_control
      WHEN '2'  #出通單
         LET l_sql = "SELECT xmdi009,xmdi011,'',''",
                     "  FROM xmdi_t",
                     " WHERE xmdient = '",g_enterprise,"'",
                     "   AND xmdidocno = '",g_xmdl.xmdldocno,"'",
                     "   AND xmdiseq = '",g_xmdl.xmdlseq,"'",
                     "   AND COALESCE(xmdi005,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdi006,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdi007,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdi013,' ') = COALESCE(?,' ')"
                     
      WHEN '4'   #簽收單
         LET l_sql = "SELECT xmdm009,xmdm011,xmdm031,xmdm032",
                     "  FROM xmdm_t",
                     " WHERE xmdment = '",g_enterprise,"'",
                     "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
                     "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
                     "   AND COALESCE(xmdm005,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm006,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm007,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm033,' ') = COALESCE(?,' ')"

      OTHERWISE  #出貨單
         LET l_sql = "SELECT xmdm009,xmdm011,'',''",
                     "  FROM xmdm_t",
                     " WHERE xmdment = '",g_enterprise,"'",
                     "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
                     "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
                     "   AND COALESCE(xmdm005,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm006,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm007,' ') = COALESCE(?,' ')",
                     "   AND COALESCE(xmdm033,' ') = COALESCE(?,' ')"                   
   END CASE
   
   PREPARE adbt540_01_current_data_pre FROM l_sql
   
   LET l_sql = "SELECT COUNT(xmdmseq1)",
               "  FROM adbt540_01_temp",
               " WHERE COALESCE(xmdm007,' ') = COALESCE(?,' ')"
   PREPARE adbt540_01_temp_pre4 FROM l_sql
   
   LET l_seq = 0
   INITIALIZE l_xmdm.* TO NULL
   
   FOREACH adbt540_01_temp_cs1 INTO l_xmdk039,l_xmdk040,
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
      
      IF p_control = '4' THEN #簽收單用"批號"來呈現來源資料
         LET l_num = 0
         EXECUTE adbt540_01_temp_pre4 USING l_xmdm.xmdm007 INTO l_num
         
         IF l_num > 0 THEN
            CONTINUE FOREACH
         END IF
      END IF
      
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
      CALL s_adb_get_inaa010(g_xmdl.xmdlsite,l_xmdm.xmdm005) RETURNING l_xmdm.cost   #150302-00004#14 150305 by lori522612 mod
      
      IF p_control = '4' THEN #簽收替換在途成本庫、非成本庫
         IF l_xmdm.cost = 'Y' THEN
            LET l_xmdm.xmdm005 = l_xmdk039
            LET l_xmdm.xmdm006 = ' '
            LET l_xmdm.xmdm033 = ' '
         ELSE
            LET l_xmdm.xmdm005 = l_xmdk040
            LET l_xmdm.xmdm006 = ' '
            LET l_xmdm.xmdm033 = ' '            
         END IF
      END IF
      
      #替代上已輸入的值
      LET l_xmdm009 = ''
      LET l_xmdm011 = ''
      LET l_xmdm031 = ''
      LET l_xmdm032 = ''      
      EXECUTE adbt540_01_current_data_pre USING l_xmdm.xmdm005,l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm033
      INTO l_xmdm009,l_xmdm011,l_xmdm031,l_xmdm032
      
      IF cl_null(l_xmdm009) THEN
         LET l_xmdm009 = 0
      END IF
      
      IF cl_null(l_xmdm011) AND NOT cl_null(l_xmdm.xmdm010) THEN
         LET l_xmdm011 = 0   #參考數量
      END IF
      
      IF cl_null(l_xmdm031) THEN
         LET l_xmdm031 = 0
      END IF
      
      IF cl_null(l_xmdm032) AND NOT cl_null(l_xmdm.xmdm010) THEN
         LET l_xmdm032 = 0    #簽退參考數量
      END IF
      
      LET l_xmdm.xmdm009 = l_xmdm009  #數量
      LET l_xmdm.xmdm011 = l_xmdm011  #參考數量
      LET l_xmdm.xmdm031 = l_xmdm031  #簽退數量
      LET l_xmdm.xmdm032 = l_xmdm032  #簽退參考數量
      
      INSERT INTO adbt540_01_temp(cost,
                                  xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                                  xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                  xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                  xmdm011,xmdm031,xmdm032,xmdm033)
           VALUES(l_xmdm.cost,
                  g_enterprise,g_xmdl.xmdlsite,g_xmdl.xmdldocno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                  l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                  l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                  l_xmdm.xmdm011,l_xmdm.xmdm031,l_xmdm.xmdm032,l_xmdm.xmdm033)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:adbt540_01_temp"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   CLOSE adbt540_01_temp_cs1
   FREE adbt540_01_temp_pre1 
   FREE adbt540_01_current_data_pre
   
   #Benson-mark
   #IF NOT r_success THEN  #AND l_seq < 2 THEN
   #   IF p_control MATCHES '[12]' THEN      #銷退單可在之後自行輸入，故不報錯離開
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'axm-00165'  #無符合之庫存明細或符合之庫存明細少於兩筆不可做多庫儲批！
   #      LET g_errparam.extend = ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF
   #END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_b_fill(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE l_sql        STRING
   
   LET l_sql = "SELECT cost,xmdmdocno,xmdmseq,xmdmseq1,",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm031,xmdm032,xmdm033",
               "  FROM adbt540_01_temp",
               " WHERE xmdment = ",g_enterprise,
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
               " ORDER BY xmdm009,xmdm011,xmdm031,xmdm032"

   PREPARE adbt540_01_b_pre FROM l_sql
   DECLARE adbt540_01_b_cs CURSOR FOR adbt540_01_b_pre

   CALL g_xmdm_d.clear()
   LET l_ac = 1
   FOREACH adbt540_01_b_cs INTO g_xmdm_d[l_ac].cost,g_xmdm_d[l_ac].xmdmdocno,g_xmdm_d[l_ac].xmdmseq,g_xmdm_d[l_ac].xmdmseq1,
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
      CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
      CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
      CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm008) RETURNING g_xmdm_d[l_ac].xmdm008_desc
      CALL s_desc_get_unit_desc(g_xmdm_d[l_ac].xmdm010) RETURNING g_xmdm_d[l_ac].xmdm010_desc

      IF p_control MATCHES '[12]' THEN  #出貨單、出通單
         CALL adbt540_01_inan010_display()
         CALL adbt540_01_inag008_display()
         CALL adbt540_01_ready_display()
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
   CLOSE adbt540_01_b_cs
   FREE adbt540_01_b_pre
END FUNCTION

PUBLIC FUNCTION adbt540_01_drop_temp_table()
   DROP TABLE adbt540_01_temp
END FUNCTION

PRIVATE FUNCTION adbt540_01_xmdm005_chk(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_success    LIKE type_t.num5   
   DEFINE l_type       LIKE type_t.chr1
   DEFINE l_sql        STRING
   DEFINE l_inaa014    LIKE inaa_t.inaa014
   
   LET r_success = TRUE
         
      CASE p_control
         WHEN '5'   #簽退單
            CALL adbt540_01_warehouse_cost() RETURNING l_type
            
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
            
            LET g_chkparam.arg1 = g_xmdl.xmdlsite
            LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005    #庫位
            LET g_chkparam.arg3 = l_type
            
            #呼叫檢查存在並帶值的library
            IF NOT cl_chk_exist("v_inaa001_6") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
      
         WHEN '6'  #銷退單
            #得出來源成本庫否
            CALL adbt540_01_warehouse_cost() RETURNING l_type

            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL

            #替換錯誤訊息
            LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_xmdl.xmdlsite
            LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005    #庫位
            LET g_chkparam.arg3 = l_type
            
            #呼叫檢查存在並帶值的library
            IF NOT cl_chk_exist("v_inaa001_6") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
           
            IF s_adbi260_setpoint(g_xmdl.xmdlsite,g_xmdl.xmdl008,g_xmdl.xmdl200,
                                  g_xmdl.xmdl225,g_xmdl.xmdl224,g_xmdl.xmdl223,g_xmdl.xmdl222) THEN
               #校驗是否符合adbi260的設定
               INITIALIZE g_chkparam.* TO NULL
                        
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdl.xmdlsite
               LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
               LET g_chkparam.arg3 = g_xmdl.xmdl008
               LET g_chkparam.arg4 = g_xmdl.xmdl200
               LET g_chkparam.arg5 = g_xmdl.xmdl225
               LET g_chkparam.arg6 = g_xmdl.xmdl224        
               LET g_chkparam.arg7 = g_xmdl.xmdl223  
               LET g_chkparam.arg8 = g_xmdl.xmdl222           
               #160318-00025#18  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#18  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001_16") THEN
                  LET r_success = FALSE
                  RETURN r_success
               END IF
            END IF
            
         OTHERWISE  #出貨單、出通單
            #160826-00007#1 160831 by lori add---(S)
            IF NOT cl_null(g_xmdk201) THEN
               CASE p_control
                  WHEN '1'   #出貨單
                     IF NOT s_adbt540_xmdm005_chk(g_xmdl.xmdldocno,g_xmdm_d[l_ac].xmdm005) THEN
                        LET r_success = FALSE
                        RETURN r_success
                     END IF                  
                  WHEN '2'   #出通單
                     IF NOT s_adbt520_xmdi005_chk(g_xmdl.xmdldocno,g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) THEN
                        LET r_success = FALSE
                        RETURN r_success
                     END IF
               END CASE
            END IF
            #160826-00007#1 160831 by lori add---(S)
            
            #校驗是否符合adbi260的設定
            INITIALIZE g_chkparam.* TO NULL
            
            LET g_chkparam.arg1 = g_xmdl.xmdlsite
            LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
            LET g_chkparam.arg3 = g_xmdl.xmdl008
            LET g_chkparam.arg4 = g_xmdl.xmdl200
            LET g_chkparam.arg5 = g_xmdl.xmdl225
            LET g_chkparam.arg6 = g_xmdl.xmdl224        
            LET g_chkparam.arg7 = g_xmdl.xmdl223  
            LET g_chkparam.arg8 = g_xmdl.xmdl222           
            #160318-00025#18  by 07900 --add-str
            LET g_errshow = TRUE #是否開窗                   
            LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
            #160318-00025#18  by 07900 --add-end 
            IF NOT cl_chk_exist("v_inaa001_16") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            
            IF NOT adbt540_01_subinv_cost_chk() THEN
               LET r_success = FALSE
               RETURN r_success            
            END IF
      END CASE
      
   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adbt540_01_xmdm006_chk(p_control)
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
      LET g_chkparam.arg1 = g_xmdl.xmdlsite
      LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
      LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm006
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inab002_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
            
   END IF
   
   RETURN r_success
   
   #benson-mark 
   #IF NOT cl_null(g_xmdm_d[l_ac].xmdm006) THEN
   #
   #   IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'sub-00126'
   #      LET g_errparam.extend = ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      RETURN FALSE
   #   END IF      
   #   CASE p_control 
   #      WHEN '6'    #銷退單      
   #         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   #         INITIALIZE g_chkparam.* TO NULL
   #                  
   #         #設定g_chkparam.*的參數
   #         LET g_chkparam.arg1 = g_xmdl.xmdlsite
   #         LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
   #         LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm006
   #                     
   #         #呼叫檢查存在並帶值的library
   #         IF NOT cl_chk_exist("v_inab002") THEN
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF         
   #
   #      OTHERWISE   #出貨單、出通單
   #         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   #         INITIALIZE g_chkparam.* TO NULL
   #                  
   #         #設定g_chkparam.*的參數
   #         LET g_chkparam.arg1 = g_xmdl.xmdlsite
   #         LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm001
   #         LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm002
   #         LET g_chkparam.arg4 = g_xmdm_d[l_ac].xmdm005
   #         LET g_chkparam.arg5 = g_xmdm_d[l_ac].xmdm006 
   #                     
   #         #呼叫檢查存在並帶值的library
   #         IF NOT cl_chk_exist("v_inag005_1") THEN
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF   
   #   END CASE
   #END IF
   #RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_xmdm007_chk(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_success    LIKE type_t.num5 
   DEFINE l_n          LIKE type_t.num5
   LET r_success = TRUE

   IF NOT cl_null(g_xmdm_d[l_ac].xmdm007) THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xmdl.xmdlsite
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
   
   #benson-mark
   #LET r_success = TRUE
   #IF NOT cl_null(g_xmdm_d[l_ac].xmdm007) THEN 
   #   CASE p_control
   #      WHEN '6'   #銷退單
   #         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   #         INITIALIZE g_chkparam.* TO NULL
   #                  
   #         #設定g_chkparam.*的參數
   #         LET g_chkparam.arg1 = g_xmdl.xmdlsite
   #         LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm001
   #         LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm002
   #         LET g_chkparam.arg4 = g_xmdm_d[l_ac].xmdm007
   #                     
   #         #呼叫檢查存在並帶值的library
   #         IF NOT cl_chk_exist("v_inad001_1") THEN
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF
   #
   #         #檢查是否存在來源單據
   #         IF NOT cl_null(g_xmdl.xmdl001) AND NOT cl_null(g_xmdl.xmdl002) THEN
   #            LET l_n = 0
   #            SELECT COUNT(xmdmseq1) INTO l_n
   #              FROM xmdm_t
   #             WHERE xmdment = g_enterprise
   #               AND xmdmdocno = g_xmdl.xmdl001
   #               AND xmdmseq = g_xmdl.xmdl002
   #               AND xmdm007 = g_xmdm_d[l_ac].xmdm007
   #         
   #            IF l_n < 1 THEN
   #               INITIALIZE g_errparam TO NULL
   #               LET g_errparam.code = 'axm-00388'  #該批號不存在來源單據！
   #               LET g_errparam.extend = ''
   #               LET g_errparam.popup = TRUE
   #               CALL cl_err()
   #
   #               LET r_success = FALSE
   #               RETURN r_success                  
   #            END IF
   #         END IF
   #
   #      OTHERWISE  #出貨單、出通單
   #         IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN
   #            INITIALIZE g_errparam TO NULL
   #            LET g_errparam.code = 'sub-00126'
   #            LET g_errparam.extend = ''
   #            LET g_errparam.popup = TRUE
   #            CALL cl_err()
   #
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF
   #            
   #         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   #         INITIALIZE g_chkparam.* TO NULL
   #         IF cl_null(g_xmdm_d[l_ac].xmdm002) THEN LET g_xmdm_d[l_ac].xmdm002 = ' ' END IF
   #         #設定g_chkparam.*的參數
   #         LET g_chkparam.arg1 = g_xmdl.xmdlsite
   #         LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm001
   #         LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm002
   #         LET g_chkparam.arg4 = g_xmdm_d[l_ac].xmdm005
   #         LET g_chkparam.arg5 = g_xmdm_d[l_ac].xmdm006
   #         LET g_chkparam.arg6 = g_xmdm_d[l_ac].xmdm007
   #                     
   #         #呼叫檢查存在並帶值的library
   #         IF NOT cl_chk_exist("v_inag006_1") THEN
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF
   #   END CASE   
   #END IF
   #RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_set_entry()
   CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm007,xmdm033",TRUE)
   CALL cl_set_comp_entry("xmdm009,xmdm031,xmdm011,xmdm032",TRUE)
END FUNCTION

PRIVATE FUNCTION adbt540_01_set_no_entry(p_control)
   DEFINE p_control    LIKE type_t.chr5

   #來源已做多庫儲批
   IF g_xmdl013 = 'Y' THEN
      CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm007,xmdm033",FALSE)
   END IF

   #來源有限制庫位
   IF NOT cl_null(g_xmdl014) THEN
      CALL cl_set_comp_entry("xmdm005",FALSE)
   END IF
   
   #來源有限制儲位
   IF NOT cl_null(g_xmdl015) THEN
      CALL cl_set_comp_entry("xmdm006",FALSE)
   END IF
   
   #來源有限制批號
   IF NOT cl_null(g_xmdl016) THEN
      CALL cl_set_comp_entry("xmdm007",FALSE)
   END IF
   
   #來源有限制庫存管理特徵
   IF NOT cl_null(g_xmdl052) THEN
      CALL cl_set_comp_entry("xmdm033",FALSE)
   END IF
   
   #檢查料件是否使用批號
   IF NOT adbt540_01_imaf061_chk() THEN
      CALL cl_set_comp_entry("xmdm007",FALSE)
   END IF
   
   #參考數量
   IF cl_null(g_xmdl.xmdl019) THEN
      CALL cl_set_comp_entry("xmdm011,xmdm032",FALSE)
   END IF

   #儲位控管若為5.不使用儲位控管
   IF NOT s_adbt600_inaa007_chk(g_xmdm_d[l_ac].xmdm005) THEN
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
  
  #benson-mark 不確定OTHERWISE的內容
  #CASE p_control
  #   WHEN '6'  #銷退單         
  #      IF g_xmdk082 = '4' THEN  #銷貨折讓
  #         CALL cl_set_comp_entry("xmdm005,xmdm006",FALSE)
  #      END IF
  #      
  #   OTHERWISE #出貨單、出通單
  #      CALL cl_set_comp_entry("xmdm005,xmdm006,xmdm007",FALSE)
  #      
  #END CASE
  

END FUNCTION

PRIVATE FUNCTION adbt540_01_imaf061_chk()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_imaf061    LIKE imaf_t.imaf061
   
   LET r_success = TRUE
   
   LET l_imaf061 = ''   
   SELECT imaf061 INTO l_imaf061
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = 'ALL'  #g_xmdl.xmdlsite
      AND imaf001 = g_xmdm_d[l_ac].xmdm001
      
   IF l_imaf061 <> '1' AND
      l_imaf061 <> '3' THEN   #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
         LET r_success = FALSE
         RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_inan010_display()
   DEFINE l_inan010     LIKE inan_t.inan010
      
   LET l_inan010 = 0
       
   SELECT SUM(inan010) INTO l_inan010
     FROM inan_t
    WHERE inanent = g_enterprise
      AND inansite = g_xmdl.xmdlsite
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

PRIVATE FUNCTION adbt540_01_inag008_display()
   DEFINE l_inag008    LIKE inag_t.inag008
  
   SELECT inag008
     INTO l_inag008
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inagsite = g_xmdl.xmdlsite
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

PRIVATE FUNCTION adbt540_01_ready_display()
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

################################################################################
# Descriptions...: 找單身項序最大值+1
# Memo...........:
# Usage..........: CALL adbt540_01_seq1_max(p_xmdldocno,p_xmdlseq,p_control)
#                  RETURNING r_xmdmseq1
# Input parameter: p_xmdldocno    單據單號
#                : p_xmdlseq      單身項次
#                : p_control      呼叫此子程式之程式
# Return code....: r_xmdmseq1     項序最大值+1
#                :
# Date & Author..: 140327 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt540_01_seq1_max(p_xmdldocno,p_xmdlseq,p_control)
   DEFINE p_xmdldocno     LIKE xmdl_t.xmdldocno
   DEFINE p_xmdlseq       LIKE xmdl_t.xmdlseq
   DEFINE p_control       LIKE type_t.chr5
   DEFINE r_xmdmseq1      LIKE xmdm_t.xmdmseq1

   LET r_xmdmseq1 = ''

   CASE p_control         
      WHEN '2'   #出通單
         SELECT MAX(xmdiseq1) + 1 INTO r_xmdmseq1
           FROM xmdi_t
          WHERE xmdient = g_enterprise
            AND xmdidocno = p_xmdldocno
            AND xmdiseq = p_xmdlseq
         
      OTHERWISE  #出貨單、銷退單
         SELECT MAX(xmdmseq1) + 1 INTO r_xmdmseq1
           FROM xmdm_t
          WHERE xmdment = g_enterprise
            AND xmdmdocno = p_xmdldocno
            AND xmdmseq = p_xmdlseq         
         
   END CASE
   
   IF cl_null(r_xmdmseq1) THEN
      LET r_xmdmseq1 = 1
   END IF
   
   RETURN r_xmdmseq1
         
END FUNCTION

PRIVATE FUNCTION adbt540_01_xmdm_t_insert(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE r_xmdl014    LIKE xmdl_t.xmdl014
   DEFINE r_xmdl015    LIKE xmdl_t.xmdl015
   DEFINE r_xmdl016    LIKE xmdl_t.xmdl016
   DEFINE r_xmdl052    LIKE xmdl_t.xmdl052  
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data   
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_num        LIKE type_t.num5
   
   LET r_success = TRUE

   LET r_xmdl014 = ''
   LET r_xmdl015 = ''
   LET r_xmdl016 = ''
   LET r_xmdl052 = ''
   
   #先將原有資料清除
   CASE p_control            
       WHEN '2'   #出通單
          DELETE FROM xmdi_t
           WHERE xmdient = g_enterprise
             AND xmdidocno = g_xmdl.xmdldocno
             AND xmdiseq = g_xmdl.xmdlseq
             
       OTHERWISE  #出貨單、銷退單、簽收單、簽退單
          DELETE FROM xmdm_t
           WHERE xmdment = g_enterprise
             AND xmdmdocno = g_xmdl.xmdldocno
             AND xmdmseq = g_xmdl.xmdlseq
   END CASE
          
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   END IF   
   
   LET l_sql = "SELECT xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm031,xmdm032,xmdm033",
               "  FROM adbt540_01_temp",
               " WHERE xmdment = '",g_enterprise,"'",
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'"
   PREPARE adbt540_01_pre1 FROM l_sql
   DECLARE adbt540_01_cs1 CURSOR FOR adbt540_01_pre1   
   
   FOREACH adbt540_01_cs1 INTO l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
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

      LET l_num = 0
     #benson-mark
     #IF NOT cl_null(l_xmdm.xmdm009) THEN LET l_num = l_num + l_xmdm.xmdm009 END IF
     #IF NOT cl_null(l_xmdm.xmdm011) THEN LET l_num = l_num + l_xmdm.xmdm011 END IF
     #IF NOT cl_null(l_xmdm.xmdm031) THEN LET l_num = l_num + l_xmdm.xmdm031 END IF
     #IF NOT cl_null(l_xmdm.xmdm032) THEN LET l_num = l_num + l_xmdm.xmdm032 END IF
     
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
      
      CALL adbt540_01_seq1_max(g_xmdl.xmdldocno,g_xmdl.xmdlseq,p_control) RETURNING l_xmdm.xmdmseq1               
      
      CASE p_control                         
         WHEN '2'  #出通單
            INSERT INTO xmdi_t(xmdient,xmdisite,xmdidocno,xmdiseq,xmdiseq1,
                               xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,
                               xmdi006,xmdi007,xmdi008,xmdi009,xmdi010,
                               xmdi011,xmdi012,xmdi013)
                 VALUES (g_enterprise,g_xmdl.xmdlsite,g_xmdl.xmdldocno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                         l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                         l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                         l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm033)
                         
         OTHERWISE #出貨單、銷退單                         
            INSERT INTO xmdm_t(xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                               xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                               xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                               xmdm011,xmdm012,xmdm013,xmdm014,xmdm031,
                               xmdm032,xmdm033)
                 VALUES (g_enterprise,g_xmdl.xmdlsite,g_xmdl.xmdldocno,g_xmdl.xmdlseq,l_xmdm.xmdmseq1,
                         l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                         l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                         l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,l_xmdm.xmdm031,
                         l_xmdm.xmdm032,l_xmdm.xmdm033)                         
      END CASE
      
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

   CLOSE adbt540_01_cs1
   FREE adbt540_01_pre1
   
   IF l_xmdm.xmdmseq1 = 1 THEN  #只有一筆
      LET r_xmdl014 = l_xmdm.xmdm005
      LET r_xmdl015 = l_xmdm.xmdm006
      LET r_xmdl016 = l_xmdm.xmdm007
      LET r_xmdl052 = l_xmdm.xmdm033
   END IF
   
   RETURN r_success,r_xmdl014,r_xmdl015,r_xmdl016,r_xmdl052
   
END FUNCTION

################################################################################
# Descriptions...: 隱藏、替換畫面說明
# Memo...........:
# Usage..........: CALL adbt540_01_window_show(p_control)
#                  
# Input parameter: p_control   呼叫此子程式之程式
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt540_01_window_show(p_control)
   DEFINE p_control    LIKE type_t.chr5
   DEFINE l_gzze003    LIKE gzze_t.gzze003
   
   #測試標題替換aaa
   #CALL cl_ui_set_subwin_title('axm-00378')

   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_xmdl.xmdlsite,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmdl009,xmdm002",FALSE)
   END IF

   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_xmdl.xmdlsite,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("xmdl019,xmdl019_display,xmdl020,xmdl082,
                                xmdm010,xmdm010_desc,xmdm011,xmdm032",FALSE)
   END IF

   CASE p_control
      WHEN '1'   #出貨單
         CALL cl_set_comp_visible("xmdl081,xmdl082,xmdl206,xmdl2061,xmdm031,xmdm032",FALSE)
      WHEN '2'   #出通單
         #欄位說明變更
         #出通資訊
         LET l_gzze003 = cl_getmsg('adb-00096',g_dlang)
         CALL cl_set_comp_att_text('group1',l_gzze003)
         #出通單項次
         LET l_gzze003 = cl_getmsg('adb-00097',g_dlang)
         CALL cl_set_comp_att_text('lbl_xmdlseq',l_gzze003)
         
         CALL cl_set_comp_visible("xmdl081,xmdl082,xmdl206,xmdl2061,xmdm031,xmdm032",FALSE)
      WHEN '6'   #銷退單
         LET l_gzze003 = ''
         LET l_gzze003 = cl_getmsg('axm-00378',g_dlang)
         CALL cl_set_comp_att_text('group1',l_gzze003)
         
         LET l_gzze003 = ''
         LET l_gzze003 = cl_getmsg('axm-00379',g_dlang)
         CALL cl_set_comp_att_text('lbl_xmdlseq',l_gzze003)
         
         LET l_gzze003 = ''
         LET l_gzze003 = cl_getmsg('axm-00380',g_dlang)
         CALL cl_set_comp_att_text('lbl_xmdm009',l_gzze003)      
   
         CALL cl_set_comp_visible("inag008,inan010,ready",FALSE)
         CALL cl_set_comp_visible("xmdl081,xmdl082,xmdl206,xmdl2061,xmdm031,xmdm032",FALSE)
         
      OTHERWISE  #簽收/簽退單
         CALL cl_set_comp_visible("xmdl081,xmdl082,xmdl206,xmdl2061,xmdm032",FALSE)
         
   END CASE

END FUNCTION

PRIVATE FUNCTION adbt540_01_repeat_chk(p_control)
   DEFINE p_control  LIKE type_t.chr5
   DEFINE l_n        LIKE type_t.num5
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE
   
   #庫位
   IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN LET g_xmdm_d[l_ac].xmdm005 = ' ' END IF   
   #儲位
   IF cl_null(g_xmdm_d[l_ac].xmdm006) THEN LET g_xmdm_d[l_ac].xmdm006 = ' ' END IF   
   #批號
   IF cl_null(g_xmdm_d[l_ac].xmdm007) THEN LET g_xmdm_d[l_ac].xmdm007 = ' ' END IF
   #庫存管理特徵
   IF cl_null(g_xmdm_d[l_ac].xmdm033) THEN LET g_xmdm_d[l_ac].xmdm033 = ' ' END IF   
      
   IF NOT adbt540_01_xmdm007_chk(p_control) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #重複輸入檢查
   LET l_n = 0
   SELECT COUNT(xmdmseq1) INTO l_n
     FROM adbt540_01_temp
    WHERE xmdm005 = g_xmdm_d[l_ac].xmdm005
      AND xmdm006 = g_xmdm_d[l_ac].xmdm006
      AND xmdm007 = g_xmdm_d[l_ac].xmdm007
      AND xmdm033 = g_xmdm_d[l_ac].xmdm033
      AND xmdmseq1 <> g_xmdm_d_t.xmdmseq1   #排除當下這筆
   
   #IF l_n > 1 THEN                        #150302-00004#11 150305 by lori522612 mark
   IF l_n > 0 THEN                        #150302-00004#11 150305 by lori522612 add
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
# Usage..........: CALL adbt540_01_sum_chk(p_control,p_type)
#                  RETURNING r_success
# Input parameter: p_control      呼叫子程式之程式
#                : p_type         1.AFTER FIELD 檢查  2.AFTER INPUT檢查
# Return code....: r_success      執行結果
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt540_01_sum_chk(p_control,p_type)
   DEFINE p_control       LIKE type_t.chr5
   DEFINE p_type          LIKE type_t.chr1  #1.AFTER FIELD檢查  2.AFTER INPUT檢查   
   DEFINE r_success       LIKE type_t.num5
 
   DEFINE l_xmdm009       LIKE xmdm_t.xmdm009
   DEFINE l_xmdm011       LIKE xmdm_t.xmdm011
   DEFINE l_xmdm031       LIKE xmdm_t.xmdm031
   DEFINE l_xmdm032       LIKE xmdm_t.xmdm032
   DEFINE l_xmdmseq1      LIKE xmdm_t.xmdmseq1
   DEFINE l_sql           STRING
   
   #benson-mark - s - 
   #DEFINE l_cnt           LIKE type_t.num5
   #DEFINE l_success       LIKE type_t.num5
   #DEFINE l_xmdl017       LIKE xmdl_t.xmdl017
   #DEFINE l_xmdl018       LIKE xmdl_t.xmdl018
   #DEFINE l_xmdl019       LIKE xmdl_t.xmdl019
   #DEFINE l_xmdl020       LIKE xmdl_t.xmdl020
   #DEFINE l_xmdl021       LIKE xmdl_t.xmdl021
   #DEFINE l_xmdl022       LIKE xmdl_t.xmdl022
   #DEFINE l_xmdl204       LIKE xmdl_t.xmdl204
   #DEFINE l_xmdl205       LIKE xmdl_t.xmdl205
   #DEFINE l_title         STRING
   #benson-mark - e -
   
   LET r_success = TRUE
   
   LET l_xmdm009 = ''
   LET l_xmdm011 = ''
   LET l_xmdm031 = ''
   LET l_xmdm032 = ''
   LET l_xmdmseq1 = ''
   
   LET l_sql = "SELECT SUM(COALESCE(xmdm009,0)),SUM(COALESCE(xmdm011,0)),SUM(COALESCE(xmdm031,0)),",
               "       SUM(COALESCE(xmdm032,0)),COUNT(xmdmseq1)",     
               "  FROM adbt540_01_temp",
               " WHERE xmdment = ",g_enterprise,
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
               "   AND (xmdm009 > 0 OR xmdm011 > 0 OR xmdm031 > 0 OR xmdm032 > 0)"
               
   IF p_type = '1' THEN
      LET l_sql = l_sql," AND xmdmseq1 <> '",g_xmdm_d[l_ac].xmdmseq1,"'"
   END IF

   PREPARE adbt540_01_temp_pre3 FROM l_sql
   
   EXECUTE adbt540_01_temp_pre3 INTO l_xmdm009,l_xmdm011,l_xmdm031,l_xmdm032,l_xmdmseq1
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
         
   END CASE
   
   #benson-mark - s - 
   #LET l_xmdm009 = ''
   #LET l_xmdm011 = ''
   #LET l_xmdm031 = ''
   #LET l_xmdm032 = ''
   #LET l_cnt     = ''
   #LET l_xmdl017 = ''
   #LET l_xmdl018 = ''
   #LET l_xmdl019 = ''
   #LET l_xmdl020 = ''
   #LET l_xmdl021 = ''
   #LET l_xmdl022 = ''
   #LET l_xmdl204 = ''
   #LET l_xmdl205 = ''
   #
   #LET l_sql = "SELECT COALESCE(SUM(COALESCE(xmdm009,0)),0), ",
   #            "       COALESCE(SUM(COALESCE(xmdm011,0)),0), ",
   #            "       COALESCE(SUM(COALESCE(xmdm031,0)),0), ",
   #            "       COALESCE(SUM(COALESCE(xmdm032,0)),0), ",
   #            "       COALESCE(COUNT(COALESCE(xmdmseq1,0)),0) ",       
   #            "  FROM adbt540_01_temp",
   #            " WHERE xmdment = '",g_enterprise,"'",
   #            "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
   #            "   AND xmdmseq = '",g_xmdl.xmdlseq,"'",
   #            "   AND (   COALESCE(xmdm009,0) > 0 ",
   #            "        OR COALESCE(xmdm011,0) > 0 ",
   #            "        OR COALESCE(xmdm031,0) > 0 ",
   #            "        OR COALESCE(xmdm032,0) > 0) "
   #            
   ##IF p_type = '1' THEN
   ##   LET l_sql = l_sql," AND xmdmseq1 <> '",g_xmdm_d[l_ac].xmdmseq1,"'"
   ##END IF
   #PREPARE adbt540_01_temp_pre3 FROM l_sql
   #EXECUTE adbt540_01_temp_pre3 INTO l_xmdm009,l_xmdm011,l_xmdm031,l_xmdm032,l_cnt
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'EXECUTE'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #
   ##IF cl_null(l_xmdm009)  THEN LET l_xmdm009 = 0 END IF
   ##IF cl_null(l_xmdm011)  THEN LET l_xmdm011 = 0 END IF
   ##IF cl_null(l_xmdm031)  THEN LET l_xmdm031 = 0 END IF
   ##IF cl_null(l_xmdm032)  THEN LET l_xmdm032 = 0 END IF
   ##IF cl_null(l_cnt)      THEN LET l_cnt     = 0 END IF
   #
   #SELECT COALESCE(xmdl018,0),xmdl017,xmdl019,xmdl021,xmdl204
   #  INTO l_xmdl018,l_xmdl017,l_xmdl019,l_xmdl021,l_xmdl204
   #  FROM xmdl_t
   # WHERE xmdlent = g_enterprise
   #   AND xmdldocno = g_xmdl.xmdldocno    
   #   AND xmdlseq = g_xmdl.xmdlseq 
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #
   #IF l_xmdm009 <> l_xmdl018 THEN
   #   LET l_title = ''
   #   CASE p_control
   #      WHEN '2'    LET l_title = cl_getmsg('adb-00390',g_lang)   #出通      
   #      WHEN '1'    LET l_title = cl_getmsg('adb-00391',g_lang)   #出貨      
   #      WHEN '4'    LET l_title = cl_getmsg('adb-00392',g_lang)   #簽收      
   #      #WHEN ''    LET l_title = cl_getmsg('adb-00393',g_lang)   #簽退      
   #      WHEN '6'    LET l_title = cl_getmsg('adb-00394',g_lang)   #銷退
   #   END CASE
   #
   #   LET l_title = cl_getmsg_parm('adb-00389',g_lang,l_title||'|'||l_xmdm009||'|'||l_xmdl018)
   #   IF cl_ask_conf(l_title) THEN
   #      LET l_success = ''
   #      CALL s_aooi250_convert_qty(g_xmdl.xmdl008,l_xmdl017,l_xmdl204,l_xmdl018)
   #         RETURNING l_success,l_xmdl018
   #      IF NOT l_success THEN
   #         LET r_success = FALSE
   #         RETURN r_success         
   #      END IF   
   #      
   #      IF NOT cl_null(l_xmdl019) THEN
   #         LET l_success = ''
   #         CALL s_aooi250_convert_qty(g_xmdl.xmdl008,l_xmdl017,l_xmdl019,l_xmdl018)
   #            RETURNING l_success,l_xmdl020
   #         IF NOT l_success THEN
   #            LET r_success = FALSE
   #            RETURN r_success         
   #         END IF                 
   #      END IF
   #      
   #      IF NOT cl_null(l_xmdl021) THEN
   #         LET l_success = ''
   #         CALL s_aooi250_convert_qty(g_xmdl.xmdl008,l_xmdl017,l_xmdl021,l_xmdl018)
   #            RETURNING l_success,l_xmdl022 
   #         IF NOT l_success THEN
   #            LET r_success = FALSE
   #            RETURN r_success         
   #         END IF                 
   #            #IF NOT cl_null(l_xmdl024) AND NOT cl_null(l_xmdl022) AND NOT cl_null(l_xmdl025) AND                  
   #            #   NOT cl_null(g_xmdk_m.xmdk016) AND NOT cl_null(g_xmdk_m.xmdk017) THEN
   #            #   #稅額計算
   #            #    LET l_money = l_xmdl.xmdl024 * l_xmdl.xmdl022
   #            #    CALL s_tax_ins(g_xmdk_m.xmdkdocno,l_xmdl.xmdlseq,0,g_xmdk_m.xmdksite,l_money,
   #            #                   l_xmdl.xmdl025,l_xmdl.xmdl022,g_xmdk_m.xmdk016,g_xmdk_m.xmdk017,'','','')
   #            #       RETURNING l_xmdl.xmdl027,l_xmdl.xmdl029,l_xmdl.xmdl028,
   #            #                 l_xrcd113,l_xrcd114,l_xrcd115,l_xrcd123,l_xrcd124,
   #            #                 l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135
   #            #END IF
   #      END IF      
   #   
   #      UPDATE xmdl_t
   #         SET xmdl018 = l_xmdm009,
   #             xmdl020 = l_xmdl020,
   #             xmdl022 = l_xmdl022,
   #             xmdl205 = l_xmdl205
   #       WHERE xmdlent = g_enterprise
   #         AND xmdldocno = g_xmdl.xmdldocno    
   #         AND xmdlseq = g_xmdl.xmdlseq 
   #      IF SQLCA.sqlcode THEN
   #         INITIALIZE g_errparam TO NULL
   #         LET g_errparam.code = SQLCA.sqlcode
   #         LET g_errparam.extend = ''
   #         LET g_errparam.popup = TRUE
   #         CALL cl_err()
   #         LET r_success = FALSE
   #         RETURN r_success
   #      END IF            
   #   ELSE
   #      LET r_success = FALSE
   #   END IF
   #END IF
   #benson-mark - e - 
   
   
#製造-數量檢查
#   CASE p_type
#      WHEN '1'  #AFTER FIELD
#         IF NOT cl_null(g_xmdm_d[l_ac].xmdm009) THEN LET l_xmdm009 = l_xmdm009 + g_xmdm_d[l_ac].xmdm009 END IF
#         IF NOT cl_null(g_xmdm_d[l_ac].xmdm011) THEN LET l_xmdm011 = l_xmdm011 + g_xmdm_d[l_ac].xmdm011 END IF
#         IF NOT cl_null(g_xmdm_d[l_ac].xmdm031) THEN LET l_xmdm031 = l_xmdm031 + g_xmdm_d[l_ac].xmdm031 END IF
#         IF NOT cl_null(g_xmdm_d[l_ac].xmdm032) THEN LET l_xmdm032 = l_xmdm032 + g_xmdm_d[l_ac].xmdm032 END IF
#            
#         IF l_xmdm009 > g_xmdl.xmdl018 THEN
#            INITIALIZE g_errparam TO NULL
#            
#            CASE p_control
#               WHEN '6' #銷退單
#                  LET g_errparam.code = 'axm-00392'   #多庫儲批總"銷退數量%1"不可大於項次%2"銷退數量%3"！
#               OTHERWISE #出貨單、出通單
#                  LET g_errparam.code = 'axm-00384'   #多庫儲批總"出貨數量%1"不可大於項次%2"出貨數量%3"！
#            END CASE
#
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm009
#            LET g_errparam.replace[2] = g_xmdl.xmdlseq
#            LET g_errparam.replace[3] = g_xmdl.xmdl018
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#               
#         IF l_xmdm011 > g_xmdl.xmdl020 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00383'   #多庫儲批總"參考數量%1"不可大於項次%2"參考數量%3"！
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm011 
#            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] = g_xmdl.xmdl020
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#
#         IF l_xmdm031 > g_xmdl.xmdl081 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00390'   #多庫儲批總"簽退數量%1"不可大於項次%2"簽退數量%3"！
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm031
#            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] = g_xmdl.xmdl081
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#
#         IF l_xmdm032 > g_xmdl.xmdl082 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00391'   #多庫儲批總"簽退參考數量%1"不可大於項次%2"簽退參考數量%3"！
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm032
#            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] = g_xmdl.xmdl082
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#
#      WHEN '2'  #AFTER INPUT
#         IF l_xmdm009 <> g_xmdl.xmdl018 THEN
#            INITIALIZE g_errparam TO NULL
#            CASE p_control
#               WHEN '6' #銷退單
#                  LET g_errparam.code = 'axm-00393'   #多庫儲批總"銷退數量%1"不可與項次%2"銷退數量%3"不相等！           
#               OTHERWISE #出貨單、出通單
#                  LET g_errparam.code = 'axm-00196'   #多庫儲批總"出貨數量%1"不可與項次%2"出貨數量%3"不相等！
#            END CASE
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm009 
#            LET g_errparam.replace[2] =  g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] =  g_xmdl.xmdl018
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#               
#         IF l_xmdm011 <> g_xmdl.xmdl020 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00232'   #多庫儲批總"參考數量%1"不可與項次%2"參考數量%3"不相等！
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm011 
#            LET g_errparam.replace[2] =  g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] =  g_xmdl.xmdl020
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#
#         IF l_xmdm031 <> g_xmdl.xmdl081 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00243'   #多庫儲批總"簽退數量%1"不可與項次%2"簽退數量%3"不相等！
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm031
#            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] = g_xmdl.xmdl081
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#
#         IF l_xmdm032 <> g_xmdl.xmdl082 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'axm-00244'   #多庫儲批總"簽退參考數量%1"不可與項次%2"簽退參考數量%3"不相等！
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = l_xmdm032
#            LET g_errparam.replace[2] = g_xmdl.xmdlseq 
#            LET g_errparam.replace[3] = g_xmdl.xmdl082
#            CALL cl_err()
#
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
         
#         #若只輸入一筆提示重新輸入
#         IF p_control MATCHES '[12]' THEN  #出貨單、出通單
#            IF l_cnt <= 1 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'axm-00376'   #多庫儲批需輸入兩筆以上有效資料！
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               LET r_success = FALSE
#               RETURN r_success
#            END IF
#         END IF
#   END CASE
        
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adbt540_01_num_chk(p_control)
   DEFINE p_control  LIKE type_t.chr5 
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_num      LIKE type_t.num5
   DEFINE l_enter    LIKE type_t.num5    #輸入的數量
   DEFINE l_total    LIKE type_t.num5    #輸入該庫儲批總數量
   DEFINE l_xmdm009  LIKE xmdm_t.xmdm009 #數量
   DEFINE l_xmdm031  LIKE xmdm_t.xmdm031 #簽退數量
   DEFINE l_xmdm011  LIKE xmdm_t.xmdm011 #參考數量
   DEFINE l_xmdm032  LIKE xmdm_t.xmdm032 #簽退參考數量
   DEFINE l_inaa014  LIKE inaa_t.inaa014 #允許負庫存
   
   LET r_success = TRUE
   LET l_inaa014 = ''
   
   SELECT inaa014 INTO l_inaa014 
     FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaa001 = g_xmdm_d[l_ac].xmdm005
      AND inaasite = (SELECT xmdmsite FROM xmdm_t 
                       WHERE xmdment = g_enterprise AND xmdmdocno = g_xmdm_d[l_ac].xmdmdocno)      
   
   IF (NOT cl_null(g_xmdm_d[l_ac].xmdm009) AND g_xmdm_d[l_ac].xmdm009 <> 0) OR
      (NOT cl_null(g_xmdm_d[l_ac].xmdm031) AND g_xmdm_d[l_ac].xmdm031 <> 0) OR
      (NOT cl_null(g_xmdm_d[l_ac].xmdm011) AND g_xmdm_d[l_ac].xmdm011 <> 0) OR
      (NOT cl_null(g_xmdm_d[l_ac].xmdm032) AND g_xmdm_d[l_ac].xmdm032 <> 0) THEN

      LET l_enter = 0
      IF NOT cl_null(g_xmdm_d[l_ac].xmdm009) THEN LET l_enter = l_enter + g_xmdm_d[l_ac].xmdm009 END IF
      IF NOT cl_null(g_xmdm_d[l_ac].xmdm031) THEN LET l_enter = l_enter + g_xmdm_d[l_ac].xmdm031 END IF

      IF p_control MATCHES '[12]' THEN  #出貨單、出通單
         IF g_booking = 'Y' THEN
            IF l_inaa014 = 'N' AND l_enter > g_xmdm_d[l_ac].ready THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00172'         #出貨量不可大於庫存可出貨量！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF      
      END IF
      
      #檢查是否成本庫與非成本庫混和輸入
      #150305 by lori522612 add---(S)
      #LET l_num = 0
      #LET l_xmdm009 = 0
      #LET l_xmdm031 = 0
      #LET l_xmdm011 = 0
      #LET l_xmdm032 = 0
      #SELECT SUM(xmdm009),SUM(xmdm031),SUM(xmdm011),SUM(xmdm032)
      #  INTO l_xmdm009,l_xmdm031,l_xmdm011,l_xmdm032
      #  FROM adbt540_01_temp
      # WHERE xmdment = g_enterprise
      #   AND xmdmdocno = g_xmdl.xmdldocno
      #   AND xmdmseq = g_xmdl.xmdlseq
      #   AND cost <> g_xmdm_d[l_ac].cost
      #   AND xmdmseq1 <> g_xmdm_d_t.xmdmseq1
      #
      #IF NOT cl_null(l_xmdm009) THEN LET l_num = l_num + l_xmdm009 END IF
      #IF NOT cl_null(l_xmdm031) THEN LET l_num = l_num + l_xmdm031 END IF
      #IF NOT cl_null(l_xmdm011) THEN LET l_num = l_num + l_xmdm011 END IF
      #IF NOT cl_null(l_xmdm032) THEN LET l_num = l_num + l_xmdm032 END IF
      #
      #IF NOT cl_null(l_num) AND l_num > 0 THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = 'axm-00375'
      #   LET g_errparam.extend = ''
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #
      #   LET r_success = FALSE
      #   RETURN r_success
      #END IF
      
      IF NOT adbt540_01_subinv_cost_chk() THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #150305 by lori522612 add---(E)
      
      ##總數量與項次檢查      
      #IF NOT adbt540_01_sum_chk(p_control,'1') THEN
      #   LET r_success = FALSE
      #   RETURN r_success
      #END IF
      
      #檢查是否超過前張單據可輸入值
      IF NOT cl_null(g_xmdl.xmdl001) AND NOT cl_null(g_xmdl.xmdl002) THEN
         #計算庫儲批排除該項序總數
         LET l_total = 0
         LET l_num = 0
         LET l_xmdm009 = 0
         LET l_xmdm031 = 0      
         SELECT SUM(xmdm009),SUM(xmdm031) INTO l_xmdm009,l_xmdm031
           FROM adbt540_01_temp
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
               CALL adbt540_get_max_ship_qty(g_xmdl.xmdldocno,g_xmdl.xmdlseq,
                                             g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,
                                             g_xmdl.xmdl001,g_xmdl.xmdl002) RETURNING l_num
               IF l_total > l_num THEN
                  INITIALIZE g_errparam TO NULL
                  #LET g_errparam.code = 'axm-00189'   #160720-00002#1 20160725 mark by beckxie
                  LET g_errparam.code = 'adb-00442'   #160720-00002#1 20160725 add by beckxie
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success
               END IF
               
            WHEN '6'  #銷退單
               CALL s_adbt600_return_max1(g_xmdl.xmdldocno,g_xmdl.xmdlseq,
                                          g_xmdm_d[l_ac].xmdm007,
                                          g_xmdl.xmdl001,g_xmdl.xmdl002) RETURNING l_num
               
               IF l_total > l_num THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00385'
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

PRIVATE FUNCTION adbt540_get_max_ship_qty(p_xmdmdocno,p_xmdmseq,p_xmdm005,p_xmdm006,p_xmdm007,p_xmdl001,p_xmdl002)
   DEFINE p_xmdmdocno      LIKE xmdm_t.xmdmdocno
   DEFINE p_xmdmseq        LIKE xmdm_t.xmdmseq
   DEFINE p_xmdm005        LIKE xmdm_t.xmdm005   
   DEFINE p_xmdm006        LIKE xmdm_t.xmdm006
   DEFINE p_xmdm007        LIKE xmdm_t.xmdm007   
   DEFINE p_xmdl001        LIKE xmdl_t.xmdl001
   DEFINE p_xmdl002        LIKE xmdl_t.xmdl002      

   DEFINE r_max_qty        LIKE xmdl_t.xmdl205     #可出貨的出貨數量
   DEFINE l_unship_qty     LIKE xmdl_t.xmdl018     #出通單數量-已出貨數量
   DEFINE l_uncof_qty      LIKE xmdl_t.xmdl018     #未確認出貨單的出貨數量
   DEFINE l_sql1           STRING
   DEFINE l_sql2           STRING

   WHENEVER ERROR CONTINUE

   LET r_max_qty = NULL
   LET l_unship_qty = NULL
   LET l_uncof_qty = NULL
   LET l_sql1 = NULL
   LET l_sql2 = NULL

   IF cl_null(p_xmdl001) OR cl_null(p_xmdl002) THEN   #無來源不比較
       RETURN r_max_qty
   END IF

   LET l_sql1 = "SELECT SUM(COALESCE(xmdm009,0)) FROM xmdk_t,xmdl_t,xmdm_t",
                " WHERE xmdkent = xmdlent AND xmdlent = xmdment AND xmdment = ",g_enterprise,
                "   AND xmdkdocno = xmdldocno AND xmdldocno = xmdmdocno",
                "   AND xmdlseq = xmdmseq",
                "   AND xmdk000 = '1'",         #出貨單
                "   AND xmdl001 = '",p_xmdl001,"'",
                "   AND xmdl002 = '",p_xmdl002,"'",
                "   AND xmdm005 = '",p_xmdm005,"'",
                "   AND xmdm006 = '",p_xmdm006,"'",
                "   AND xmdm007 = '",p_xmdm007,"'",
                "   AND xmdkstus NOT IN ('X','Y','S')"
                
   IF NOT cl_null(p_xmdmdocno) THEN
      LET l_sql1 = l_sql1," AND (xmdmdocno <> '",p_xmdmdocno,"'"

      IF NOT cl_null(p_xmdmseq) THEN
         LET l_sql1 = l_sql1," OR xmdmseq <> '",p_xmdmseq,"'"
      END IF
      
      LET l_sql1 = l_sql1,")"
   END IF
   


   #來源為出通單時，可出貨數量 = xmdi009出通數量-xmdi012已轉出貨數量-SUM(xmdm009)出貨單未確認的數量 
   LET l_sql2 = "SELECT COALESCE(xmdi009,0)-COALESCE(xmdi012,0) ",
                      "  FROM xmdi_t ",
                      " WHERE xmdient = ",g_enterprise,
                      "   AND xmdidocno = '",p_xmdl001,"'",
                      "   AND xmdiseq = '",p_xmdl002,"'",
                      "   AND xmdi005 = '",p_xmdm005,"'",
                      "   AND xmdi006 = '",p_xmdm006,"'",
                      "   AND xmdi007 = '",p_xmdm007,"'"
   PREPARE s_adbt540_uncof_qty1 FROM l_sql1
   EXECUTE s_adbt540_uncof_qty1 INTO l_uncof_qty
   IF cl_null(l_uncof_qty) THEN
      LET l_uncof_qty = 0
   END IF

   PREPARE s_adbt540_unship_qty1 FROM l_sql2
   EXECUTE s_adbt540_unship_qty1 INTO l_unship_qty
   IF cl_null(l_unship_qty) THEN
      LET l_unship_qty = 0
   END IF

   LET r_max_qty = l_unship_qty - l_uncof_qty

   RETURN r_max_qty
END FUNCTION

PRIVATE FUNCTION adbt540_01_warehouse_cost()
   DEFINE r_type   LIKE type_t.chr1
   DEFINE l_xmdm005    LIKE xmdm_t.xmdm005
   DEFINE l_xmdm006    LIKE xmdm_t.xmdm006
   DEFINE l_xmdm007    LIKE xmdm_t.xmdm007 
   DEFINE l_xmdm033    LIKE xmdm_t.xmdm033   
            
   LET l_xmdm005 = ''
   LET l_xmdm006 = ''
   LET l_xmdm007 = ''
   LET l_xmdm033 = ''
   

   #取來源庫位
   DECLARE adbt540_01_cost_cs SCROLL CURSOR FOR
    SELECT xmdm005,xmdm006,xmdm007,xmdm033
      FROM xmdm_t
     WHERE xmdment = g_enterprise
       AND xmdmdocno = g_xmdl.xmdl001
       AND xmdmseq = g_xmdl.xmdl002
     ORDER BY xmdmseq1
             
   OPEN adbt540_01_cost_cs
   FETCH FIRST adbt540_01_cost_cs INTO l_xmdm005,l_xmdm006,l_xmdm007,l_xmdm033

   #成本庫否
   CALL s_adb_get_inaa010(g_xmdl.xmdlsite,l_xmdm005) RETURNING r_type#150302-00004#14 150305 by lori522612 mod
   
   RETURN r_type
END FUNCTION

################################################################################
# Descriptions...: 多庫儲批資料修改及新增
# Memo...........:
# Usage..........: CALL adbt540_01_xmdm_modify(p_control,p_xmdmseq,p_xmdksite,p_xmdkdocno,p_xmdlseq,
#                                              p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,
#                                              p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,p_xmdl081,
#                                              p_xmdl082,p_xmdl052)
#                  RETURNING r_success
# Input parameter: p_control       #呼叫此子程式之程式 1.adbt540或adbt541  出貨單
#                                                     2.adbt520          出通單
#                                                     4.adbt580          簽收單(wait)
#                                                     5.adbt590          簽退單(wait)
#                                                     6.adbt600          銷退單
#                : p_xmdmseq    #項次(項次舊值)
#                : p_xmdksite   #營運據點
#                : p_xmdkdocno  #單據單號
#                : p_xmdlseq    #項次(項次新值)
#                : p_xmdl008    #料件編號
#                : p_xmdl009    #產品特徵
#                : p_xmdl011    #作業編號
#                : p_xmdl012    #製程序
#                : p_xmdl014    #庫位
#                : p_xmdl015    #儲位
#                : p_xmdl016    #批號
#                : p_xmdl017    #出貨單位
#                : p_xmdl018    #數量
#                : p_xmdl019    #參考單位
#                : p_xmdl020    #參考數量
#                : p_xmdl081    #簽退數量
#                : p_xmdl082    #簽退參考數量
#                : p_xmdl052    #庫存管理特徵
# Return code....: r_success    #執行結果
# Date & Author..: 日期 By 作者
# Modify.........: 2015/03/19 By Lori 150310-00005#3 傳入參數新增庫存管理特徵
################################################################################
PUBLIC FUNCTION adbt540_01_xmdm_modify(p_control,p_xmdmseq,p_xmdksite,p_xmdkdocno,p_xmdlseq,p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,p_xmdl081,p_xmdl082,p_xmdl052)
   DEFINE p_control     LIKE type_t.chr5     
   DEFINE p_xmdmseq     LIKE xmdm_t.xmdmseq
   DEFINE p_xmdksite    LIKE xmdk_t.xmdksite
   DEFINE p_xmdkdocno   LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdlseq     LIKE xmdl_t.xmdlseq      
   DEFINE p_xmdl008     LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009     LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011     LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012     LIKE xmdl_t.xmdl012
   DEFINE p_xmdl014     LIKE xmdl_t.xmdl014
   DEFINE p_xmdl015     LIKE xmdl_t.xmdl015
   DEFINE p_xmdl016     LIKE xmdl_t.xmdl016
   DEFINE p_xmdl017     LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018     LIKE xmdl_t.xmdl018
   DEFINE p_xmdl019     LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020     LIKE xmdl_t.xmdl020 
   DEFINE p_xmdl081     LIKE xmdl_t.xmdl081
   DEFINE p_xmdl082     LIKE xmdl_t.xmdl082
   DEFINE p_xmdl052     LIKE xmdl_t.xmdl052   #150310-00005#3 150319 by lori522612 add 庫存管理特徵

   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(p_xmdkdocno) AND NOT cl_null(p_xmdmseq) THEN
      #檢查有無多庫儲批資料
      LET l_n = 0      
      CASE p_control
         WHEN '2' #出通單
            SELECT COUNT(xmdiseq1) INTO l_n
              FROM xmdi_t
             WHERE xmdient = g_enterprise
               AND xmdidocno = p_xmdkdocno
               AND xmdiseq = p_xmdmseq         
         
         OTHERWISE #出貨單、簽收單、簽退單、銷退單
            SELECT COUNT(xmdmseq1) INTO l_n
              FROM xmdm_t
             WHERE xmdment = g_enterprise
               AND xmdmdocno = p_xmdkdocno
               AND xmdmseq = p_xmdmseq
               
      END CASE
      
      CASE l_n
         WHEN 0   #無多庫儲批資料，新增一筆                                     
            CALL adbt540_01_xmdm_insert(p_control,p_xmdksite,p_xmdkdocno,p_xmdlseq,                                        
                                        p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,
                                        p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
                                        p_xmdl081,p_xmdl082,p_xmdl052) RETURNING r_success         #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdl052)      
            IF NOT r_success THEN
               RETURN r_success
            END IF
                                    
         WHEN 1   #已有資料，但非多庫儲批出貨
            CASE p_control
               WHEN '2' #出通單
                  UPDATE xmdi_t
                     SET xmdiseq = p_xmdlseq,  #項次
                         xmdi001 = p_xmdl008,  #料件編號
                         xmdi002 = p_xmdl009,  #產品特徵
                         xmdi003 = p_xmdl011,  #作業編號
                         xmdi004 = p_xmdl012,  #製程序                   
                         xmdi005 = p_xmdl014,  #庫位
                         xmdi006 = p_xmdl015,  #儲位
                         xmdi007 = p_xmdl016,  #批號
                         xmdi008 = p_xmdl017,  #單位
                         xmdi009 = p_xmdl018,  #出貨數量
                         xmdi010 = p_xmdl019,  #參考單位
                         xmdi011 = p_xmdl020,  #參考數量
                         xmdi013 = p_xmdl052   #150310-00005#3 150319 by lori522612 add 庫存管理特徵
                   WHERE xmdient = g_enterprise
                     AND xmdidocno = p_xmdkdocno
                     AND xmdiseq = p_xmdmseq
                 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdi_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF
                  
               OTHERWISE #出貨單、簽收單、簽退單、銷退單
                  UPDATE xmdm_t
                     SET xmdmseq = p_xmdlseq,  #項次
                         xmdm001 = p_xmdl008,  #料件編號
                         xmdm002 = p_xmdl009,  #產品特徵
                         xmdm003 = p_xmdl011,  #作業編號
                         xmdm004 = p_xmdl012,  #製程序                   
                         xmdm005 = p_xmdl014,  #庫位
                         xmdm006 = p_xmdl015,  #儲位
                         xmdm007 = p_xmdl016,  #批號
                         xmdm008 = p_xmdl017,  #單位
                         xmdm009 = p_xmdl018,  #出貨數量
                         xmdm010 = p_xmdl019,  #參考單位
                         xmdm011 = p_xmdl020,  #參考數量 
                         xmdm031 = p_xmdl081,  #簽退數量
                         xmdm032 = p_xmdl082,  #簽退參考數量
                         xmdm033 = p_xmdl052   #150310-00005#3 150319 by lori522612 add 庫存管理特徵
                   WHERE xmdment = g_enterprise
                     AND xmdmdocno = p_xmdkdocno
                     AND xmdmseq = p_xmdmseq
                 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdm_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF
            END CASE

         OTHERWISE  #已有資料，且為多庫儲批出貨
            CASE p_control
               WHEN '2' #出通單
                  UPDATE xmdi_t
                     SET xmdiseq = p_xmdlseq,  #項次
                         xmdi003 = p_xmdl011,  #作業編號
                         xmdi004 = p_xmdl012   #製程序
                   WHERE xmdient = g_enterprise
                     AND xmdidocno = p_xmdkdocno
                     AND xmdiseq = p_xmdmseq
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdi_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
              
                     LET r_success = FALSE
                     RETURN r_success            
                  END IF 
                  
               OTHERWISE #出貨單、簽收單、簽退單、銷退單
                  UPDATE xmdm_t
                     SET xmdmseq = p_xmdlseq,  #項次
                         xmdm003 = p_xmdl011,  #作業編號
                         xmdm004 = p_xmdl012   #製程序
                   WHERE xmdment = g_enterprise
                     AND xmdmdocno = p_xmdkdocno
                     AND xmdmseq = p_xmdmseq     
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdm_t"
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
# Usage..........: CALL adbt540_01_xmdm_insert(p_control,p_xmdksite,p_xmdkdocno,p_xmdlseq,
#                                              p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,
#                                              p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
#                                              p_xmdl081,p_xmdl082,p_xmdl052)
#                  RETURNING r_success
# Input parameter: p_control       #呼叫此子程式之程式 1.adbt540或adbt541  出貨單
#                                                     2.adbt520          出通單
#                                                     4.adbt580          簽收單(wait)
#                                                     5.adbt590          簽退單(wait)
#                                                     6.adbt600          銷退單 
#                : p_xmdksite   #營運據點
#                : p_xmdkdocno  #單據單號
#                : p_xmdlseq    #項次
#                : p_xmdl008    #料件編號
#                : p_xmdl009    #產品特徵
#                : p_xmdl011    #作業編號
#                : p_xmdl012    #製程序
#                : p_xmdl014    #庫位
#                : p_xmdl015    #儲位
#                : p_xmdl016    #批號
#                : p_xmdl017    #出貨單位
#                : p_xmdl018    #數量
#                : p_xmdl019    #參考單位
#                : p_xmdl020    #參考數量
#                : p_xmdl081    #簽退數量
#                : p_xmdl082    #簽退參考數量
#                : p_xmdl052    #庫存管理特徵
# Date & Author..: 日期 By 作者
# Modify.........: 2015/03/19 By Lori 150310-00005#3 傳入參數新增庫存管理特徵
################################################################################
PRIVATE FUNCTION adbt540_01_xmdm_insert(p_control,p_xmdksite,p_xmdkdocno,p_xmdlseq,p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,p_xmdl014,p_xmdl015,p_xmdl016,p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,p_xmdl081,p_xmdl082,p_xmdl052)
   DEFINE p_control   LIKE type_t.chr5
   DEFINE p_xmdksite  LIKE xmdk_t.xmdksite
   DEFINE p_xmdkdocno LIKE xmdk_t.xmdkdocno   
   DEFINE p_xmdlseq   LIKE xmdl_t.xmdlseq
   DEFINE p_xmdl008   LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009   LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011   LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012   LIKE xmdl_t.xmdl012
   DEFINE p_xmdl014   LIKE xmdl_t.xmdl014
   DEFINE p_xmdl015   LIKE xmdl_t.xmdl015
   DEFINE p_xmdl016   LIKE xmdl_t.xmdl016
   DEFINE p_xmdl017   LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018   LIKE xmdl_t.xmdl018
   DEFINE p_xmdl019   LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020   LIKE xmdl_t.xmdl020   
   DEFINE p_xmdl081   LIKE xmdl_t.xmdl081
   DEFINE p_xmdl082   LIKE xmdl_t.xmdl082
   DEFINE p_xmdl052   LIKE xmdl_t.xmdl052   #150310-00005#3 150319 by lori522612 add 庫存管理特徵
   
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE

   CASE p_control
      WHEN '1'  #出貨單
         INSERT INTO xmdm_t(xmdment,xmdmsite,xmdmdocno,
                            xmdmseq,xmdmseq1,
                            xmdm001,xmdm002,xmdm003,xmdm004,
                            xmdm005,xmdm006,xmdm007,
                            xmdm008,xmdm009,xmdm010,xmdm011,
                            xmdm012,xmdm013,xmdm014,xmdm033)   #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdm033)
              VALUES (g_enterprise,p_xmdksite,p_xmdkdocno,
                      p_xmdlseq,1,
                      p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,
                      p_xmdl014,p_xmdl015,p_xmdl016,
                      p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
                      0,0,0,p_xmdl052)                         #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdl052)

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "xmdm_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            RETURN r_success            
         END IF

      WHEN '2'  #出通單
         INSERT INTO xmdi_t(xmdient,xmdisite,xmdidocno,
                            xmdiseq,xmdiseq1,
                            xmdi001,xmdi002,xmdi003,xmdi004,
                            xmdi005,xmdi006,xmdi007,
                            xmdi008,xmdi009,xmdi010,xmdi011,
                            xmdi012,xmdi013)                     #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdi013)
              VALUES (g_enterprise,p_xmdksite,p_xmdkdocno,
                      p_xmdlseq,1,
                      p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,
                      p_xmdl014,p_xmdl015,p_xmdl016,
                      p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
                      0,p_xmdl052)                               #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdl052)

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "xmdi_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            RETURN r_success            
         END IF

      OTHERWISE #簽收單、簽退單、銷退單
         INSERT INTO xmdm_t(xmdment,xmdmsite,xmdmdocno,
                            xmdmseq,xmdmseq1,
                            xmdm001,xmdm002,xmdm003,xmdm004,
                            xmdm005,xmdm006,xmdm007,
                            xmdm008,xmdm009,xmdm010,xmdm011,
                            xmdm031,xmdm032,xmdm033)            #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdm033)
              VALUES (g_enterprise,p_xmdksite,p_xmdkdocno,
                      p_xmdlseq,1,
                      p_xmdl008,p_xmdl009,p_xmdl011,p_xmdl012,
                      p_xmdl014,p_xmdl015,p_xmdl016,
                      p_xmdl017,p_xmdl018,p_xmdl019,p_xmdl020,
                      p_xmdl081,p_xmdl082,p_xmdl052)            #150310-00005#3 150319 by lori522612 add 庫存管理特徵(xmdl052)
                      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "xmdm_t"
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
# Usage..........: CALL adbt540_01_xmdm_delete(p_control,p_xmdkdocno,p_xmdlseq,p_pop)
#                  RETURNING r_success
# Input parameter: p_control       #呼叫此子程式之程式 1.adbt540或adbt541  出貨單
#                                                     2.adbt520          出通單
#                                                     4.adbt580          簽收單(wait)
#                                                     5.adbt590          簽退單(wait)
#                                                     6.adbt600          銷退單 
#                : p_xmdkdocno 單據單號
#                : p_xmdlseq   項次
#                : p_pop       是否彈出視窗詢問Y,N
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt540_01_xmdm_delete(p_control,p_xmdkdocno,p_xmdlseq,p_pop)
   DEFINE p_control     LIKE type_t.chr5
   DEFINE p_xmdkdocno   LIKE xmdk_t.xmdkdocno
   DEFINE p_xmdlseq     LIKE xmdl_t.xmdlseq
   DEFINE p_pop         LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   
   LET r_success = TRUE

   IF NOT cl_null(p_xmdlseq) AND
      NOT cl_null(p_xmdkdocno) THEN
   
      #檢查有無多庫儲批資料
#      LET l_n = 0      
#      CASE p_control
#         WHEN '2'  #出通單
#            SELECT COUNT(xmdiseq1) INTO l_n
#              FROM xmdi_t
#             WHERE xmdient = g_enterprise
#               AND xmdidocno = p_xmdkdocno
#               AND xmdiseq = p_xmdlseq
#               
#         OTHERWISE #出貨單、簽收單、簽退單、銷退單
#            SELECT COUNT(xmdmseq1) INTO l_n
#              FROM xmdm_t
#             WHERE xmdment = g_enterprise
#               AND xmdmdocno = p_xmdkdocno
#               AND xmdmseq = p_xmdlseq
#               
#      END CASE
      

      #詢問是否刪除多庫儲批
#      IF p_pop = 'Y' AND l_n > 1 THEN
       IF p_pop = 'Y' THEN
         IF NOT cl_ask_confirm('adb-00415') THEN   #是否取消多庫儲批出貨，且刪除對應的多庫儲批出貨明細檔？
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      CASE p_control
         WHEN '2'  #出通單         
            DELETE FROM xmdi_t
             WHERE xmdient = g_enterprise
               AND xmdidocno = p_xmdkdocno
               AND xmdiseq = p_xmdlseq
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdi_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
        
               LET r_success = FALSE
               RETURN r_success
            END IF
            
         OTHERWISE #出貨單、簽收單、簽退單、銷退單
            DELETE FROM xmdm_t
             WHERE xmdment = g_enterprise
               AND xmdmdocno = p_xmdkdocno
               AND xmdmseq = p_xmdlseq
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdm_t"
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
# Descriptions...: 設定視窗Title
# Memo...........:
# Usage..........: CALL adbt540_01_set_win_title(p_control)
# Date & Author..: 2014/10/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt540_01_set_win_title(p_control)
   DEFINE p_control       LIKE type_t.chr5
   DEFINE l_title   STRING

   CASE p_control
      WHEN '1'    LET l_title = 'adb-00373'   #多庫儲批出貨維護 
      WHEN '2'    LET l_title = 'adb-00372'   #多庫儲批出通維護       
      WHEN '4'    LET l_title = 'adb-00374'   #多庫儲批簽收維護      
      WHEN '5'    LET l_title = 'adb-00375'   #多庫儲批簽退維護      
      WHEN '6'    LET l_title = 'adb-00376'   #多庫儲批銷退維護
   END CASE
   
   LET l_title = cl_getmsg(l_title,g_lang)    
   LET g_win_curr = ui.Window.getCurrent()
   CALL g_win_curr.setText(l_title)
END FUNCTION
################################################################################
# Descriptions...: 多庫儲批總數量確認
# Memo...........: 當包裝數量有變動,且該項次為多庫儲批時,需檢查多庫儲批當下的總數量是否相符
# Usage..........: CALL adbt540_01_mutil_subinv_chk(p_control,p_docno,p_seq)
#                  RETURNING r_success
# Input parameter: p_control   處理流程
#                  p_docno     單據編號
#                  p_seq       單據項次
# Return code....: r_success   檢查結果, TRUE:數量相符, FALSE:數量不相符
# Date & Author..: 2014/11/03 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt540_01_mutil_subinv_chk(p_control,p_docno,p_seq)
   DEFINE p_control       LIKE type_t.chr5
   DEFINE p_docno         LIKE xmdk_t.xmdkdocno
   DEFINE p_seq           LIKE xmdl_t.xmdlseq
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_ship_qty      LIKE xmdl_t.xmdl018
   DEFINE l_amount        LIKE xmdl_t.xmdl018
   
   LET r_success = TRUE
   LET l_ship_qty = 0
   LET l_amount = 0 
   
   SELECT xmdl018 INTO l_ship_qty
     FROM xmdl_t
    WHERE xmdlent = g_enterprise
      AND xmdldocno = p_docno
      AND xmdlseq = p_seq      
   
   CASE 
      WHEN p_control MATCHES "[146]"
         SELECT SUM(COALESCE(xmdm009,0)) INTO l_amount
           FROM xmdm_t
          WHERE xmdent = g_enterprise
            AND xmdmdocno = p_docno
            AND xmdmseq = p_seq      
   END CASE
   
   IF l_ship_qty <> l_amount THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 庫、儲、批、庫存管理特徵，輸入開窗
# Memo...........:
# Usage..........: CALL adbt540_01_xmdm005_xmdm006_xmdm007_xmdm033_qry(p_type)
# Input parameter: p_type 1.庫位2.儲位3.批號4.庫存管理特徵
#                : 
# Return code....: 
#                : 
# Date & Author..: 140915 By earl
# Modify.........: 141201 By benson
#                  150305 By Lori    出通單/出貨單/銷退單 庫位開窗使用 v_inaa001_16
################################################################################
PRIVATE FUNCTION adbt540_01_xmdm005_xmdm006_xmdm007_xmdm033_qry(p_type,p_control)
   DEFINE p_type            LIKE type_t.chr1   
   DEFINE p_control         LIKE type_t.chr1
   DEFINE l_type            LIKE type_t.chr1
   DEFINE l_where           STRING
   
   #150305 by lori522612 mark 來源有做多庫儲批,則不可更改---(S)
   ##出通單若有做多庫儲批，輸入儲位必須存在
   #IF g_xmdl013 = 'Y' THEN         
   #   #開窗i段
   #   INITIALIZE g_qryparam.* TO NULL
   #   LET g_qryparam.state = 'i'
   #   LET g_qryparam.reqry = FALSE
   # 
   #   LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005             #給予default值
   #   LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006
   #   LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007
   #   LET g_qryparam.default4 = g_xmdm_d[l_ac].xmdm033
   #     
   #   #給予arg
   #   LET g_qryparam.arg1 = g_xmdl.xmdl001
   #   LET g_qryparam.arg2 = g_xmdl.xmdl002
   #   LET l_where = s_adbi260_sql_where(g_xmdl.xmdlsite,'xmdi005',g_xmdl.xmdl008,g_xmdl.xmdl200,
   #                                     g_xmdl.xmdl225,g_xmdl.xmdl224,g_xmdl.xmdl223,g_xmdl.xmdl222)
   #   IF (p_control = '1' OR p_control = '2' OR p_control = '6') AND NOT cl_null(l_where) THEN
   #      LET g_qryparam.where = l_where
   #   END IF
   #   
   #   CALL q_xmdi005()                                #呼叫開窗
   # 
   #   LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1              #將開窗取得的值回傳到變數
   #   LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2
   #   LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3
   #   LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return4
   # 
   #   DISPLAY g_xmdm_d[l_ac].xmdm005 TO xmdm005              #顯示到畫面上
   #   DISPLAY g_xmdm_d[l_ac].xmdm006 TO xmdm006
   #   DISPLAY g_xmdm_d[l_ac].xmdm007 TO xmdm007
   #   DISPLAY g_xmdm_d[l_ac].xmdm033 TO xmdm033
   #
   #   CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
   #   CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
   #   
   #ELSE
   #150305 by lori522612 mark 來源有做多庫儲批,則不可更改---(E)
   
      #開窗i段
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
      LET g_qryparam.reqry = FALSE
      
      CASE p_type
         WHEN '1' #庫位
            #150305 by lori522612 add 庫位開窗須符合adbi260設定---(S)
            #LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005    
            ##得出來源成本庫否
            #LET l_type = ''
            #CALL adbt540_01_warehouse_cost(g_xmdl.xmdl001,g_xmdl.xmdl002)
            #RETURNING l_type
            #
            ##串上成本庫否
            #IF NOT cl_null(l_type) THEN
            #   LET g_qryparam.where = "inaa010 = '",l_type,"'"
            #END IF
            #
            #LET l_where = s_adbi260_sql_where(g_xmdl.xmdlsite,'inaa001',g_xmdl.xmdl008,g_xmdl.xmdl200,
            #                                  g_xmdl.xmdl225,g_xmdl.xmdl224,g_xmdl.xmdl223,g_xmdl.xmdl222)
            #IF (p_control = '1' OR p_control = '2' OR p_control = '6') AND NOT cl_null(l_where) THEN
            #   IF cl_null(g_qryparam.where) THEN
            #      LET g_qryparam.where = l_where
            #   ELSE
            #      LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",l_where
            #   END IF
            #END IF
            #
            #CALL q_inaa001_2() 
            
            #150324-00007#6 150410 by lori522612 mark---(S)
            #LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005            
            #LET g_qryparam.arg1 = g_xmdl.xmdl008
            #LET g_qryparam.arg2 = g_xmdl.xmdl200
            #LET g_qryparam.arg3 = g_xmdl.xmdl225
            #LET g_qryparam.arg4 = g_xmdl.xmdl224
            #LET g_qryparam.arg5 = g_xmdl.xmdl223
            #LET g_qryparam.arg6 = g_xmdl.xmdl222
            #LET g_qryparam.arg7 = g_xmdl.xmdlsite
            #
            #CALL q_inaa001_24() 
            #LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1             
            #DISPLAY g_xmdm_d[l_ac].xmdm005 TO xmdm005                                           
            ##150305 by lori522612 add 庫位開窗須符合adbi260設定---(E)
            #150324-00007#6 150410 by lori522612 mark---(E) 
            
            #150324-00007#6 150410 by lori522612 add---(S) 
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005
            LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006
            LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007
            LET g_qryparam.default4 = g_xmdm_d[l_ac].xmdm033
            
            IF cl_null(g_xmdm_d[l_ac].xmdm006) THEN
               LET g_xmdm_d[l_ac].xmdm006 = ''
            END IF
            
            IF cl_null(g_xmdm_d[l_ac].xmdm007) THEN
               LET g_xmdm_d[l_ac].xmdm007 = ''
            END IF
            
            IF cl_null(g_xmdm_d[l_ac].xmdm033) THEN
               LET g_xmdm_d[l_ac].xmdm033 = ''
            END IF
            
            LET g_qryparam.arg1 = g_xmdl.xmdlsite
            LET g_qryparam.arg2 = g_xmdl.xmdl008
            LET g_qryparam.arg3 = g_xmdl.xmdl009
            LET g_qryparam.arg4 = g_xmdm_d[l_ac].xmdm033
            LET g_qryparam.arg5 = ''
            LET g_qryparam.arg6 = g_xmdm_d[l_ac].xmdm006
            LET g_qryparam.arg7 = g_xmdm_d[l_ac].xmdm007
            
            #160826-00007#1 160831 by lori add---(S)
            IF NOT cl_null(g_xmdk201) THEN
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM dbag_t WHERE dbagent = inagent ",
                                      "           AND dbagsite = inagsite AND dbag001 = '1' ",
                                      "           AND dbag002 = '",g_xmdk201,"' ",
                                      "           AND (dbag004 = inag004 OR dbag006 = inag004)) "
            END IF
            #160826-00007#1 160831 by lori add---(E)
            
            CALL q_inag004_18()
            
            LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1  
            LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2
            LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3
            LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return4              
            #150324-00007#6 150410 by lori522612 add---(E) 
            
            CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc   #150324-00007#6 150410 by lori522612 add
            
         WHEN '2' #儲位
            #150324-00007#6 150410 by lori522612 mark---(E) 
            #LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm006 
            #LET g_qryparam.arg1 = g_xmdm_d[l_ac].xmdm005
            #
            #CALL q_inab002_5()            
            #LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return1       
            #DISPLAY g_xmdm_d[l_ac].xmdm006 TO xmdm006
            #
            #CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc
            #150324-00007#6 150410 by lori522612 mark---(E) 
            
            #150324-00007#6 150410 by lori522612 add---(S) 
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005
            LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006
            LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007
            LET g_qryparam.default4 = g_xmdm_d[l_ac].xmdm033
            
            IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN
               LET g_xmdm_d[l_ac].xmdm005 = ''
            END IF
            
            IF cl_null(g_xmdm_d[l_ac].xmdm007) THEN
               LET g_xmdm_d[l_ac].xmdm007 = ''
            END IF
            
            IF cl_null(g_xmdm_d[l_ac].xmdm033) THEN
               LET g_xmdm_d[l_ac].xmdm033 = ''
            END IF
            
            LET g_qryparam.arg1 = g_xmdl.xmdlsite
            LET g_qryparam.arg2 = g_xmdl.xmdl008
            LET g_qryparam.arg3 = g_xmdl.xmdl009
            LET g_qryparam.arg4 = g_xmdm_d[l_ac].xmdm033
            LET g_qryparam.arg5 = g_xmdm_d[l_ac].xmdm005
            LET g_qryparam.arg6 = ''
            LET g_qryparam.arg7 = g_xmdm_d[l_ac].xmdm007
            
            #160826-00007#1 160831 by lori add---(S)
            IF NOT cl_null(g_xmdk201) THEN
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM dbag_t WHERE dbagent = inagent ",
                                      "           AND dbagsite = inagsite AND dbag001 = '1' ",
                                      "           AND dbag002 = '",g_xmdk201,"' ",
                                      "           AND (dbag004 = inag004 OR dbag006 = inag004)) "
            END IF
            #160826-00007#1 160831 by lori add---(E)
            
            CALL q_inag004_18()
            
            LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1  
            LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return2
            LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return3
            LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return4              
            
            CALL s_desc_get_stock_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005) RETURNING g_xmdm_d[l_ac].xmdm005_desc
            CALL s_desc_get_locator_desc(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006) RETURNING g_xmdm_d[l_ac].xmdm006_desc   #150324-00007#6 150410 by lori522612 add
            
            #150324-00007#6 150410 by lori522612 add---(E) 
            
            
         WHEN '3' #批號
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005
            LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006
            LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007
            LET g_qryparam.default4 = g_xmdm_d[l_ac].xmdm033 
            LET g_qryparam.arg1 = g_xmdl.xmdlsite
            LET g_qryparam.arg2 = g_xmdm_d[l_ac].xmdm001
            LET g_qryparam.arg3 = g_xmdm_d[l_ac].xmdm002
            
            CALL q_inad003()      
            LET g_xmdm_d[l_ac].xmdm007 = g_qryparam.return1            
            DISPLAY g_xmdm_d[l_ac].xmdm007 TO xmdm007            
         
         WHEN '4' #庫存管理特徵
            LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005
            LET g_qryparam.default2 = g_xmdm_d[l_ac].xmdm006
            LET g_qryparam.default3 = g_xmdm_d[l_ac].xmdm007
            LET g_qryparam.default4 = g_xmdm_d[l_ac].xmdm033           
            LET g_qryparam.arg1 = g_xmdl.xmdlsite

            CALL q_xmdm033()
            LET g_xmdm_d[l_ac].xmdm033 = g_qryparam.return1          
            DISPLAY g_xmdm_d[l_ac].xmdm033 TO xmdm033

      END CASE

   #END IF #150305 by lori522612 mark 來源有做多庫儲批,則不可更改
END FUNCTION

################################################################################
# Descriptions...: 判斷多庫儲批資料,庫位是否一致為成本庫或非成本庫
# Memo...........: 
# Usage..........: CALL adbt540_01_subinv_cost_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/03/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt540_01_subinv_cost_chk()
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_cost_flag   LIKE inaa_t.inaa010
   DEFINE l_cost_flag2  LIKE inaa_t.inaa010
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE   
   
   #已維護的多儲批的庫位,成本庫否
   LET l_cost_flag = ''
   
   SELECT UNIQUE cost 
     INTO l_cost_flag
     FROM adbt540_01_temp
    WHERE xmdment = g_enterprise
      AND xmdmdocno = g_xmdl.xmdldocno
      AND xmdmseq = g_xmdl.xmdlseq
      AND xmdmseq1 <> g_xmdm_d_t.xmdmseq1
      AND xmdm009 > 0

   IF NOT cl_null(l_cost_flag) THEN
      #當前維護的庫位,成本庫否
      IF cl_null(g_xmdm_d[l_ac].cost) THEN
         LET g_xmdm_d[l_ac].cost = s_adb_get_inaa010(g_xmdl.xmdlsite,g_xmdm_d[l_ac].xmdm005)
      END IF
      
      #判斷是否一致
      IF g_xmdm_d[l_ac].cost <> l_cost_flag THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adb-00418'
         LET g_errparam.extend = g_xmdm_d[l_ac].xmdm005
         LET g_errparam.replace[1] = g_xmdm_d[l_ac].cost
         LET g_errparam.replace[2] = l_cost_flag
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
