IMPORT os
SCHEMA ds

MAIN 
   DEFINE li_cnt         INT
   DEFINE li_ent         INT
   DEFINE lc_password    VARCHAR(20)
   DEFINE lc_imp         base.channel
   DEFINE ls_filename    STRING
   DEFINE lc_lang        CHAR(10)
   DEFINE ls_str         STRING
   DEFINE ls_connectstr  STRING
   DEFINE lc_langarray DYNAMIC ARRAY OF RECORD
          tabid   STRING,
          tabdesc STRING,
          langcol STRING
                  END RECORD

   LET li_ent = 99
   LET lc_lang = ARG_VAL(1)       #要打包的語言別
   LET lc_password = ARG_VAL(2)   #ds資料庫的密碼

   IF lc_lang IS NULL OR lc_lang = " " THEN
      DISPLAY "未指定要打包的語言別，請重新輸入"
      RETURN
   END IF

   IF lc_lang <> "en_US" AND lc_lang <> "ja_JP" AND lc_lang <> "vi_VN"
      AND lc_lang <> "th_TH" AND lc_lang <> "ko_KR" THEN

      DISPLAY "沒有符合的語言別，請重新輸入"
      RETURN
   END IF

   IF lc_password IS NULL OR lc_password = " " THEN
      DISPLAY "未輸入ds資料庫的密碼，請重新輸入"
      RETURN
   END IF

   LET ls_connectstr = "ds+driver='dbmoraB2x',source='",FGL_GETENV("ZONE") CLIPPED,"'"
   CONNECT TO ls_connectstr AS "ds" USER "ds" USING lc_password

   LET ls_filename = os.path.join(os.Path.join(FGL_GETENV("TOP"),"setup"),"langpack")
   IF NOT os.Path.exists(ls_filename) THEN
      IF NOT os.Path.mkdir(ls_filename) THEN
         DISPLAY "暫存目錄(",ls_filename,")建立失敗，請檢查後重新執行"
         RETURN
      END IF
   ELSE
      LET ls_str = "\\rm ",os.Path.join(ls_filename,"*")
      DISPLAY ls_str
      RUN ls_str
   END IF

   LET lc_imp = base.Channel.create()
   CALL lc_imp.openFile(os.Path.join(ls_filename,"imp-"||lc_lang CLIPPED||".sh"),"a")
   CALL lc_imp.setDelimiter("")

   #要匯出的多語言表
   LET li_cnt = 1
   LET lc_langarray[li_cnt].tabid="dzeal_t"    LET lc_langarray[li_cnt].tabdesc="資料表多語言檔"                     LET lc_langarray[li_cnt].langcol="dzeal002"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="dzebl_t"    LET lc_langarray[li_cnt].tabdesc="資料表欄位多語言檔"                 LET lc_langarray[li_cnt].langcol="dzebl002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzzal_t"    LET lc_langarray[li_cnt].tabdesc="程式名稱多語言記錄表"               LET lc_langarray[li_cnt].langcol="gzzal002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzzd_t"     LET lc_langarray[li_cnt].tabdesc="畫面元件多語言記錄表"               LET lc_langarray[li_cnt].langcol="gzzd002"   LET li_cnt = li_cnt + 1
   LET lc_langarray[li_cnt].tabid="gzdfl_t"    LET lc_langarray[li_cnt].tabdesc="子畫面名稱表"                       LET lc_langarray[li_cnt].langcol="gzdfl002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzzq_t"     LET lc_langarray[li_cnt].tabdesc="ACTION多語言對照表"                 LET lc_langarray[li_cnt].langcol="gzzq003"   LET li_cnt = li_cnt + 1
   LET lc_langarray[li_cnt].tabid="gzswl_t"    LET lc_langarray[li_cnt].tabdesc="參數作業頁面多語言表"               LET lc_langarray[li_cnt].langcol="gzswl003"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzsxl_t"    LET lc_langarray[li_cnt].tabdesc="參數作業頁面設定表多語言檔"         LET lc_langarray[li_cnt].langcol="gzsxl004"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzwel_t"    LET lc_langarray[li_cnt].tabdesc="選單設定多語言表"                   LET lc_langarray[li_cnt].langcol="gzwel002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzszl_t"    LET lc_langarray[li_cnt].tabdesc="參數設定主表多語言檔"               LET lc_langarray[li_cnt].langcol="gzszl003"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzcal_t"    LET lc_langarray[li_cnt].tabdesc="系統分類碼多語言檔"                 LET lc_langarray[li_cnt].langcol="gzcal002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzcbl_t"    LET lc_langarray[li_cnt].tabdesc="系統分類值多語言檔"                 LET lc_langarray[li_cnt].langcol="gzcbl003"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzgdl_t"    LET lc_langarray[li_cnt].tabdesc="報表樣板說明多語言檔"               LET lc_langarray[li_cnt].langcol="gzgdl001"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzge_t"     LET lc_langarray[li_cnt].tabdesc="報表樣板多語言紀錄檔"               LET lc_langarray[li_cnt].langcol="gzge002"   LET li_cnt = li_cnt + 1
   LET lc_langarray[li_cnt].tabid="dzcal_t"    LET lc_langarray[li_cnt].tabdesc="開窗資料表多語言檔"                 LET lc_langarray[li_cnt].langcol="dzcal002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="dzcbl_t"    LET lc_langarray[li_cnt].tabdesc="開窗設計參數設計表多語言檔"         LET lc_langarray[li_cnt].langcol="dzcbl003"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="dzcdl_t"    LET lc_langarray[li_cnt].tabdesc="校驗帶值設計表多語言檔"             LET lc_langarray[li_cnt].langcol="dzcdl002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="dzcel_t"    LET lc_langarray[li_cnt].tabdesc="校驗帶值參數設計表多語言檔"         LET lc_langarray[li_cnt].langcol="dzcel003"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzdel_t"    LET lc_langarray[li_cnt].tabdesc="子程式及應用元件基本資料表多語言檔" LET lc_langarray[li_cnt].langcol="gzdel002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzhal_t"    LET lc_langarray[li_cnt].tabdesc="GWC佈景名稱多語言檔"                LET lc_langarray[li_cnt].langcol="gzhal002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzial_t"    LET lc_langarray[li_cnt].tabdesc="自定義查詢單頭多語言檔"             LET lc_langarray[li_cnt].langcol="gzial002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzidl_t"    LET lc_langarray[li_cnt].tabdesc="自定義查詢-QBE欄位明細檔多語言檔"   LET lc_langarray[li_cnt].langcol="gzidl003"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzjal_t"    LET lc_langarray[li_cnt].tabdesc="服務名稱多語言記錄表"               LET lc_langarray[li_cnt].langcol="gzjal002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gztdl_t"    LET lc_langarray[li_cnt].tabdesc="欄位屬性定義檔多語言檔"             LET lc_langarray[li_cnt].langcol="gztdl002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gztel_t"    LET lc_langarray[li_cnt].tabdesc="模組流程說明多語言檔"               LET lc_langarray[li_cnt].langcol="gztel002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzzol_t"    LET lc_langarray[li_cnt].tabdesc="模組編號多語言記錄表"               LET lc_langarray[li_cnt].langcol="gzzol002"  LET li_cnt = li_cnt + 1 
   LET lc_langarray[li_cnt].tabid="gzzf_t"     LET lc_langarray[li_cnt].tabdesc="作業級畫面元件翻譯代換表"           LET lc_langarray[li_cnt].langcol="gzzf002"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzgjl_t"    LET lc_langarray[li_cnt].tabdesc="表頭說明多語言檔"                   LET lc_langarray[li_cnt].langcol="gzgjl002"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzahl_t"    LET lc_langarray[li_cnt].tabdesc="單據程式列印的報表元件說明檔"       LET lc_langarray[li_cnt].langcol="gzahl003"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzgp_t"     LET lc_langarray[li_cnt].tabdesc="報表簽核關卡設定檔"                 LET lc_langarray[li_cnt].langcol="gzgp003"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="wscal_t"    LET lc_langarray[li_cnt].tabdesc="ETL Job設定多語言檔"                LET lc_langarray[li_cnt].langcol="wscal008"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="wsebl_t"    LET lc_langarray[li_cnt].tabdesc="中間庫SQL記錄表多語言檔"            LET lc_langarray[li_cnt].langcol="wsebl003"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="wsecl_t"    LET lc_langarray[li_cnt].tabdesc="整合產品資料表多語言檔"             LET lc_langarray[li_cnt].langcol="wsecl002"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzze_t"     LET lc_langarray[li_cnt].tabdesc="錯誤訊息表"                         LET lc_langarray[li_cnt].langcol="gzze002"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="rpdel_t"    LET lc_langarray[li_cnt].tabdesc="APP功能基本資料檔多語言檔"          LET lc_langarray[li_cnt].langcol="rpdel003"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="rpzzl_t"    LET lc_langarray[li_cnt].tabdesc="APP基本資料檔多語言檔"              LET lc_langarray[li_cnt].langcol="rpzzl002"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzthl_t"    LET lc_langarray[li_cnt].tabdesc="知識庫索引多語言檔"                 LET lc_langarray[li_cnt].langcol="gzthl003"  LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzti_t"     LET lc_langarray[li_cnt].tabdesc="知識庫多語言圖檔"                   LET lc_langarray[li_cnt].langcol="gzti004"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gztp_t"     LET lc_langarray[li_cnt].tabdesc="應用專題檔"                         LET lc_langarray[li_cnt].langcol="gztp004"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gztq_t"     LET lc_langarray[li_cnt].tabdesc="應用專題細項檔"                     LET lc_langarray[li_cnt].langcol="gztq006"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gztr_t"     LET lc_langarray[li_cnt].tabdesc="應用專題檔案總管"                   LET lc_langarray[li_cnt].langcol="gztr003"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzwp_t"     LET lc_langarray[li_cnt].tabdesc="作業操作說明檔"                     LET lc_langarray[li_cnt].langcol="gzwp004"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzwq_t"     LET lc_langarray[li_cnt].tabdesc="作業操作說明細項檔"                 LET lc_langarray[li_cnt].langcol="gzwq006"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzwr_t"     LET lc_langarray[li_cnt].tabdesc="作業操作說明檔案總管"               LET lc_langarray[li_cnt].langcol="gzwr003"   LET li_cnt = li_cnt + 1  
   LET lc_langarray[li_cnt].tabid="gzzy_t"     LET lc_langarray[li_cnt].tabdesc="語系資料表"                         LET lc_langarray[li_cnt].langcol="gzzy001"   LET li_cnt = li_cnt + 1  

   FOR li_cnt = 1 TO lc_langarray.getLength()
      #將多語言表匯出
      LET ls_str = 'exp ds/',lc_password CLIPPED,' file=',ls_filename,'/',lc_langarray[li_cnt].tabid,'.dmp ',
                   ' tables=',lc_langarray[li_cnt].tabid,
                   ' QUERY=\\\"where ',lc_langarray[li_cnt].langcol.trim(),'=\\\'',lc_lang CLIPPED,'\\\'\\\"',
                   ' STATISTICS=none'
      DISPLAY ls_str
      RUN ls_str

      #將到客戶家要匯入的指令放在shell裡
      LET ls_str = 'imp ds/ds file=\$TOP\/setup\/langpack\/',lc_langarray[li_cnt].tabid,'.dmp ignore=Y'
      DISPLAY ls_str
      CALL lc_imp.write(ls_str)
   END FOR

   #打包ERP標準語言包項目
   LET ls_str = "cd $TOP; tar zcvf ",ls_filename,"\/exp-",lc_lang CLIPPED,"-ERP.tgz ",
                "erp\/*\/*\/",lc_lang CLIPPED," ",
                "erp\/cfg\/4ad\/tiptop_",lc_lang CLIPPED,".4ad ",
                "erp\/*\/*\/*\/",lc_lang CLIPPED," ",
                "com\/*\/*\/",lc_lang CLIPPED," ",
                "com\/*\/*\/*\/",lc_lang CLIPPED," ",
                "com\/mta\/",lc_lang CLIPPED," ",
                "www\/*\/*\/*\/",lc_lang CLIPPED," ",
                "www\/*\/*\/",lc_lang CLIPPED," ",
                "setup\/langpack\/*.dmp ",
                "setup\/langpack\/imp-",lc_lang CLIPPED,".sh "
   DISPLAY ls_str
   RUN ls_str

   #打包報表語言包所需項目
   LET ls_str = "cd $TOP\/..\/..\/T100_gr\/\$ZONE; tar zcvf ",ls_filename,"\/exp-",lc_lang CLIPPED,"-T100_gr.tgz ",
                "*\/*\/",lc_lang CLIPPED
   DISPLAY ls_str
   RUN ls_str

   #將上述兩個tgz檔tar起來
   LET ls_str = "cd $TOP\/setup\/langpack; tar zcvf ",ls_filename,"\/exp-",lc_lang CLIPPED,".tgz ",
                "exp-",lc_lang CLIPPED,"-ERP.tgz ",
                "exp-",lc_lang CLIPPED,"-T100_gr.tgz "
   DISPLAY ls_str
   RUN ls_str

   #刪除上述兩個tgz檔
   LET ls_str = "cd $TOP\/setup\/langpack; \\rm exp-",lc_lang CLIPPED,"-ERP.tgz"
   RUN ls_str
   LET ls_str = "cd $TOP\/setup\/langpack; \\rm exp-",lc_lang CLIPPED,"-T100_gr.tgz"
   RUN ls_str

   CALL lc_imp.close()

END MAIN
