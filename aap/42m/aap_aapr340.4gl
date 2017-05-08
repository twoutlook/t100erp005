#+ Version..: T100-ERP-1.00.00 Build-000075
#+ 
#+ Filename...: aapr340
#+ Buildtype..: R畫面
#+ Memo.......: 用temptable, aapr340_x01當接口，ui畫面切成aapr340
#

IMPORT os
IMPORT FGL lib_cl_dlg
  
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" #T100的環境變數
 
DEFINE tm  RECORD                                 #Print condition RECORD
            wc       STRING,                      #Where condition   
            sw_21    LIKE type_t.chr1,         #退貨折讓沖帳
            sw_22    LIKE type_t.chr1,         #預付沖帳
            sw_23    LIKE type_t.chr1,         #DM沖帳
            z        LIKE type_t.chr1,         #Print UNAP  暫估帳款  
            h        LIKE type_t.chr1,         #狀態
            more     LIKE type_t.chr1          #Input more condition(Y/N)
            END RECORD
                                            

MAIN
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
    CALL cl_ap_init("aap","")  #T100
 
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN 
    #畫面開啟
     OPEN WINDOW w_aapr340 WITH FORM cl_ap_formpath("aap",g_code) #T100
     
    #瀏覽頁簽資料初始化(每個畫面的lib,toolbar等固定設定)
     CALL cl_ui_init()
    #程式初始化
     CALL aapr340_x01_init()
    #進入選單 Menu (='N')
     CALL aapr340_x01_ui_dialog()
    #畫面關閉
     CLOSE WINDOW w_aapr340
   ELSE
     #don't add addpoint 提醒在這之前不可加影響邏輯判斷的內容
     #CALL aapr340_x01(tm.*)
     CALL aapr340_x01(tm.wc,tm.sw_21,tm.sw_22,tm.sw_23,tm.z,tm.h,tm.more)
   END IF
 
   #離開作業
   CALL cl_ap_exitprogram("0")  

END MAIN


#+ 瀏覽頁簽資料初始化
#+ 關於畫面上預設值或是準備預設資料(grid)
#+ 欄位多語言轉換是利用export FGLRESOURCEPATH=/u1/t10dev/erp/azz/42s/zh_TW;
PRIVATE FUNCTION aapr340_x01_init()
   #add-point:init.define
   {<point name="init.define"/>}
   #end add-point

   #畫面資料初始化 
   #add-point:init.prep
   #預設給畫面的值 -(s)
   INITIALIZE tm.* TO NULL            # Default condition
   #LET tm.s    = '123'
   LET tm.more = 'N'
   LET tm.sw_21 ='Y'         
   LET tm.sw_22 ='Y'         
   LET tm.sw_23 ='Y'         
   LET tm.z = 'Y'            
   LET tm.h = '3'            
   LET g_pdate = g_today
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies = '1'
 
   #end add-point

END FUNCTION


#+ 功能選單
#+ 畫面的行為操作
PRIVATE FUNCTION aapr340_x01_ui_dialog()

    
    DIALOG ATTRIBUTES(UNBUFFERED)
       CONSTRUCT BY NAME tm.wc ON itap003,itap002,itap006,itap001,itap004,itap005,itap007,itap000,itap020,itap008,itap019,itap009

          BEFORE CONSTRUCT
              CALL cl_qbe_init()
          ON ACTION controlp
             CASE
                WHEN INFIELD(itap003) 
                   ### 查詢 供應商主檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_pmc_11()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap003
                   ### 查詢 供應商主檔### end ###
                   
                 WHEN INFIELD(itap006) 
                    ### 查詢 員工姓名資料### start ###
                    INITIALIZE g_qryparam.* TO NULL 
                    LET g_qryparam.state = "c"
                    LET g_qryparam.reqry = FALSE
                    LET g_qryparam.where = "1=1"
                    CALL q_itge002()
                    LET g_qryparam.multiret = g_qryparam.return1
                    DISPLAY g_qryparam.multiret TO itap006
                    ### 查詢 員工姓名資料### end ###
                    
                WHEN INFIELD(itap001)              
                   ### 查詢 應付帳款單頭檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_itap001()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap001
                   ### 查詢 應付帳款單頭檔### end ###
                   
                WHEN INFIELD(itap004) 
                   ### 查詢 付款方式檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_itpa004()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap004
                   ### 查詢 付款方式檔### end ###
                   

                   
                WHEN INFIELD(itap005) 
                   ### 查詢 幣別檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_itap005()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap005
                   ### 查詢 幣別檔### end ###
                   
                WHEN INFIELD(itap007)
                   ### 查詢 應付帳款單頭檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_itap007()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap007
                   ### 查詢 應付帳款單頭檔### end ###
                   
                   
                WHEN INFIELD(itap008) 
                   ### 查詢 幣別檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_itap008()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap008
                   ### 查詢 幣別檔### end ###
                   
               


                   
                WHEN INFIELD(itap009)
                   ### 查詢 應付帳款單頭檔### start ###
                   INITIALIZE g_qryparam.* TO NULL 
                   LET g_qryparam.state = "c"
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = "1=1"
                   CALL q_itap009()
                   LET g_qryparam.multiret = g_qryparam.return1
                   DISPLAY g_qryparam.multiret TO itap009
                   ### 查詢 應付帳款單頭檔### end ###
                  
                OTHERWISE
                    EXIT CASE
             END CASE
       END CONSTRUCT
 
      INPUT BY NAME tm.sw_21,tm.sw_23,tm.sw_22,tm.z,tm.h,tm.more  ATTRIBUTE(WITHOUT DEFAULTS) 
         AFTER FIELD sw_21
            IF cl_null(tm.sw_21) OR tm.sw_21 NOT MATCHES '[YN]' THEN
               NEXT FIELD sw_21
            END IF
 
         AFTER FIELD sw_22
            IF cl_null(tm.sw_22) OR tm.sw_22 NOT MATCHES '[YN]' THEN
               NEXT FIELD sw_22
            END IF
 
         AFTER FIELD z
            IF cl_null(tm.z) OR tm.z NOT MATCHES '[YN]' THEN
               NEXT FIELD z
            END IF
 
         AFTER FIELD h
            IF tm.h NOT MATCHES '[123]' OR cl_null(tm.h) THEN 
               NEXT FIELD h 
            END IF
 
         AFTER FIELD sw_23
            IF cl_null(tm.sw_23) OR tm.sw_23 NOT MATCHES '[YN]' THEN
               NEXT FIELD sw_23
            END IF
 
         AFTER FIELD more
            IF tm.more = 'Y' THEN
               #CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
                              #g_bgjob,g_time,g_prtway,g_copies)
                    #RETURNING g_pdate,g_towhom,g_rlang,
                              #g_bgjob,g_time,g_prtway,g_copies
            END IF
 
      END INPUT 

       ON ACTION exit
          LET INT_FLAG = 1
          EXIT DIALOG
       ON ACTION ACCEPT
          #don't add addpoint 提醒在這之前不可加影響邏輯判斷的內容
          #商業邏輯處理
          CALL aapr340_x01(tm.wc,tm.sw_21,tm.sw_22,tm.sw_23,tm.z,tm.h,tm.more)
          CONTINUE DIALOG
       ON ACTION cancel
          LET INT_FLAG=1
          EXIT DIALOG

    END DIALOG
    IF INT_FLAG THEN
       LET INT_FLAG=FALSE
    END IF

END FUNCTION 


