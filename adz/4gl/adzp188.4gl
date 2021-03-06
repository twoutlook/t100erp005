#+ Version..: T100-ERP-1.00.00(版次:1) Build-000553
#+ 
#+ Filename...: adzp188
#+ Description: 報表元件設計器
#+ ...........: 畫面檔元件多語言皆維護在azzi902, ComboBox動態選項多語言尚未維護(azzi920)
#+ ...........: MESSAGE顯示正式上線後請移除
#+ ...........: "儲存底稿"及"產生報表元件"才將資料寫入DB中
#+ ...........: icon顯示, 要請貞竹設計
#+ ...........: 設計資料流程:
#+ ...........: 簽出版號-已存在設計資料------------------寫入TEMPTABLE-維護TEMPTABLE-----不存檔或產生就放棄TEMPTABLE, 有做就寫回DB
#+ ...........:         -不存在設計資料-有前一版設計資料-寫入TEMPTABLE-維護TEMPTABLE-----不存檔或產生就放棄TEMPTABLE, 有做就寫回DB
#+ ...........:                        -無前一版設計資料---------------維護TEMPTABLE(空)-不存檔或產生就放棄TEMPTABLE, 有做就寫回DB
#+ ...........:                      -輸入參考程式----讀入參考程式資料--寫入TEMPTABLE--維護TEMPTABLE-不存檔或產生就放棄TEMPTABLE, 有做就寫回DB
#+ ...........: 140218 優化~~持續優化
#+ ...........: 140223 GR三個頁籤
#+ ...........: 140307 調整新增欄位時，判斷重覆要考慮到別名。
#+ ...........: 140314 功能調整。
#+ ...........: 140317 第一階功能調整。
#+ ...........: 140421 排版若無資料需再出現
#+ ...........: 140507 單身表格化、組合欄位
#+ ...........: 140508 自定欄位視窗加底色與可編輯、已欄位加公式欄位
#+ ...........: 140512 JOIN欄位單頭、單身table加保留字只留enterprise
#+ ...........: 140515 XG交叉表
#+ ...........: 140605 增加XG樣板明細表dzgl_t
#+ ...........: 140612 調整欄位別名存入gzgg001，二次開發調整(啊)
#+ ...........: 140714 GR群組要能選自定義欄位
#+ ...........: 140730 參數頁籤調整
#+ ...........: 140804 調整篩選頁籤，dzgf004、dzgf009, 參數頁籤預設1個參數，自動帶入, 修改gzgg insert寫法
#+ ...........: 140912 調整單頭區塊無法產生
#+ ...........: 140923 elena 調整版次轉數值
#+ ...........: 141013 調整版次存入暫存檔
#+ ...........: 141017 調整版次相關與拿掉g_cust
#+ ...........: 141127 重產時，彈窗提示將變更新增至gzgg_t(增加時，新加入且順序重排，刪除時，順序也要重排)
#+ ...........:        拿掉message、自訂欄位bug調整
#+ ...........: 141222 調整GR group更動時要update
#+ ...........: 150112 update XG時，原gzgf005不更動，且只有xg才顯示會蓋azzi300
#+ ...........: 150120 自定義欄位要判斷是否重覆, 沒有來源程式的sql不驗證
#+ ...........: 150126 增加卡笛笙判斷
#+ ...........: 150211 增加自定欄位預設值0
#+ ...........: 150212 ui美化調整,調整清除畫面效能
#+ ...........: 150413 ui美化調整by Hiko
#+ ...........: 150424 add FIELD ORDER FORM tab欄位照畫面排序
#+ ...........: 150506 #150507-00002 複製報表元件功能 
#+ ...........: 150526 #150525-00029#1 UI、功能優化
#+ ...........: 150526 #150617-00018#1 自訂欄位新增問題, 判斷dzgj_tmp個數
#+ ...........: 150807 #150807-00006#1 憑證新做排版時，要先清空暫存檔
#+ ...........: 150807 #150812-00006#1 交叉表時，需存入gzgf020~gzgf023預設值
#+ ...........: 150817 #150817-00030#1 參考程式，若換掉單身，重抓取時，要以參考程式的規格抓取
#+ ...........: 150818 #150818-00025#1 1.調整自訂欄位的錯誤訊息 2.調整xg的彙總空值不彈訊息
#+ ...........: 150818 #150821-00017#1 新開發時多判斷lc_cmd是null值
#+ ...........: 150902 #150901-00021#1 cl_xg_get_column_info改呼叫cl_rpt_get_column_info
#+ ...........: 151012 #151012-00003#1 調整抓取客製參考資料的sql' 將adzp188_dzge_xg_tmp 改成adzp188_gexg_tmp  
#+ ...........: 151212 #151208-00023#1 調整從gztz_t抓取table名時，要排除備份檔(rebuil)。
#+ ...........: 151216 #151023-00015#1 判斷參數tmp拿掉g_cust, 。判斷憑證報表時，群組至少要一個, 查詢報表存入gzgg_t時，判斷是否存在gzgg017
#+ ...........: 160408 #160330-00019#3 查詢報表查生完，對有多樣板做欄位merge,欄位頁籤產生多語言不限繁中、簡中
#+ ...........: 160408 #160518-00036#1 調整gzgg017判斷值為>0
#+ ...........: 160615 #160615-00007#1 調整SQL為subquery組法, 補上關連表的key，gzgg017為y的判斷,複製查詢報表元件連同azzi300/azzi301一同複製
#+ ...........: 161102 #161102-00030#1 調整新增自定義欄位效能優化
#+ ...........: 161219 #161215-00029#1 1.更新報表元件時判斷有簽出會詢問是否儲存 
#+ ...........: 161219                 2.驗證SQL改成：詢問是否刪掉設計資料，若不刪保留設計資料，提示4GL的SQL會有錯誤。
#+ ...........: 161219                 3.xg產生報表元件時，才存至gzgf、gzgg
#+ ...........: 161228 #161227-00056#1 調整撈取gztz_t時，要判斷掉'erp'、'all'、'b2b'、'pos'、'dsm'，避免多拉資料 
#+ ...........: 170123 #160921-00012#1 增加程式樣板欄位x02，自定義欄位撈不到TABLE問題

IMPORT os
IMPORT security
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

###150507-00002 add-(s)
&include "../4gl/sadzp270.inc"     
###150507-00002 add-(e)                   

PRIVATE type type_g_dzga_m   RECORD
             dzgastus        LIKE dzga_t.dzgastus,
             dzga001         LIKE dzga_t.dzga001,   #報表元件代號
             dzga002         LIKE dzga_t.dzga002,   #版次
             dzga003         LIKE dzga_t.dzga003,
             dzga004         LIKE dzga_t.dzga004,
             dzgaownid       LIKE dzga_t.dzgaownid,
             dzgaowndp       LIKE dzga_t.dzgaowndp,
             dzgacrtid       LIKE dzga_t.dzgacrtid,
             dzgacrtdp       LIKE dzga_t.dzgacrtdp,
             dzgacrtdt       LIKE dzga_t.dzgacrtdt,
             dzgamodid       LIKE dzga_t.dzgamodid,
             dzgamoddt       LIKE dzga_t.dzgamoddt,
             dzga006         LIKE dzga_t.dzga006,   ##150525-00029#1 客製欄位
             gzde006         LIKE gzde_t.gzde006    #160921-00012#1 add 
                             END RECORD
PRIVATE type type_g_dzgb_d   RECORD
             dzgb003         LIKE dzgb_t.dzgb003,
             dzgb004         LIKE dzgb_t.dzgb004,
             dzgb005         LIKE dzgb_t.dzgb005,
             dzgb006         LIKE dzgb_t.dzgb006,
             dzgb007         LIKE dzgb_t.dzgb007,
             dzgb008         LIKE dzgb_t.dzgb008,
             dzgb009         LIKE dzgb_t.dzgb009,
             dzgb010         LIKE dzgb_t.dzgb010,
             dzgb011         LIKE dzgb_t.dzgb011,
             dzgb012         LIKE dzgb_t.dzgb012,
             dzgb013         LIKE dzgb_t.dzgb013,
             dzgb014         LIKE dzgb_t.dzgb014,
             dzgb015         LIKE dzgb_t.dzgb015,
             dzgb016         LIKE dzgb_t.dzgb016,
             dzgb017         LIKE dzgb_t.dzgb017             
                             END RECORD
PRIVATE type type_g_dzgc_d   RECORD
             dzgc003         LIKE dzgc_t.dzgc003,
             dzgc004         LIKE dzgc_t.dzgc004,
             dzgc005         LIKE dzgc_t.dzgc005,
             dzgc006         LIKE dzgc_t.dzgc006,
             dzgc007         LIKE dzgc_t.dzgc007
                             END RECORD
PRIVATE type type_g_dzgd_d   RECORD
             dzgd003         LIKE dzgd_t.dzgd003,
             dzgd004         LIKE dzgd_t.dzgd004,
             dzgd005         LIKE dzgd_t.dzgd005,
             dzgd006         LIKE dzgd_t.dzgd006
                             END RECORD
                             
PRIVATE type type_g_dzgf_d   RECORD
             dzgf003         LIKE dzgf_t.dzgf003,
             dzgf004         LIKE dzgf_t.dzgf004,
             dzgf005         LIKE dzgf_t.dzgf005,
             dzgf006         LIKE dzgf_t.dzgf006,
             dzgf007         LIKE dzgf_t.dzgf007,
             dzgf008         LIKE dzgf_t.dzgf008,
             dzgf009         LIKE dzgf_t.dzgf009,
             dzgf010         LIKE dzgf_t.dzgf010
                             END RECORD
##140306 參數 -(s)                             
PRIVATE type type_g_dzgj_d   RECORD
             dzgj003         LIKE dzgj_t.dzgj003,
             dzgj004         LIKE dzgj_t.dzgj004,
             dzgj005         LIKE dzgj_t.dzgj005,
             dzgj006         LIKE dzgj_t.dzgj006
                             END RECORD 
##140306 參數 -(s)                             
#xg群組
PRIVATE type type_g_dzge_xg_d   RECORD
             dzge006         LIKE dzge_t.dzge006,
             group           LIKE type_t.chr1,
             sort            LIKE type_t.chr1,
             paging          LIKE type_t.chr1,
             dzge004         LIKE dzge_t.dzge004
                             END RECORD                              

#gr群組
PRIVATE type type_g_dzge_gr_d   RECORD
             dzge003         LIKE dzge_t.dzge003,
             dzge004         LIKE dzge_t.dzge004,
             dzge005         LIKE dzge_t.dzge005,
             dzge006         LIKE dzge_t.dzge006,
             dzge007         LIKE dzge_t.dzge007
                             END RECORD 
#gr樣板明細檔
PRIVATE type type_g_dzgh_d   RECORD
             dzgh003         LIKE dzgh_t.dzgh003,
             dzgh004         LIKE dzgh_t.dzgh004,
             dzgh005         LIKE dzgh_t.dzgh005,
             dzgh006         LIKE dzgh_t.dzgh006,
             dzgh007         LIKE dzgh_t.dzgh007,
             dzgh008         LIKE dzgh_t.dzgh008,
             dzgh009         LIKE dzgh_t.dzgh009    ##140327 add
                             END RECORD 
#gr樣單頭檔
PRIVATE type type_g_dzgg_d   RECORD
             dzgg003         LIKE dzgg_t.dzgg003,
             dzgg004         LIKE dzgg_t.dzgg004,
             dzgg005         LIKE dzgg_t.dzgg005,
             dzgg006         LIKE dzgg_t.dzgg006,
             dzgg007         LIKE dzgg_t.dzgg007,
             dzgg008         LIKE dzgg_t.dzgg008,
             dzgg009         LIKE dzgg_t.dzgg009,
             dzgg010         LIKE dzgg_t.dzgg010,
             dzgg011         LIKE dzgg_t.dzgg011,
             dzgg012         LIKE dzgg_t.dzgg012,
             dzgg013         LIKE dzgg_t.dzgg013,
             dzgg014         LIKE dzgg_t.dzgg014,
             dzgg015         LIKE dzgg_t.dzgg015        ##140505單身表格化         
                             END RECORD                              
                             
#140117 -(S)
##樣板設定
PRIVATE type type_g_temp_set  RECORD
             #150330 mark -(s)
             #r_detail        LIKE type_t.chr1,
             #r_povit         LIKE type_t.chr1,
             #r_tree          LIKE type_t.chr1,
             #150330 mark -(e)
             c_subrep        LIKE type_t.chr1,
             c_master        LIKE type_t.chr1,
             c_chart         LIKE type_t.chr1
                             END RECORD

##GR的樣板設定
PRIVATE type type_g_gr_temp_set RECORD 
             ##150330 mark -(s)
             #r_voucher       LIKE type_t.chr1,
             #r_label         LIKE type_t.chr1,
             #r_overlay       LIKE type_t.chr1,
             ##150330 mark -(e)
             c_masterzone    LIKE type_t.chr1,
             c_detailrow     LIKE type_t.chr1,
             c_memosubrep    LIKE type_t.chr1,
             c_signoff       LIKE type_t.chr1,
             c_detailtable   LIKE type_t.chr1       ##140505單身表格化
                             END RECORD 
                      
PRIVATE type type_g_paper_set  RECORD
             r_unit          LIKE type_t.chr1,
             r_direction     LIKE type_t.chr1,
             r_format        LIKE type_t.chr1,
             c_std           LIKE type_t.chr1,
             custom          LIKE type_t.chr100,
             len             LIKE type_t.num15_3,
             width           LIKE type_t.num15_3,
             left            LIKE type_t.num15_3,
             top             LIKE type_t.num15_3,
             botton          LIKE type_t.num15_3,
             right           LIKE type_t.num15_3             
                             END RECORD  

PRIVATE type type_g_typelist2 RECORD 
          typename2          STRING,
          #typeid2            LIKE dzeb_t.dzeb002,  #140507 舊版
          typeid2            LIKE dzgc_t.dzgc004,   #140507 add
          typepid2           LIKE dzea_t.dzea001,
          typeexp2           LIKE type_t.num5,
          typeisnode2        LIKE type_t.num5,
          typeseq2           LIKE type_t.num5,   #子順序
          typepidseq2        LIKE type_t.num5,   #父順序
          typepidtype2       LIKE type_t.chr1,   #單頭/單身 
          typealias2         LIKE dzgh_t.dzgh009 #別名     ##140327 add
                             END RECORD                                       
#140117 -(e)  


#140415 -(s)
PRIVATE  TYPE type_g_ud_dzgd   RECORD                 ##自訂欄位開窗
       dzgd006_1        LIKE dzgd_t.dzgd003,
       dzgd006_2        LIKE dzgd_t.dzgd003,
       dzgd006_3        LIKE dzgd_t.dzgd003 
                END RECORD                   
DEFINE g_ud_dzgd         type_g_ud_dzgd
#140415 -(s)  

#150507-00002 add -(s)
DEFINE subPara type_para,
        sub_dzag DYNAMIC ARRAY OF dzag_type,
        sub_dzeb_stored DYNAMIC ARRAY OF type_col_relation   
#150507-00002 add -(e)        

DEFINE g_dzga_m              type_g_dzga_m
DEFINE g_dzgb_d              type_g_dzgb_d
DEFINE g_dzgc_d              type_g_dzgc_d
DEFINE g_dzgd_d              type_g_dzgd_d
DEFINE g_dzge_xg_d           type_g_dzge_xg_d
DEFINE g_dzge_gr_d           type_g_dzge_gr_d
DEFINE g_dzgf_d              type_g_dzgf_d
DEFINE g_temp_set            type_g_temp_set        #樣板設定/樣板設定 #140117 
DEFINE g_paper_set           type_g_paper_set       #樣板設定/紙張設定 #140117 
DEFINE g_gr_temp_set         type_g_gr_temp_set    #GR樣板設定
DEFINE g_dzgh_d              type_g_dzgh_d         #GR樣板單頭檔
DEFINE g_dzgg_d              type_g_dzgg_d         #GR樣板單身檔
DEFINE g_dzgj_d              type_g_dzgj_d          ##參數  0306

DEFINE g_dzga001             LIKE dzga_t.dzga001
DEFINE g_gzza001             LIKE gzza_t.gzza001
DEFINE g_gzzo001             LIKE gzzo_t.gzzo001
DEFINE g_dzga001_t           LIKE dzga_t.dzga001
DEFINE g_prog_type           LIKE gzde_t.gzde005   #程式類型
DEFINE g_dzge005             LIKE dzge_t.dzge005   #GR GROUP /ORDER BY ,ORDER EXTERNAL BY
DEFINE g_arg                 LIKE type_t.num5      #參數頁籤:個數
DEFINE g_dzea003             LIKE dzea_t.dzea003   #150525-00029#1 輸入資料表

#資料表頁簽 - (左)資料表清單
DEFINE g_tablelist           DYNAMIC ARRAY OF RECORD
          id                 LIKE dzea_t.dzea001,
          name               LIKE dzeal_t.dzeal003
                             END RECORD
#資料表頁簽 - (右)已挑選資料表清單
DEFINE g_tablesel            DYNAMIC ARRAY OF RECORD
          id                 LIKE dzea_t.dzea001,
          name               LIKE dzeal_t.dzeal003,
          seq                LIKE type_t.num10
                             END RECORD
#連結頁簽 - (左)資料表一欄位清單
DEFINE g_tablejoin1          DYNAMIC ARRAY OF RECORD
          id                 LIKE dzeb_t.dzeb002,
          name               LIKE dzebl_t.dzebl003
                             END RECORD
#連結頁簽 - (右)資料表二欄位清單
DEFINE g_tablejoin2          DYNAMIC ARRAY OF RECORD
          id                 LIKE dzeb_t.dzeb002,
          name               LIKE dzebl_t.dzebl003
                             END RECORD
#連結頁簽 - (下)資料表連結清單
DEFINE g_join                DYNAMIC ARRAY OF RECORD
          dzgb003            LIKE dzgb_t.dzgb003,
          dzgb004            LIKE dzgb_t.dzgb004,
          dzgb005            LIKE dzgb_t.dzgb005,
          dzgb006            LIKE dzgb_t.dzgb006,
          dzgb007            LIKE dzgb_t.dzgb007,
          dzgb008            LIKE dzgb_t.dzgb008,
          dzgb009            LIKE dzgb_t.dzgb009,
          dzgb010            LIKE dzgb_t.dzgb010,
          wc                 LIKE dzgb_t.dzgb011,
          flag               LIKE type_t.chr1,         #Y=預設sql,N=配置
          dzgb012            LIKE dzgb_t.dzgb012,
          dzgb013            LIKE dzgb_t.dzgb013,
          dzgb014            LIKE dzgb_t.dzgb014,
          dzgb015            LIKE dzgb_t.dzgb015,
          dzgb016            LIKE dzgb_t.dzgb016,
          dzgb017            LIKE dzgb_t.dzgb017          
                             END RECORD
DEFINE g_join_idx            LIKE type_t.num5

DEFINE g_join1               DYNAMIC ARRAY OF RECORD #顯示join wc顏色，預設產生:藍(無法修改)，配置產生:黑(可修改)
          dzgb003            LIKE dzgb_t.dzgb003,
          dzgb004            LIKE dzgb_t.dzgb004,
          dzgb005            LIKE dzgb_t.dzgb005,
          dzgb006            LIKE dzgb_t.dzgb006,
          dzgb007            LIKE dzgb_t.dzgb007,
          dzgb008            LIKE dzgb_t.dzgb008,
          dzgb009            LIKE dzgb_t.dzgb009,
          dzgb010            LIKE dzgb_t.dzgb010,
          wc                 LIKE dzgb_t.dzgb011,
          flag               LIKE type_t.chr1,         #Y=預設sql,N=配置
          dzgb012            LIKE dzgb_t.dzgb012,
          dzgb013            LIKE dzgb_t.dzgb013,
          dzgb014            LIKE dzgb_t.dzgb014,
          dzgb015            LIKE dzgb_t.dzgb015,
          dzgb016            LIKE dzgb_t.dzgb016,
          dzgb017            LIKE dzgb_t.dzgb017           
                             END RECORD
                             
#欄位頁簽 - (左)樹狀欄位清單
DEFINE g_fieldlist           DYNAMIC ARRAY OF RECORD
          name               STRING,
          id                 LIKE dzeb_t.dzeb002,
          pid                LIKE dzea_t.dzea001,
          exp                LIKE type_t.num5,
          isnode             LIKE type_t.num5,
          alias              LIKE dzea_t.dzea001    #別名
                             END RECORD
#欄位頁簽 - (右)已挑選欄位清單
DEFINE g_fieldsel            DYNAMIC ARRAY OF RECORD
          dzgcchk            LIKE type_t.chr1,
          dzgc007            LIKE dzgc_t.dzgc007,  #別名
          dzgc004            LIKE dzgc_t.dzgc004,
          name               LIKE dzebl_t.dzebl003,
          ext                LIKE type_t.chr1,
          print              LIKE type_t.chr1,
          dzgc003            LIKE dzgc_t.dzgc003,  #避免排序錯誤, 序號值必須抓出, 但不顯示
          dzgc006            LIKE dzgc_t.dzgc006,  #為了讓之後功能知道是標準欄位還是自訂欄位
          dzgd006            LIKE dzgd_t.dzgd006   #140508自訂欄位公式 
                             END RECORD

#140110 add -(s)--------------------                             
#XG群組頁簽 - (左)樹狀欄位清單
DEFINE g_xg_grouplist        DYNAMIC ARRAY OF RECORD
          groupname          STRING,
          groupid            LIKE dzeb_t.dzeb002,
          grouppid           LIKE dzea_t.dzea001,
          groupexp           LIKE type_t.num5,
          groupisnode        LIKE type_t.num5,
          groupalias         LIKE dzgc_t.dzgc007         ##140606 add
                             END RECORD
                          
#XG群組頁簽 - (右)已挑選欄位清單 
DEFINE g_xg_groupsel         DYNAMIC ARRAY OF RECORD
          dzge006            LIKE dzge_t.dzge006,
          name               LIKE dzebl_t.dzebl003,
          group              LIKE type_t.chr1,
          sort               LIKE dzge_t.dzge007,
          paging             LIKE type_t.chr1,
          dzge004            LIKE dzge_t.dzge004,  #避免排序錯誤, 序號值必須抓出, 但不顯示
          alias              LIKE dzgc_t.dzgc007   ##140606 add
                             END RECORD
 #XG彙總頁簽 - (左)樹狀欄位清單                            
DEFINE g_summarylist1      DYNAMIC ARRAY OF RECORD
          summaryname1       STRING,
          summaryid1         LIKE dzeb_t.dzeb002,
          summarypid1        LIKE dzea_t.dzea001,
          summaryexp1        LIKE type_t.num5,
          summaryisnode1     LIKE type_t.num5,
          summaryalias       LIKE dzgc_t.dzgc007         ##140606 add
                             END RECORD
                        
 #XG彙總頁簽 - (右)樹狀欄位清單
DEFINE g_summarylist2      DYNAMIC ARRAY OF RECORD
          summaryname2       STRING,
          summaryid2         LIKE dzeb_t.dzeb002,
          summarypid2        LIKE dzea_t.dzea001,
          summaryexp2        LIKE type_t.num5,
          summaryisnode2     LIKE type_t.num5,
          summarytype2       LIKE gzgg_t.gzgg010,
          summarypidseq2     LIKE type_t.num5,      #父順序
          summaryalias2      LIKE dzgc_t.dzgc007   ##140606 add
              END RECORD                             

#140223 -(s)
#GR群組頁簽 - (左上)樹狀欄位清單
DEFINE g_gr_grouplist1      DYNAMIC ARRAY OF RECORD
          groupname1       STRING,
          #groupid1         LIKE dzeb_t.dzeb002,  #140714 mark
          groupid1         LIKE dzge_t.dzge006,   #140714 add
          grouppid1        LIKE dzea_t.dzea001,
          groupexp1        LIKE type_t.num5,
          groupisnode1     LIKE type_t.num5
              END RECORD
              
#GR群組頁簽 - (左下)樹狀欄位清單
DEFINE g_gr_grouplist2      DYNAMIC ARRAY OF RECORD
          groupname2       STRING,
          #groupid2         LIKE dzeb_t.dzeb002,  #140714 mark
          groupid2         LIKE dzge_t.dzge006,   #140714 add
          grouppid2        LIKE dzea_t.dzea001,
          groupexp2        LIKE type_t.num5,
          groupisnode2     LIKE type_t.num5
              END RECORD 

#GR群組頁簽 - (左上)已選欄位清單
DEFINE g_gr_groupsel1      DYNAMIC ARRAY OF RECORD
          dzge006          LIKE dzge_t.dzge006,
          dzge006_desc     LIKE dzebl_t.dzebl003,
          dzge007          LIKE dzge_t.dzge007,
          dzge003          LIKE dzge_t.dzge003,
          dzge004          LIKE dzge_t.dzge004
              END RECORD
              
#GR群組頁簽 - (左下)已選欄位清單
DEFINE g_gr_groupsel2      DYNAMIC ARRAY OF RECORD
          dzge006          LIKE dzge_t.dzge006,
          dzge006_desc     LIKE dzebl_t.dzebl003,
          dzge007          LIKE dzge_t.dzge007,
          dzge003          LIKE dzge_t.dzge003,
          dzge004          LIKE dzge_t.dzge004          
              END RECORD         

#GR排版頁簽 - (左)樹狀欄位清單                            
DEFINE g_typelist1      DYNAMIC ARRAY OF RECORD
          typename1          STRING,
          #typeid1            LIKE dzeb_t.dzeb002,   #140507 mark
          typeid1            LIKE dzgc_t.dzgc004,    #140507 add
          typepid1           LIKE dzea_t.dzea001,
          typeexp1           LIKE type_t.num5,
          typeisnode1        LIKE type_t.num5,
          typealias1         LIKE dzgh_t.dzgh009
                             END RECORD

#GR排版頁簽 - (右)樹狀欄位清單                            
                            
DEFINE g_typelist2     DYNAMIC ARRAY OF type_g_typelist2  ##20140227
  
#140223 -(e) 
#140110 add -(e)--------------------
##參數清單0306-(S)
DEFINE g_argsel        DYNAMIC ARRAY OF RECORD
          dzgj003          LIKE dzgj_t.dzgj003,
          dzgj006          LIKE dzgj_t.dzgj006,
          dzgj004          LIKE dzgj_t.dzgj004,
          dzgj005_1        LIKE dzgj_t.dzgj005,
          dzgj005_2        LIKE dzgj_t.dzgj005         
              END RECORD
##參數清單0306-(e) 
##140415 (s)
DEFINE g_udfieldlist     DYNAMIC ARRAY OF RECORD
          name          STRING,
          id            LIKE dzeb_t.dzeb002,
          pid           LIKE dzea_t.dzea001,
          exp           LIKE type_t.num5,
          isnode        LIKE type_t.num5,
          alias         LIKE dzea_t.dzea001    #別名
                        END RECORD   

#函式頁簽 - (右)樹狀函式清單
DEFINE g_funclist    DYNAMIC ARRAY OF RECORD
          name          STRING,
          id            LIKE dzeb_t.dzeb002,
          pid           LIKE dzea_t.dzea001,
          exp           LIKE type_t.num5,
          isnode        LIKE type_t.num5,
          alias         LIKE dzea_t.dzea001    #別名
                        END RECORD   
DEFINE g_udfieldlist_idx  LIKE type_t.num5
DEFINE g_funclist_idx   LIKE type_t.num5 
##140415 (s)    
##140516 XG排版(左)樹狀欄位清單-(s)                          
DEFINE g_xgtypelist1      DYNAMIC ARRAY OF RECORD
         xgtypename1          STRING,
         xgtypeid1            LIKE dzgc_t.dzgc004,    #140507 add
         xgtypepid1           LIKE dzea_t.dzea001,
         xgtypeexp1           LIKE type_t.num5,
         xgtypeisnode1        LIKE type_t.num5,
         xgtypealias1         LIKE dzgh_t.dzgh009
                             END RECORD
#XG排版(右)col欄位清單-(s)
DEFINE g_tablecol            DYNAMIC ARRAY OF RECORD
          name               LIKE dzeal_t.dzeal003,
          id                 LIKE dzgc_t.dzgc004,          
          seq                LIKE type_t.num10,
          alias              LIKE dzgh_t.dzgh009
                             END RECORD
                             
DEFINE g_tablerow            DYNAMIC ARRAY OF RECORD
          name               LIKE dzeal_t.dzeal003,
          id                 LIKE dzgc_t.dzgc004,          
          seq                LIKE type_t.num10,
          alias              LIKE dzgh_t.dzgh009
                             END RECORD  
DEFINE g_tablesum            DYNAMIC ARRAY OF RECORD
          name               LIKE dzeal_t.dzeal003,
          id                 LIKE dzgc_t.dzgc004,          
          seq                LIKE type_t.num10,
          alias              LIKE dzgh_t.dzgh009
                             END RECORD                               
##140516 XG排版(左)樹狀欄位清單-(e)  

#篩選頁簽 - 篩選條件清單
DEFINE g_filter              DYNAMIC ARRAY OF RECORD
          dzgf003            LIKE dzgf_t.dzgf003,
          dzgf004            LIKE dzgf_t.dzgf004,
          dzgf005            LIKE dzgf_t.dzgf005,
          dzgf006            LIKE dzgf_t.dzgf006,
          dzgf007            LIKE dzgf_t.dzgf007,
          dzgf008            LIKE dzgf_t.dzgf008,
          dzgf009            LIKE dzgf_t.dzgf009,
          dzgf010            LIKE dzgf_t.dzgf010,
          wc                 LIKE type_t.chr200
                             END RECORD 
DEFINE g_xg_groupsel_idx     LIKE type_t.num5     #140113 groupsel idx  
DEFINE g_xg_grouplist_idx    LIKE type_t.num5     #140113 grouplist idx 
DEFINE g_summarylist1_idx    LIKE type_t.num5     #140113 summarylist1 idx 
DEFINE g_summarylist2_idx    LIKE type_t.num5     #140113 summarylist2 idx                     
DEFINE g_fieldlist_idx       LIKE type_t.num5
DEFINE g_fieldsel_idx        LIKE type_t.num5
DEFINE g_sum_idx             LIKE type_t.num5     #140124 summary陣列idx
DEFINE g_gr_grouplist1_idx   LIKE type_t.num5     #140223 grouplist1 idx 
DEFINE g_gr_grouplist2_idx   LIKE type_t.num5     #140223 grouplist2 idx 
DEFINE g_gr_groupsel1_idx    LIKE type_t.num5     #140224 groupsel1 idx 
DEFINE g_gr_groupsel2_idx    LIKE type_t.num5     #140224 groupsel2 idx 
DEFINE g_typelist1_idx       LIKE type_t.num5     #140223 grouplist1 idx 
DEFINE g_typelist2_idx       LIKE type_t.num5     #140223 grouplist2 idx 
DEFINE g_argsel_idx          LIKE type_t.num5     #140306 argsel_idx 
DEFINE g_table_idx           LIKE type_t.num5     #tablesel_idx
DEFINE g_xgtypelist1_idx       LIKE type_t.num5   #140516 
DEFINE g_tablecol_idx        LIKE type_t.num5     #140516 
DEFINE g_tablerow_idx        LIKE type_t.num5     #140516 
DEFINE g_tablesum_idx        LIKE type_t.num5     #140516 
#自訂欄位
DEFINE g_dzgd004_1           LIKE dzea_t.dzea001
DEFINE g_dzgd004_2           LIKE dzeb_t.dzeb002
DEFINE g_dzgd006_1           LIKE type_t.chr1      #自訂欄位選項
DEFINE g_filter_idx            LIKE type_t.num5

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_sql                 STRING
DEFINE g_cnt                 LIKE type_t.num5
DEFINE g_xg_cnt              LIKE type_t.num5   #XG 樣板id
DEFINE g_erpalm              STRING   #是否啟動ALM

#UI變數
DEFINE gwin_curr             ui.Window
DEFINE gfrm_curr             ui.Form
DEFINE gdig_curr             ui.Dialog


DEFINE g_lang_str            STRING                         #多語言字串
DEFINE g_nFind_table         STRING 
DEFINE g_gzgf000             LIKE gzgf_t.gzgf000            #XG樣板ID

#樣板設定 變數
DEFINE g_unit                LIKE type_t.chr1
DEFINE g_unit_str            STRING                      #單位多語言
DEFINE g_margin_tb           LIKE type_t.num15_3         #上下邊界
DEFINE g_margin_lr           LIKE type_t.num15_3         #左右邊界
DEFINE g_gzgg009             LIKE gzgg_t.gzgg009         #彙總頁籤上的算式
DEFINE g_alias_seq           LIKE type_t.num5            #別名的序號
DEFINE g_combine_dzgd006     LIKE dzgd_t.dzgd006
DEFINE g_code_ide            LIKE type_t.chr1            #程式客製標示，"s":標準; "c"客製  #140612 add
DEFINE g_cust                LIKE dzga_t.dzga005         #客戶代號       $CUST       #140612 add  
DEFINE g_module              LIKE gzde_t.gzde002         #模組                      #140612 add
DEFINE g_ver                 LIKE dzga_t.dzga002         #版次                      #140612 add
DEFINE g_spec_ver            LIKE dzga_t.dzga002         ##140612 規格版次
DEFINE g_spec_ide            LIKE dzga_t.dzga005         ##140612 規格客製識別
DEFINE g_gzgf003             LIKE gzgf_t.gzgf003         #樣板客製Y/N                #140617 ADD
DEFINE g_gzza001_desc        LIKE gzzal_t.gzzal003       #140710 add
DEFINE gs_ver                STRING                      #140923  add by elena  #141013 mark
#DEFINE gs_ver                LIKE type_t.num10          #141013  add 
DEFINE g_signout             LIKE type_t.chr1            ##150508 add
DEFINE g_signout_t           LIKE type_t.chr1            ##161215-00029#1 add 簽出舊值
DEFINE g_stus                STRING                      ##161215-00029#1 add 目前狀態

MAIN

   #Begin:#150413 by Hiko
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   #End:150413 by Hiko

   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT  


   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzp188 WITH FORM cl_ap_formpath("adz","adzp188")
   CLOSE WINDOW SCREEN

   CALL cl_tool_init()

   CALL cl_ui_wintitle(1)            #工具抬頭名稱 
 
   CALL cl_load_4ad_interface(NULL)
 
   #程式初始化
 
   CALL adzp188_init()   

   #Begin:150413 by Hiko
   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   #End:150413 by Hiko
   
   CALL adzp188_input()
 
   #畫面關閉
   CLOSE WINDOW w_adzp188

END MAIN

FUNCTION adzp188_init()
   DEFINE   ls_cfg_path   STRING

   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  
   #匯入style
   #CALL ui.Interface.loadStyles(os.Path.join(ls_cfg_path,os.Path.join("4st", "adzp188.4st")))   #150413 by Hiko  

   ##取得客戶代號140613 add
   LET g_cust = FGL_GETENV("CUST")
   
   #動態產生模組代碼
   
   CALL cl_set_combo_module("gzzo001",1)
   
 
  #動態產生欄位頁簽中的-自訂欄位資料表選項 跟第一次的欄位選項
   #CALL adzp188_set_table_comboitems("formonly.dzgd004_1", FALSE) RETURNING g_dzgd004_1
   #LET g_dzgd004_1 = "type_t"   #重設預設值
   #CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, FALSE) RETURNING g_dzgd004_2
    #LET g_dzgd004_2 = "chr30"     #重設預設值    ##140513 add
   #LET g_dzgd006_1 = "1"     #重設預設值
   
   #開立所有設計資料的TEMPTABLE
   CALL adzp188_create_design_temptable()

   ##150225 mark -(s)
   ##樣板設定按鍵 顏色的設定(搭配4st)
   #CALL gfrm_curr.setElementStyle("rpt_model_setting", "reportmainfun1")
   ##150225 mark -(s)
   #CALL ui.Form.setActionActive("add_arrow", TRUE)

   ##隱藏GR相關設定  
   --CALL adzp188_gr_hidden(FALSE,'')  
   

   CALL adzp188_xg_hidden(TRUE)

   #隱藏"報表資料模型"，只顯示樣板設定
   CALL gfrm_curr.setElementHidden("vbox17", FALSE)
   #CALL gfrm_curr.setElementHidden("folder1", TRUE)  ##150213 mark

   #參數個數
   LET g_arg =""  
   LET g_stus =""                   #161215-00029#1 add
    
   ##XG樣板設定單位
   ##140117 --(s)
   ##150225 mark -(s)
   #LET g_temp_set.r_detail = "1"
   #LET g_temp_set.r_povit = ""
   #LET g_temp_set.r_tree = ""
   ##150225 mark -(e)
   LET g_temp_set.c_subrep = "N"
   LET g_temp_set.c_master = "N"
   LET g_temp_set.c_chart = "N"
   ##GR樣板設定單位
   ##150225 mark -(s)
   #LET g_gr_temp_set.r_voucher = "1"
   #LET g_gr_temp_set.r_label = ""
   #LET g_gr_temp_set.r_overlay = ""
   ##150225 mark -(s)
   LET g_gr_temp_set.c_detailrow = 1
   LET g_gr_temp_set.c_masterzone =1
   LET g_gr_temp_set.c_memosubrep = "Y"
   LET g_gr_temp_set.c_signoff = "Y"
   LET g_gr_temp_set.c_detailtable  = "N"    ##140505單身表格化
   ##紙張設定單位
   LET g_paper_set.r_unit = "1"
   LET g_paper_set.r_direction = "1"
   LET g_paper_set.r_format = "1"
   LET g_paper_set.c_std ="1"
   LET g_paper_set.len = 29.70
   LET g_paper_set.width = 21.00
   LET g_gzgg009 = '0'
   ##紙張方向
   #CALL adzp188_direction_img()

   ##150225 add -(s)
   ##預設GR群組頁籤時為憑證報表
   LET g_dzga_m.dzga003 = "1"
   DISPLAY g_dzga_m.dzga003 TO dzga_t.dzga003   
   ##預設GR報表時，報表類型為憑證
   ##150303 mark -(s)
   #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
   #CALL cl_set_combo_items("dzga_t.dzga004", "1,4,5", g_lang_str)
   ##150303 mark -(e)
   ##150303 add- 調整只有憑證，拿掉套表/標籤(s)                  
   LET g_lang_str = cl_getmsg("adz-00238",g_lang)
   CALL cl_set_combo_items("dzga_t.dzga004", "1", g_lang_str)     
   ##150303 add- 調整只有憑證，拿掉套表/標籤(e)     
   LET g_dzga_m.dzga004 = "1"
   DISPLAY g_dzga_m.dzga004 TO dzga_t.dzga004
   ##顯示圖片
   CALL adzp188_direction_img()
   CALL gfrm_curr.setElementText("lbl_temptype",cl_getmsg("adz-00547",g_lang))
   ##150225 add -(e)

   ##150525-00029#1  add -(s) 
   LET g_dzga_m.dzga006 = 's'                      
   DISPLAY g_dzga_m.dzga006 TO formonly.c_dzga006  
   LET g_dzea003 =''                                
   DISPLAY g_dzea003 TO  formonly.dzea003          
    ##150525-00029#1  add -(e)

   #160921-00012#1 add -(s)
   LET g_lang_str = cl_getmsg("adz-01026",g_lang)
   CALL cl_set_combo_items("gzde_t.gzde006", "1", g_lang_str)   
   LET g_dzga_m.gzde006 = "1"                      
   DISPLAY g_dzga_m.gzde006 TO gzde_t.gzde006 
   #160921-00012#1 add -(e) 
   
   ##150225 mark-(s)
   ##樣板圖片選擇
   #CALL adzp188_temp_type_img()
   ##150225 mark-(e)

   ##自定紙張欄位隱藏
   CALL adzp188_set_field_hide()
   ##150225 mark -(s)
   #DISPLAY g_temp_set.r_detail TO formonly.r_detail
   #DISPLAY g_temp_set.r_povit TO formonly.r_povit
   #DISPLAY g_temp_set.r_tree TO formonly.r_tree
   ##150225 mark -(e)  
   DISPLAY g_temp_set.c_subrep TO formonly.c_subrep
   DISPLAY g_temp_set.c_master TO formonly.c_master
   DISPLAY g_temp_set.c_chart TO formonly.c_chart   
   
   DISPLAY g_paper_set.r_unit TO formonly.r_unit
   DISPLAY g_paper_set.r_format TO formonly.r_format
   DISPLAY g_paper_set.r_direction TO formonly.r_direction
   DISPLAY g_paper_set.c_std TO formonly.c_std
   DISPLAY g_paper_set.len TO formonly.len
   DISPLAY g_paper_set.width TO formonly.width
   ##查詢報表彙總業籤的總和
   DISPLAY g_gzgg009 TO gzgg_t.gzgg009
   
   
   IF g_paper_set.r_unit ="1" THEN 
      LET g_unit_str = cl_getmsg("adz-00252",g_lang)  #公分
   ELSE 
      LET g_unit_str = cl_getmsg("adz-00253",g_lang)  #英吋
   END IF 
   CALL adzp188_all_unit_set(g_unit_str)
   ##設定邊界
   LET g_margin_tb = 1.30  #上下
   LET g_margin_lr = 1.60  #左右
   CALL adzp188_set_margin(g_margin_lr,g_margin_tb)
   ##140117 --(s)


   
   ##預設GR群組頁籤的印出是ORDER EXTERNAL BY
   LET g_dzge005 = "1"
   DISPLAY g_dzge005 TO formonly.r_dzge005
   #tablelist初始值

   LET g_gzzo001 = "APM"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzzo001
   CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_lang||"'","") RETURNING g_rtn_fields
   DISPLAY g_rtn_fields[1] TO formonly.gzzo001_desc
   CALL adzp188_tablelist_b_fill(g_gzzo001)


   ##140416先將join上面的配置區塊隱藏
   CALL gfrm_curr.setElementHidden("hbox2", TRUE) 
   CALL gfrm_curr.setElementHidden("grid23", TRUE) 
   ##140502備註與簽核是預設皆要勾選，畫面隱藏
   CALL gfrm_curr.setElementHidden("formonly.c_signoff", TRUE)  
   CALL gfrm_curr.setElementHidden("formonly.c_memosubrep", TRUE)        
   #CALL gfrm_curr.setElementHidden("formonly.c_detailtable", TRUE)  
   ##150323 add -(s)
   #顯示報表名稱
   CALL adzp188_display_dzga004()
   CALL gfrm_curr.setElementHidden("gen_4rp", 1)  ##預設時先將此按鈕變隱藏
   ##150323 add -(e) 
END FUNCTION


################################################################################
# Descriptions...: 畫面給預設值
# Memo...........: 
# Usage..........: CALL adzp188_set_init_data() 
# Input parameter: None
# Return code....: 
# Date & Author..: 2014/05/27
# Modify.........:
################################################################################
FUNCTION adzp188_set_init_data()

  #動態產生模組代碼
   CALL cl_set_combo_module("gzzo001",1)

   #動態產生欄位頁簽中的-自訂欄位資料表選項 跟第一次的欄位選項
   #CALL adzp188_set_table_comboitems("formonly.dzgd004_1", FALSE) RETURNING g_dzgd004_1                       ##150212 mark
   #LET g_dzgd004_1 = "type_t"   #重設預設值   #160921-00012#1 mark
   #CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, FALSE) RETURNING g_dzgd004_2           ##150212 mark
   #LET g_dzgd004_2 = "num5"     #重設預設值   ##140513 mark 改成chr30  #160921-00012#1 mark
   #LET g_dzgd004_2 = "chr30"     #重設預設值    ##140513 add
   LET g_dzgd006_1 = "1"     #重設預設值

   #開立所有設計資料的TEMPTABLE
   CALL adzp188_create_design_temptable()

   ##樣板設定按鍵 顏色的設定(搭配4st)
   #CALL gfrm_curr.setElementStyle("rpt_model_setting", "reportmainfun1")  #150226 mark
   #CALL ui.Form.setActionActive("add_arrow", TRUE)

   ##顯示GR相關設定  
   CALL adzp188_gr_hidden(FALSE,'')
   ##隱藏XG相關設定 
   CALL adzp188_xg_hidden(TRUE)

   #隱藏"報表資料模型"，只顯示樣板設定
   #CALL gfrm_curr.setElementHidden("vbox17", FALSE)   ##150213 mark
   #CALL gfrm_curr.setElementHidden("folder1", TRUE)   ##150213 mark

   #參數個數
   LET g_arg =""  

    
   ##XG樣板設定單位
   ##140117 --(s)
   ##150226 mark -(s)
   #LET g_temp_set.r_detail = "1"
   #LET g_temp_set.r_povit = ""
   #LET g_temp_set.r_tree = ""
   ##150226 mark -(e)
   LET g_temp_set.c_subrep = "N"
   LET g_temp_set.c_master = "N"
   LET g_temp_set.c_chart = "N"
   ##GR樣板設定單位
   ##150226 mark -(s)
   #LET g_gr_temp_set.r_voucher = "1"
   #LET g_gr_temp_set.r_label = ""
   #LET g_gr_temp_set.r_overlay = ""
   ##150226 mark -(e)
   LET g_gr_temp_set.c_detailrow = 1
   LET g_gr_temp_set.c_masterzone =1
   LET g_gr_temp_set.c_memosubrep = "Y"
   LET g_gr_temp_set.c_signoff = "Y"
   LET g_gr_temp_set.c_detailtable  = "N"    ##140505單身表格化
   ##紙張設定單位
   LET g_paper_set.r_unit = "1"
   LET g_paper_set.r_direction = "1"
   LET g_paper_set.r_format = "1"
   LET g_paper_set.c_std ="1"
   LET g_paper_set.len = 29.70
   LET g_paper_set.width = 21.00
   LET g_gzgg009 = '0'
   ##紙張方向
   CALL adzp188_direction_img()
   ##150226 mark -(s)
   ##樣板圖片選擇
   #CALL adzp188_temp_type_img()
   ##150226 mark -(e)
   ##自定紙張欄位隱藏
   CALL adzp188_set_field_hide()

   ##150226 mark -(s)
   #DISPLAY g_temp_set.r_detail TO formonly.r_detail
   #DISPLAY g_temp_set.r_povit TO formonly.r_povit
   #DISPLAY g_temp_set.r_tree TO formonly.r_tree
   ##150226 mark -(e)  
   DISPLAY g_temp_set.c_subrep TO formonly.c_subrep
   DISPLAY g_temp_set.c_master TO formonly.c_master
   DISPLAY g_temp_set.c_chart TO formonly.c_chart      
   DISPLAY g_paper_set.r_unit TO formonly.r_unit
   DISPLAY g_paper_set.r_format TO formonly.r_format
   DISPLAY g_paper_set.r_direction TO formonly.r_direction
   DISPLAY g_paper_set.c_std TO formonly.c_std
   DISPLAY g_paper_set.len TO formonly.len
   DISPLAY g_paper_set.width TO formonly.width
   DISPLAY g_gzgg009 TO gzgg_t.gzgg009

   ##150525-00029#1  add -(s)
   LET g_dzga_m.dzga006 = 's'                      
   DISPLAY g_dzga_m.dzga006 TO formonly.c_dzga006  
   LET g_dzea003 = ''                                
   DISPLAY g_dzea003 TO  formonly.dzea003   
  ##150525-00029#1  add -(e) 
   
   IF g_paper_set.r_unit ="1" THEN 
      LET g_unit_str = cl_getmsg("adz-00252",g_lang)  #公分
   ELSE 
      LET g_unit_str = cl_getmsg("adz-00253",g_lang)  #英吋
   END IF 
   CALL adzp188_all_unit_set(g_unit_str)
   ##設定邊界
   LET g_margin_tb = 1.30  #上下
   LET g_margin_lr = 1.60  #左右
   CALL adzp188_set_margin(g_margin_lr,g_margin_tb)
   ##140117 --(s)

   ##預設GR群組頁籤的印出是ORDER EXTERNAL BY
   LET g_dzge005 = "1"
   DISPLAY g_dzge005 TO formonly.r_dzge005
   #tablelist初始值
   LET g_gzzo001 = "APM"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzzo001
   CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_lang||"'","") RETURNING g_rtn_fields
   DISPLAY g_rtn_fields[1] TO formonly.gzzo001_desc
   CALL adzp188_tablelist_b_fill(g_gzzo001)


   ##140416先將join上面的配置區塊隱藏
   CALL gfrm_curr.setElementHidden("hbox2", TRUE) 
   CALL gfrm_curr.setElementHidden("grid23", TRUE) 
   ##140502備註與簽核是預設皆要勾選，畫面隱藏
   CALL gfrm_curr.setElementHidden("formonly.c_signoff", TRUE)  
   CALL gfrm_curr.setElementHidden("formonly.c_memosubrep", TRUE)        
   #CALL gfrm_curr.setElementHidden("formonly.c_detailtable", TRUE)    
   ##150319 add-(s)
   LET g_lang_str = cl_getmsg("adz-00238",g_lang)
   CALL cl_set_combo_items("dzga_t.dzga004", "1", g_lang_str)     
   ##150303 add- 調整只有憑證，拿掉套表/標籤(e)     
   LET g_dzga_m.dzga004 = "1"
   DISPLAY g_dzga_m.dzga004 TO dzga_t.dzga004
   ##顯示圖片
   CALL adzp188_direction_img()
      
   ##憑證說明
   CALL gfrm_curr.setElementText("lbl_temptype",cl_getmsg("adz-00547",g_lang))
   CALL adzp188_display_dzga004()
   ##150319 add-(e)

   CALL gfrm_curr.setElementHidden("gen_4rp", 1)  ##預設時先將此按鈕變隱藏
   #160921-00012#1 add -(s)
   LET g_lang_str = cl_getmsg("adz-01026",g_lang)
   CALL cl_set_combo_items("gzde_t.gzde006", "1", g_lang_str)   
   LET g_dzga_m.gzde006 = "1"                      
   DISPLAY g_dzga_m.gzde006 TO gzde_t.gzde006 
   #160921-00012#1 add -(e)    

END FUNCTION


################################################################################
# Descriptions...: ALM檢查
# Memo...........: 
# Usage..........: CALL adzp188_chd_alm() RETURNING li_result
# Input parameter: None
# Return code....: li_result   是否能進行此報表元件的修改
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_chk_alm()
   DEFINE li_result   LIKE type_t.num5
 
   #LET g_erpalm = FGL_GETENV("ERPALM")
   LET g_erpalm = FGL_GETENV("TOPALM")     #2015/05/18 改讀取環境變數
   LET li_result = TRUE   #預設通過ALM

   IF g_erpalm = "Y" THEN
      #輸入報表元件代號後, 進行ALM檢查機制
      #這時候應該可以取得能夠寫的版次, 如果不行, 出現錯誤訊息, 重新輸入可維護報表元件代號
      #SELECT dzlm005 FROM dzlm_t....WHERE 建構代號=g_dzga_m.dzga001
      #暫時都先以第一版次為主
      LET g_dzga_m.dzga002 = "1"
   ELSE
      LET g_dzga_m.dzga002 = "1"
   END IF

   RETURN li_result

END FUNCTION


################################################################################
# Descriptions...: 設定GR頁籤及相關設定隱藏/顯示
# Memo...........: 
# Usage..........: CALL adzp188_gr_hidden(TRUE,'')
# Input parameter: ps_hidden    TRUE:隱藏/FALSE:顯示
# ...............: ps_cmd       判斷沒預設資料或重新參考資料時才顯示page_type1
# Return code....: 
# Date & Author..: 2014/02/26
# Modify.........:
################################################################################
FUNCTION adzp188_gr_hidden(ps_hidden,ps_cmd)
   DEFINE ps_hidden LIKE type_t.num5
   DEFINE ps_cmd    STRING 
   DEFINE l_cnt     LIKE type_t.num5

   
   #先隱藏gr群組
   CALL gfrm_curr.setElementHidden("page_group1", ps_hidden )
   #隱藏gr樣板相關設定
   #CALL gfrm_curr.setElementHidden("hbox16", ps_hidden )  ##150213 mark
   #CALL gfrm_curr.setElementHidden("hbox16", TRUE )   ##150213 add   ##150226 mark 
   #隱藏gr排版   
   ##排版頁籤只出現在第一次或有預設資料又重新讀取參考程式資料時，又重開放並將畫面清空
   ##若排版頁籤無資料，則顯示頁籤140421
 

   

   CALL gfrm_curr.setElementHidden("page_type1", ps_hidden )
   ##隱藏xg排版  
   CALL gfrm_curr.setElementHidden("page_type", NOT ps_hidden )
   ##隱藏xg排名次
   CALL gfrm_curr.setElementHidden("page_order", NOT ps_hidden)   #140521 先都隱藏
   ##隱藏xg圖形
   CALL gfrm_curr.setElementHidden("page_chart", NOT ps_hidden)   #140521 先都隱藏
   ##隱藏xg主題
   CALL gfrm_curr.setElementHidden("page_theme", NOT ps_hidden)   #140521 先都隱藏    #END IF 

   ##隱藏xg版面邊界
   #CALL gfrm_curr.setElementHidden("hbox10",  ps_hidden)       #140603 先都隱藏    ##150213 mark
   ##XG的空白
  # CALL gfrm_curr.setElementHidden("hbox21",  ps_hidden)       #140603 先都隱藏    ##150213 mark


   ##150225 add -(s) 
   ##將表格單身化顯示與否
   CALL gfrm_curr.setElementHidden("lbl_masterzone", ps_hidden)
   CALL gfrm_curr.setElementHidden("lbl_detailrow", ps_hidden)
   CALL gfrm_curr.setElementHidden("formonly.c_detailrow", ps_hidden)
   CALL gfrm_curr.setElementHidden("formonly.c_masterzone",  ps_hidden)
   CALL gfrm_curr.setElementHidden("formonly.c_detailtable", ps_hidden)
    ##lbl_temptype 為憑證報表樣板   
   CALL gfrm_curr.setElementText("lbl_temptype",cl_getmsg("adz-00547",g_lang)) 
   ##150225 add -(e)   
END FUNCTION



################################################################################
# Descriptions...: 設定XG頁籤及相關設定隱藏/顯示
# Memo...........: 
# Usage..........: CALL adzp188_xg_hidden(TRUE)
# Input parameter: ps_hidden    TRUE:隱藏/FALSE:顯示
# Return code....: 
# Date & Author..: 2014/02/26
# Modify.........:
################################################################################
FUNCTION adzp188_xg_hidden(ps_hidden)
   DEFINE ps_hidden LIKE type_t.num5 
   #先隱藏xg群組
   CALL gfrm_curr.setElementHidden("page_group", ps_hidden )

   #隱藏xg樣板相關設定
   #CALL gfrm_curr.setElementHidden("hbox11", ps_hidden )  ##150226 mark
   

   ##隱藏xg 彙總   
   CALL gfrm_curr.setElementHidden("page_summary", ps_hidden)
 
   ##隱藏xg排版
   #IF g_temp_set.r_povit ="1" THEN   ##150226 mark
   IF g_dzga_m.dzga004 ="3" THEN    ##150226 add   交叉表
      CALL gfrm_curr.setElementHidden("page_type",  ps_hidden)    #140521 顯示
   ELSE 
      CALL gfrm_curr.setElementHidden("page_type",  1)   #1405527其餘都隱藏
   END IF    

   ##隱藏xg排名次
   CALL gfrm_curr.setElementHidden("page_order", 1)   #140521 先都隱藏
   ##隱藏xg圖形
   CALL gfrm_curr.setElementHidden("page_chart",  1)   #140521 先都隱藏
   ##隱藏xg主題
   CALL gfrm_curr.setElementHidden("page_theme",  1)   #140521 先都隱藏  

   ##隱藏xg版面邊界
   #CALL gfrm_curr.setElementHidden("hbox10",  1)       #140603 先都隱藏  

   ##隱藏xg版面邊界
   CALL gfrm_curr.setElementHidden("temp_setting",  0)       #140603 先都隱藏  #1407822解開 
   CALL gfrm_curr.setElementHidden("group1",  0)       #140603  
     ##XG的空白
   CALL gfrm_curr.setElementHidden("hbox21",  ps_hidden)       #140603 先都隱藏  

   ##150225 add -(s) 
   ##將子報表顯示與否
   CALL gfrm_curr.setElementHidden("formonly.c_subrep", ps_hidden)  
   ##將單頭顯示與否
   CALL gfrm_curr.setElementHidden("formonly.c_master", ps_hidden) 
   ##將圖表顯示與否
   CALL gfrm_curr.setElementHidden("formonly.c_chart", ps_hidden)     
   
   ##lbl_temptype為查詢報表樣板
   CALL gfrm_curr.setElementText("lbl_temptype",cl_getmsg("adz-00548",g_lang))
   ##150225 add -(e)
END FUNCTION


################################################################################
# Descriptions...: 設定樣板設定單位
# Memo...........: 
# Usage..........: CALL adzp188_all_unit_set(g_unit_str)
# Input parameter: ps_unit_str    單位多語言內容
# Return code....: 
# Date & Author..: 2014/01/17
# Modify.........:
################################################################################
FUNCTION adzp188_all_unit_set(ps_unit_str)
   DEFINE ps_unit_str STRING 

   CALL gfrm_curr.setElementText("s_len_unit",ps_unit_str)  
   CALL gfrm_curr.setElementText("s_width_unit",ps_unit_str)  
   CALL gfrm_curr.setElementText("s_left_unit",ps_unit_str)  
   CALL gfrm_curr.setElementText("s_right_unit",ps_unit_str)
   CALL gfrm_curr.setElementText("s_top_unit",ps_unit_str)  
   CALL gfrm_curr.setElementText("s_bot_unit",ps_unit_str)    

END FUNCTION


################################################################################
# Descriptions...: 設定邊界
# Memo...........: 
# Usage..........: CALL adzp188_set_margin(g_margin_lr,g_margin_tb))
# Input parameter: ps_margin_lr    左右邊界
# Input parameter: ps_margin_tb    上下邊界
# Return code....: 
# Date & Author..: 2014/01/17
# Modify.........:
################################################################################
FUNCTION adzp188_set_margin(ps_margin_lr,ps_margin_tb)
   DEFINE ps_margin_lr    LIKE type_t.num15_3
   DEFINE ps_margin_tb    LIKE type_t.num15_3 

   LET g_paper_set.left = ps_margin_lr
   LET g_paper_set.right = ps_margin_lr
   LET g_paper_set.top = ps_margin_tb
   LET g_paper_set.botton = ps_margin_tb
   
   DISPLAY g_paper_set.left TO formonly.left
   DISPLAY g_paper_set.top TO formonly.top
   DISPLAY g_paper_set.botton TO formonly.botton
   DISPLAY g_paper_set.right TO formonly.right   


END FUNCTION


################################################################################
# Descriptions...: 新增/修改 共用輸入函式
# Memo...........: 先做新增功能
# Usage..........: CALL adzp188_input()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_input()
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
            dzgh001          LIKE dzgh_t.dzgh001,
            dzgh002          LIKE dzgh_t.dzgh002,    
            dzgh003          LIKE dzgh_t.dzgh003, 
            id2              LIKE type_t.chr20,  
            pid2             LIKE type_t.chr20,
            idseq2           LIKE type_t.num5,         #欄位順序
            pidseq2          LIKE type_t.num5,         #區塊順序
            pidtype2         LIKE type_t.chr1,         #單頭/單身 
            alias2           LIKE dzgh_t.dzgh009         #表格別名             
            END RECORD 
   DEFINE l_paging_cnt LIKE type_t.num5               ##140606 add  
   DEFINE l_dzgd003_str      STRING                   ##140606 add  
   DEFINE ls_err_msg         STRING                   ##140612 add 
   DEFINE l_dzga001_desc     LIKE gzdel_t.gzdel003    #140710 add
   DEFINE l_arg              LIKE type_t.num5         #140804 add
   DEFINE ls_sql1            STRING                   #1050126 add


   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)  ##150424 add FIELD ORDER FORM

      #主單頭
      INPUT g_dzga_m.dzga001, g_gzza001, g_dzga_m.dzga003, g_dzga_m.dzga004,g_dzga_m.dzga006,g_dzga_m.gzde006    #150525-00029#1 add g_dzga_m.dzga006 #160921-00012#1 add g_dzga_m.gzde006
       FROM dzga_t.dzga001, formonly.gzza001, dzga_t.dzga003, dzga_t.dzga004,formonly.c_dzga006, gzde_t.gzde006  #150525-00029#1 add formonly.c_dzga006  #160921-00012#1 add gzde_t.gzde006
         ATTRIBUTES(WITHOUT DEFAULTS)
         AFTER FIELD dzga001
            IF NOT cl_null(g_dzga_m.dzga001) THEN
               #161215-00029#1 add -(s)
               IF g_dzga_m.dzga001 != g_dzga001_t OR cl_null(g_dzga001_t) THEN
                  #如果改變報表元件, 必須詢問是否存檔
                  IF NOT cl_null(g_dzga001_t) AND g_signout_t ="1" THEN    # 有簽出時才需詢問是否存檔
                     IF cl_ask_confirm_parm("adz-00233", g_dzga001_t) THEN
                        LET g_stus = "old_save"  #儲存舊值
                        CALL adzp188_draft_save()
                     END IF
                  END IF               
                    
                  #先檢查ALM, 並取得可維護的版本
                  IF NOT adzp188_chk_alm() THEN
                     NEXT FIELD dzga001
                  ELSE            
               #161215-00029#1 add -(e)               
                   #判斷輸入的報表元件是否正確
                    ##取得程式類型
                    LET g_prog_type =""
                    LET g_module =""  #140612 增加模組
                    SELECT gzde003,gzde002 INTO g_prog_type,g_module FROM gzde_t 
                     WHERE gzde001 = g_dzga_m.dzga001  ##140523原抓dzge005改抓dzge003  #140612 g_module
                       #AND gzde008 = g_code_ide             #140620 add
                    LET g_module = DOWNSHIFT(g_module)   #140612 增加模組 轉小寫
                    IF g_prog_type="X" THEN  #XG
                       LET g_dzga_m.dzga003 = '2'
                    ELSE #GR
                       IF g_prog_type ="G" THEN 
                          LET g_dzga_m.dzga003 = '1'
                       ELSE 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "adz-00249"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                           NEXT FIELD dzga001                      
                       END IF 
                    END IF                             
                    ##140612 add 判斷是否有簽出 -(s)
                    LET g_signout = 0                                   ##150508 add
                    IF sadzp060_2_have_checked_out(g_dzga_m.dzga001, g_prog_type,"PR",0) IS NOT NULL THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = "adz-00321"
                       LET g_errparam.extend = NULL
                       LET g_errparam.popup = TRUE
                       LET g_errparam.replace[1] = g_dzga_m.dzga001
                       CALL cl_err()
                       
                       ##3個按鈕全隱藏
                       CALL gdig_curr.setActionActive("draft_save", FALSE)
                       CALL gdig_curr.setActionActive("comp_gen", FALSE)
                       CALL gdig_curr.setActionActive("gen_4rp", FALSE)
                       LET g_signout = 0                                   ##150508 add
                    ELSE 
                        #有簽出，3個按鈕全顯示
                        CALL gdig_curr.setActionActive("draft_save", TRUE)
                        CALL gdig_curr.setActionActive("comp_gen", TRUE)
                        CALL gdig_curr.setActionActive("gen_4rp", TRUE)   
                        LET g_signout = 1                                  ##150508 add                
                    END IF                 
                    ##140612 add 判斷是否有簽出 -(e)

                    ##150226 mark -(s) 
                    ##TEMP圖片
                    #CALL adzp188_temp_type_img()     
                    ##150226 mark -(e)
                    DISPLAY g_dzga_m.dzga003 TO dzga_t.dzga003
                   ##161215-00029#1 mark -(s)
                   #IF g_dzga_m.dzga001 != g_dzga001_t OR cl_null(g_dzga001_t) THEN
                      #如果改變報表元件, 必須詢問是否存檔
                      #IF NOT cl_null(g_dzga001_t) THEN
                         #IF cl_ask_confirm_parm("adz-00233", g_dzga001_t) THEN
                         #END IF
                      #END IF               
                        #
                      #先檢查ALM, 並取得可維護的版本
                      #IF NOT adzp188_chk_alm() THEN
                         #NEXT FIELD dzga001
                      #ELSE
                    ##161215-00029#1 mark -(e)    
                      ##140612 add 取得最新版次、客製標示' 錯誤訊息
                      
                      #CALL sadzp060_2_get_code_curr_revision(g_dzga_m.dzga001, g_prog_type, g_module) RETURNING g_ver,g_code_ide,ls_err_msg  #140730 mark
                      CALL cl_adz_get_code_curr_revision(g_dzga_m.dzga001,NULL, g_prog_type) RETURNING g_ver,g_code_ide,ls_err_msg   #140730 add
                      LET g_dzga_m.dzga002 = g_ver 
                      LET gs_ver = g_dzga_m.dzga002 CLIPPED  #140923 elena add
                      LET gs_ver = gs_ver.trim()             #140923 elena add  #141013 mark
                      #140617 add-(e)
                      IF g_code_ide = "s" THEN 
                         #LET g_gzgf003 = "N"   ##141013 mark
                         LET g_gzgf003 = "s"    ##141013 add
                      ELSE 
                         #LET g_gzgf003 = "Y"   ##141013 mark
                         LET g_gzgf003 = "c"    ##141013 add
                      END IF
                     #140617 add-(e) 
                     LET g_dzga_m.dzga006 = g_code_ide                #150525-00029#1 add 客製標示
                     DISPLAY g_dzga_m.dzga006 TO formonly.c_dzga006   #150525-00029#1 add 客製標示
                     CALL cl_set_comp_entry("c_dzga006",FALSE )       #150525-00029#1 add 客製標示
                      IF NOT cl_null(ls_err_msg) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = ls_err_msg
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                      END IF  
                     
                     #通過則帶出預設值
                     ##CALL adzp188_default() RETURNING lc_cmd   ##150506  NO.150507-00002#1 mark 
                     CALL adzp188_default(g_dzga_m.dzga001,gs_ver,g_code_ide,'') RETURNING lc_cmd   ##150506  NO.150507-00002#1 add
                     #這邊要帶出多語言顯示在後面, 但目前不確定在哪裡維護
                     IF g_prog_type ="G" THEN  
                        ##150224 add -(s)
                        ##150303 mark -(s)
                        #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
                        #CALL cl_set_combo_items("dzga_t.dzga004", "1,4,5", g_lang_str)
                        ##150303 mark -(e)
                        ##150303 add- 調整只有憑證，拿掉套表/標籤(s)                  
                        LET g_lang_str = cl_getmsg("adz-00238",g_lang)
                        CALL cl_set_combo_items("dzga_t.dzga004", "1", g_lang_str)     
                        ##150303 add- 調整只有憑證，拿掉套表/標籤(e) 

                        #160921-00012#1 add -(s)
                        LET g_lang_str = cl_getmsg("adz-01026",g_lang)
                        CALL cl_set_combo_items("gzde_t.gzde006", "1", g_lang_str)   
                        #160921-00012#1 add -(e) 
                    
                        CALL gfrm_curr.setElementText("lbl_temptype",cl_getmsg("adz-00547",g_lang))
                        ##150224 add -(e)                     
                        IF lc_cmd=""  OR lc_cmd IS NULL THEN     #150821-00017#1 add 多判斷null
                           LET g_dzga_m.dzga003 = "1"
                           LET g_dzga_m.dzga004 = "1"
                           ##140116先勾選明細圖
                           ##150224 mark-(s)
                           #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
                           #CALL cl_set_combo_items("dzga_t.dzga004", "1,2,3", g_lang_str)
                           #DISPLAY g_dzga_m.dzga004 TO formonly.s_radio_detail
                           ##150224 mark-(e)                   

                        END IF
                                              
                        ##顯示GR相關設定  
                        CALL adzp188_gr_hidden(FALSE,lc_cmd)
                        #先隱藏xg群組
                        CALL adzp188_xg_hidden(TRUE)  
                        ##150323 add -(s)
                        ##讓紙張不變灰階
                        CALL adzp188_set_paper_data(TRUE)
                        CALL gfrm_curr.setElementHidden("gen_4rp", 0)  ##預設時先將此按鈕變隱藏
                        ##150323 add -(e)                        
                     ELSE 
                        ##150224 add -(s)    
                        ##150303 mark -(s)                       
                        #LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang),",",cl_getmsg("adz-00543",g_lang)
                        #CALL cl_set_combo_items("dzga_t.dzga004", "2,3,6", g_lang_str)
                        ##150303 mark -(e)
                        CALL gfrm_curr.setElementText("lbl_temptype",cl_getmsg("adz-00548",g_lang))
                        ##150224 add -(e)   

                          ##150303 add -(s)
                          ##查詢報表只有明細跟交叉，拿掉樹狀表
                          LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang)
                          CALL cl_set_combo_items("dzga_t.dzga004", "2,3", g_lang_str)
                          ##150303 add -(e) 
                          #160921-00012#1 add -(s) 
                          #交叉表有標準、直存暫存檔二個程式樣板
                          LET g_lang_str = cl_getmsg("adz-01026",g_lang),",",cl_getmsg("adz-01027",g_lang)
                          CALL cl_set_combo_items("gzde_t.gzde006", "1,2", g_lang_str)    
                          #160921-00012#1 add -(e)                       
                        IF lc_cmd = ""  OR lc_cmd IS NULL THEN     #150821-00017#1 add 多判斷null
                           LET g_dzga_m.dzga003 = "2"
                           LET g_dzga_m.dzga004 = "2"
                           ##15224 mark -(s)
                           #LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang),",",cl_getmsg("adz-00543",g_lang)
                           #CALL cl_set_combo_items("dzga_t.dzga004", "2,3,6", g_lang_str)
                           ##15224 mark -(e)
                        END IF 
                        ##隱藏GR相關設定  
                        CALL adzp188_gr_hidden(TRUE ,'')
                        #顯示xg群組
                        CALL adzp188_xg_hidden(FALSE)   
                        ##150323 add -(s)
                        ##讓紙張變灰階
                        CALL adzp188_set_paper_data(FALSE)
                        ##150323 add -(e)
                        CALL gdig_curr.setActionActive("gen_4rp", FALSE)  ##150324 查詢報表不用gen 4rp
                     END IF 
                     
                  END IF
                  #160921-00012#1 add -(s) 
                  IF g_dzga_m.gzde006 IS NULL OR g_dzga_m.gzde006 = "" THEN 
                      LET g_dzga_m.gzde006 = "1"            
                  END IF 
                  #160921-00012#1 add -(e)                   
                  DISPLAY g_dzga_m.dzga004 TO dzga_t.dzga004   ##150224 add
                  DISPLAY g_dzga_m.gzde006 TO gzde_t.gzde006   #160921-00012#1 add
                  LET g_dzga001_t = g_dzga_m.dzga001
                  #161215-00029#1 add -(s)
                  LET g_signout_t = g_signout    
                  #161215-00029#1 add -(e)
                  CALL adzp188_display_dzga004()   ##130319 add
                  CALL adzp188_direction_img()     ##150323 add
               END IF
            END IF
            
         AFTER FIELD gzza001
            #帶出程式的多語言顯示在後面
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzza001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            DISPLAY g_rtn_fields[1] TO formonly.gzza001_desc
   
            IF NOT cl_null(g_gzza001) THEN  #參考不是空的
                IF lc_cmd ="u" THEN 
                   IF cl_ask_confirm_parm("adz-00245", g_gzza001) THEN
                      CALL adzp188_ref_prog_data(g_gzza001) RETURNING lc_cmd
                     IF g_prog_type ="G" THEN                         
                        ##顯示GR相關設定  
                        CALL adzp188_gr_hidden(FALSE,lc_cmd)                  
                     END IF 
                   ELSE #按否清除參考程式欄位
                      DISPLAY '' TO formonly.gzza001
                      DISPLAY '' TO formonly.gzza001_desc
                      LET g_gzza001 =''
                      LET g_gzza001_desc=''                      
                   END IF
                ELSE 
                   CALL adzp188_ref_prog_data(g_gzza001) RETURNING lc_cmd
                END IF
            END IF 
           
         ON CHANGE dzga003
            #選擇報表工具後, 改變樣板類型選項
            CASE g_dzga_m.dzga003
               WHEN "1"   #GR
                  ##150224 mark -(s)
                  #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "1,2,3", g_lang_str)
                  ##150224 mark -(e)
                  ##150303 mark -(s)
                  ##150224 add -(s)
                  #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "1,4,5", g_lang_str)
                  ##150224 add -(e)
                  ##150303 mark -(e) 
                  ##150303 add- 調整只有憑證，拿掉套表/標籤(s)                  
                  LET g_lang_str = cl_getmsg("adz-00238",g_lang)
                  CALL cl_set_combo_items("dzga_t.dzga004", "1", g_lang_str)     
                  ##150303 add- 調整只有憑證，拿掉套表/標籤(e)                    
              
               WHEN "2"   #XtraGrid
                  ##150224 mark -(s)
                  #LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "1,2", g_lang_str)
                  ##150224 mark -(e)
                  ##150303 mark -(s)
                  ##150224 add -(s)                           
                  #LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang),",",cl_getmsg("adz-00543",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "2,3,6", g_lang_str)
                  ##150224 add -(e)
                  ##150303 mark -(e) 
                  ##150303 add -(s)
                  ##查詢報表只有明細跟交叉，拿掉樹狀表
                  LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang)
                  CALL cl_set_combo_items("dzga_t.dzga004", "2,3", g_lang_str)
                  ##150303 add -(e)                 
                  
            END CASE
         AFTER FIELD dzga003
            #選擇報表工具後, 改變樣板類型選項
            CASE g_dzga_m.dzga003
               WHEN "1"   #GR
                  ##150224 mark -(s)
                  #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "1,2,3", g_lang_str)
                  ##150224 mark -(e)
                  ##150303 mark-(s)
                  ##150224 add -(s)                  
                  ##憑證/套表/標籤
                  #LET g_lang_str = cl_getmsg("adz-00238",g_lang),",",cl_getmsg("adz-00239",g_lang),",",cl_getmsg("adz-00240",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "1,4,5", g_lang_str)
                  ##150224 add -(e) 
                  ##150303 mark-(e)
                  
                  ##150303 add- 調整只有憑證，拿掉套表/標籤(s)                  
                  LET g_lang_str = cl_getmsg("adz-00238",g_lang)
                  CALL cl_set_combo_items("dzga_t.dzga004", "1", g_lang_str)     
                  ##150303 add- 調整只有憑證，拿掉套表/標籤(e)              

               WHEN "2"   #XtraGrid
                  ##150224 mark -(s)
                  #LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "1,2", g_lang_str)
                  ##150224 mark -(e)
                  ##150303 mark -(s)
                  ##150224 add -(s)                           
                  #LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang),",",cl_getmsg("adz-00543",g_lang)
                  #CALL cl_set_combo_items("dzga_t.dzga004", "2,3,6", g_lang_str)
                  ##150224 add -(e) 
                  ##150303 mark -(e)

                  ##150303 add -(s)
                  ##查詢報表只有明細跟交叉，拿掉樹狀表
                  LET g_lang_str = cl_getmsg("adz-00241",g_lang),",",cl_getmsg("adz-00242",g_lang)
                  CALL cl_set_combo_items("dzga_t.dzga004", "2,3", g_lang_str)
                  ##150303 add -(e)

                  #160921-00012#1 add -(s)                         
                      LET g_lang_str = cl_getmsg("adz-01026",g_lang),",",cl_getmsg("adz-01027",g_lang)
                      CALL cl_set_combo_items("gzde_t.gzde006", "1,2", g_lang_str)   
                  #160921-00012#1 add -(e) 
                  
            END CASE  

        #160921-00012#1 add -(s)
        ON CHANGE gzde006 
           CASE g_dzga_m.dzga003
             WHEN "1"   #GR       
                LET g_lang_str = cl_getmsg("adz-01026",g_lang)
                CALL cl_set_combo_items("gzde_t.gzde006", "1", g_lang_str)  
             WHEN "2" #XG
                LET g_lang_str = cl_getmsg("adz-01026",g_lang),",",cl_getmsg("adz-01027",g_lang)
                CALL cl_set_combo_items("gzde_t.gzde006", "1,2", g_lang_str) 
           END CASE 
        #160921-00012#1 add -(e) 
            
        ##150225 add -(s)    
        ON CHANGE dzga004
            
            IF g_dzga_m.dzga004 = "1" THEN 

                ##憑證紙張只能選A4直、A4橫、A3橫
                IF NOT ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                        (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                        (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2")) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "adz-00281"
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                END IF         
            END IF 
            #顯示報表名稱
            CALL adzp188_display_dzga004()          
            CALL adzp188_direction_img()
            ##150324 add 若改成交叉表要將交叉表頁籤顯示-(s)
            IF g_dzga_m.dzga004 = "3" THEN 
               CALL gfrm_curr.setElementHidden("page_type",  0)   
            END IF 
            ##150324 add 若改成交叉表要將交叉表頁籤顯示-(s)
        ##150225 add -(e)
            
        ##140710 加開窗 -(s)
        ON ACTION controlp INFIELD dzga001  
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzge001_2()
            LET g_dzga_m.dzga001 = g_qryparam.return1
            LET l_dzga001_desc = g_qryparam.return2
            DISPLAY g_dzga_m.dzga001 TO dzga001
            DISPLAY l_dzga001_desc TO formonly.dzga001_desc 
            ###  ### end ###

       ON ACTION controlp INFIELD gzza001   
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzza001_4()
            LET g_gzza001 = g_qryparam.return1
            LET g_gzza001_desc = g_qryparam.return2
            DISPLAY g_gzza001 TO gzza001
            DISPLAY g_gzza001_desc TO formonly.gzza001_desc
            ###  ### end ###        
        ##140710 加開窗 -(e)

        ##150324 add -(s)
        BEFORE INPUT
           CALL gdig_curr.setActionHidden("gen_4rp", 1  )  ##預設時先將此按鈕變隱藏
        ##150324 add -(e)
        
        ##150226 add -(s) 
        AFTER INPUT
            ##憑證一定要設定好紙張格式
            IF g_dzga_m.dzga004 = "1" THEN 
               IF NOT (g_paper_set.r_format = "1" AND ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                       (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                       (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2"))) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00281"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF 
           END IF 
        ##150226 add -(e)   
      END INPUT
      #資料表頁簽-單頭
      #INPUT g_gzzo001 FROM formonly.gzzo001                            #150525-00029#1 mark
      INPUT g_gzzo001,g_dzea003 FROM formonly.gzzo001,formonly.dzea003  #150525-00029#1 add
         ATTRIBUTES(WITHOUT DEFAULTS)
         ON CHANGE gzzo001
            #選擇模組後, 顯示模組多語言名稱
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzzo001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_lang||"'","") RETURNING g_rtn_fields
            DISPLAY g_rtn_fields[1] TO formonly.gzzo001_desc        
            
            #選擇模組後, 即時改變左方資料表列表
            CALL adzp188_tablelist_b_fill(g_gzzo001)
            #為了讓挑選完後直接可以focus到左邊列表的第一筆
            CALL DIALOG.setCurrentRow("s_tablelist",1)
            NEXT FIELD table_list
         #150525-00029#1 add -(s)   
         AFTER FIELD dzea003
            #選擇模組後, 即時改變左方資料表列表
            CALL adzp188_tablelist_b_fill(g_dzea003)
            #為了讓挑選完後直接可以focus到左邊列表的第一筆
            CALL DIALOG.setCurrentRow("s_tablelist",1)
            NEXT FIELD table_list
         #150525-00029#1 add -(e)   
      END INPUT
      #樣板設定 
      #140116 -(s)  140118改到此
      
       INPUT BY NAME g_temp_set.*
         ATTRIBUTES(WITHOUT DEFAULTS)
        ##150226 mark -(s)   
         #ON CHANGE r_detail
            #明細表
            #IF g_temp_set.r_detail = "1" THEN 
                #LET g_temp_set.r_povit = "" 
                #LET g_temp_set.r_tree = "" 
                #LET g_dzga_m.dzga004 ="2" 
                ##140521 add -(s) 
                ##IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="Y" THEN 
                   ##LET g_dzga_m.dzga004 ="4" 
                ##ELSE 
                   ##IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="N" THEN
                      ##LET g_dzga_m.dzga004 ="3" 
                   ##ELSE 
                      ##IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="Y" THEN
                         ##LET g_dzga_m.dzga004 ="2"
                      ##ELSE 
                         ##IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="N" THEN
                            ##LET g_dzga_m.dzga004 ="1"
                         ##END IF 
                      ##END IF 
                   ##END IF 
                ##END IF 
                ###140521 add -(e) 
                #DISPLAY g_temp_set.r_povit TO formonly.r_povit
                #DISPLAY g_temp_set.r_tree TO formonly.r_tree  
            #ELSE 
                #IF (g_temp_set.r_povit = "" AND g_temp_set.r_tree = "") OR (cl_null(g_temp_set.r_povit) AND cl_null(g_temp_set.r_tree)) THEN
                   #LET g_temp_set.r_detail = "1"
                   #LET g_dzga_m.dzga004 ="2" 
                    ##140521 add -(s) 
                    ##IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="Y" THEN 
                       ##LET g_dzga_m.dzga004 ="4" 
                    ##ELSE 
                       ##IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="N" THEN
                          ##LET g_dzga_m.dzga004 ="3" 
                       ##ELSE 
                          ##IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="Y" THEN
                             ##LET g_dzga_m.dzga004 ="2"
                          ##ELSE 
                             ##IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="N" THEN
                                ##LET g_dzga_m.dzga004 ="1"
                             ##END IF 
                          ##END IF 
                       ##END IF 
                    ##END IF 
                    ##140521 add -(e) 
                   #
                   #DISPLAY g_temp_set.r_detail TO formonly.r_detail  
                #END IF 
            #END IF 
            #顯示報表名稱            
            #CALL adzp188_display_dzga004()
            ##140527 隱藏排版
            #CALL gfrm_curr.setElementHidden("page_type",  1)   
          #
         #ON CHANGE r_povit
            #交叉表
            #IF g_temp_set.r_povit = "1" THEN 
                #LET g_temp_set.r_detail = ""
                #LET g_temp_set.r_tree = "" 
                #LET g_dzga_m.dzga004 ="3"                 
                #DISPLAY g_temp_set.r_detail TO formonly.r_detail
                #DISPLAY g_temp_set.r_tree TO formonly.r_tree 
                ##點選後才顯示排版 140521 
                #CALL gfrm_curr.setElementHidden("page_type", FALSE )
            #ELSE 
                #IF (g_temp_set.r_detail ="" AND g_temp_set.r_tree ="") OR (cl_null(g_temp_set.r_detail) AND cl_null(g_temp_set.r_tree)) THEN
                   #LET g_temp_set.r_povit = "1"
                   #LET g_dzga_m.dzga004 ="3" 
                   #DISPLAY g_temp_set.r_povit TO formonly.r_povit  
                #END IF                 
            #END IF 
            #顯示報表名稱
            #CALL adzp188_display_dzga004()
            ##140527 顯示排版
            #CALL gfrm_curr.setElementHidden("page_type",  0)              
          #
         #ON CHANGE r_tree
            #樹狀表
            #IF g_temp_set.r_tree = "1" THEN 
                #LET g_temp_set.r_detail = ""
                #LET g_temp_set.r_povit = ""   
                #LET g_dzga_m.dzga004 ="6"             
                #DISPLAY g_temp_set.r_detail TO formonly.r_detail
                #DISPLAY g_temp_set.r_povit TO formonly.r_povit 
            #ELSE 
                #IF (g_temp_set.r_detail ="" AND g_temp_set.r_povit ="") OR (cl_null(g_temp_set.r_detail) AND cl_null(g_temp_set.r_povit))THEN
                   #LET g_temp_set.r_tree = "1"
                   #LET g_dzga_m.dzga004 ="6"  
                   #DISPLAY g_temp_set.r_tree TO formonly.r_tree  
                #END IF                    
            #END IF    
            #顯示報表名稱
            #CALL adzp188_display_dzga004()   
             ##140527 隱藏排版
            #CALL gfrm_curr.setElementHidden("page_type",  1)  
        ##150226 mark -(e)    
        ##140521 add 報表類型判斷-(s)
        ON CHANGE c_subrep
           ##150226 mark -(s)
            #IF g_temp_set.r_detail = "1" THEN 
                #
                #IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="Y" THEN 
                   #LET g_dzga_m.dzga004 ="4" 
                #ELSE 
                   #IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="N" THEN
                      #LET g_dzga_m.dzga004 ="3" 
                   #ELSE 
                      #IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="Y" THEN
                         #LET g_dzga_m.dzga004 ="2"
                      #ELSE 
                         #IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="N" THEN
                            #LET g_dzga_m.dzga004 ="1"
                         #END IF 
                      #END IF 
                   #END IF 
                #END IF        
             #END IF 
             #DISPLAY g_temp_set.c_subrep TO formonly.c_subrep 
           ##150226 mark -(e)  
        ON CHANGE c_master
           ##150226 mark -(s)
            #IF g_temp_set.r_detail = "1" THEN 
                #
                #IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="Y" THEN 
                   #LET g_dzga_m.dzga004 ="4" 
                #ELSE 
                   #IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="N" THEN
                      #LET g_dzga_m.dzga004 ="3" 
                   #ELSE 
                      #IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="Y" THEN
                         #LET g_dzga_m.dzga004 ="2"
                      #ELSE 
                         #IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="N" THEN
                            #LET g_dzga_m.dzga004 ="1"
                         #END IF 
                      #END IF 
                   #END IF 
                #END IF        
             #END IF 
             #DISPLAY g_temp_set.c_master TO formonly.c_master 
        
            ##150226 mark -(e)
        ##140521 add 報表類型判斷-(e)
           
      END INPUT     

     ## 
     INPUT BY NAME g_paper_set.*
         ATTRIBUTES(WITHOUT DEFAULTS)
         
         ON CHANGE r_unit
               IF g_paper_set.r_unit = "1" THEN 
                  LET g_unit_str = cl_getmsg("adz-00252",g_lang)  #公分
               ELSE 
                     LET g_unit_str = cl_getmsg("adz-00253",g_lang)  #英吋                  
               END IF 
               CALL adzp188_all_unit_set(g_unit_str)
               CALL adzp188_display_dzga004() ##150303 add

        ON CHANGE r_direction    
              IF g_paper_set.r_format = "1" THEN  #選標準"
                 IF g_paper_set.c_std = "1" THEN  #A4
                    IF g_paper_set.r_direction = "1" THEN #直向
                       LET g_paper_set.len = 29.70
                       LET g_paper_set.width = 21.00
                    ELSE 
                       LET g_paper_set.len = 21.00 
                       LET g_paper_set.width = 29.70                  
                    END IF               
                 ELSE   #A3
                    IF g_paper_set.r_direction = "1" THEN  #直向
                       LET g_paper_set.len = 42.00
                       LET g_paper_set.width = 29.70
                    ELSE 
                       LET g_paper_set.len = 29.70 
                       LET g_paper_set.width = 42.00                  
                    END IF                      
                 END IF  
                 LET g_paper_set.custom = ""               
              ELSE ##點選客製
                 LET g_paper_set.len = "" 
                 LET g_paper_set.width = ""              
              END IF 
              CALL adzp188_set_field_hide()  #客製欄位不能輸入
              DISPLAY g_paper_set.len TO formonly.len
              DISPLAY g_paper_set.width TO formonly.width      

              CALL adzp188_direction_img()
              ##140505 -(s)  ##憑證紙張只能選A4直、A4橫、A3橫
              #IF g_gr_temp_set.r_voucher = "1" THEN   ##150226 mark
              IF g_dzga_m.dzga004 = "1" THEN    ##150226 add
                 IF NOT (g_paper_set.r_format = "1" AND ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                         (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                         (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2"))) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "adz-00281"
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = FALSE
                    CALL cl_err()
                 END IF                  
              END IF  
              ##140505 -(e)               

        ON CHANGE r_format
              IF g_paper_set.r_format = "1" THEN  #選標準"
                 IF g_paper_set.c_std = "1" THEN  #A4
                    IF g_paper_set.r_direction = "1" THEN #直向
                       LET g_paper_set.len = 29.70
                       LET g_paper_set.width = 21.00
                    ELSE 
                       LET g_paper_set.len = 21.00 
                       LET g_paper_set.width = 29.70                  
                    END IF               
                 ELSE   #A3
                    IF g_paper_set.r_direction = "1" THEN  #直向
                       LET g_paper_set.len = 42.00
                       LET g_paper_set.width = 29.70
                    ELSE 
                       LET g_paper_set.len = 29.70 
                       LET g_paper_set.width = 42.00                  
                    END IF                      
                 END IF
                 LET g_paper_set.custom = ""
              ELSE ##點選客製
                 LET g_paper_set.len = "" 
                 LET g_paper_set.width = ""              
              END IF 
              CALL adzp188_set_field_hide()  #客製欄位不能輸入
              DISPLAY g_paper_set.len TO formonly.len
              DISPLAY g_paper_set.width TO formonly.width
              ##140505 -(s)  ##憑證紙張只能選A4直、A4橫、A3橫
              #IF g_gr_temp_set.r_voucher = "1" THEN   ##150226 mark
              IF g_dzga_m.dzga004 = "1" THEN    ##150226 add
                 IF NOT (g_paper_set.r_format = "1" AND ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                         (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                         (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2"))) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "adz-00281"
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = FALSE
                    CALL cl_err()
                 END IF                  
              END IF  
              ##140505 -(e)     
              CALL adzp188_display_dzga004() ##150303 add         

        ON CHANGE c_std
              IF g_paper_set.r_format = "1" THEN  #選標準"
                 IF g_paper_set.c_std = "1" THEN  #A4
                    IF g_paper_set.r_direction = "1" THEN #直向
                       LET g_paper_set.len = 29.70
                       LET g_paper_set.width = 21.00
                    ELSE 
                       LET g_paper_set.len = 21.00 
                       LET g_paper_set.width = 29.70                  
                    END IF               
                 ELSE   #A3
                    IF g_paper_set.r_direction = "1" THEN  #直向
                       LET g_paper_set.len = 42.00
                       LET g_paper_set.width = 29.70
                    ELSE 
                       LET g_paper_set.len = 29.70 
                       LET g_paper_set.width = 42.00                   
                    END IF                      
                 END IF
                 ##140505 -(s)  ##憑證紙張只能選A4直、A4橫、A3橫
                 #IF g_gr_temp_set.r_voucher = "1" THEN  ##150226 mark
                 IF g_dzga_m.dzga004 = "1" THEN   ##150226 add
                    IF NOT (g_paper_set.r_format = "1" AND ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                            (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                            (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2"))) THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = "adz-00281"
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                    END IF                  
                 END IF  
                 ##140505 -(e)
                 LET g_paper_set.custom = ""
                 CALL adzp188_set_field_hide()  #客製欄位不能輸入
              ELSE ##點選客製
                 CALL adzp188_set_field_hide()
                 LET g_paper_set.len = "" 
                 LET g_paper_set.width = ""  
                 
              END IF 
              
              DISPLAY g_paper_set.len TO formonly.len
              DISPLAY g_paper_set.width TO formonly.width              

        ON CHANGE c_custom
              ##140505 -(s)  ##憑證紙張只能選A4直、A4橫、A3橫
              #IF g_gr_temp_set.r_voucher = "1" THEN    ##150226 mark
              IF g_dzga_m.dzga004 = "1" THEN            ##150226 add    
                 IF NOT (g_paper_set.r_format = "1" AND ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                         (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                         (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2"))) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "adz-00281"
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = FALSE
                    CALL cl_err()
                 END IF                  
              END IF  
              ##140505 -(e)         
         
        AFTER INPUT 
           ##若選自定義紙張，長寬必需輸入 
           IF g_paper_set.r_format = "2" THEN  #非選標準
               IF (cl_null(g_paper_set.len) OR cl_null(g_paper_set.width)) OR 
                  (g_paper_set.len <= 0 OR g_paper_set.width <= 0) OR 
                  (g_paper_set.len IS NULL OR g_paper_set.width IS NULL)
               THEN
                   NEXT FIELD len
               END IF 
           END IF
           ##140505 -(s) ##憑證紙張只能選A4直、A4橫、A3橫
           #IF g_gr_temp_set.r_voucher = "1" THEN  ##150226 mark
           IF g_dzga_m.dzga004 = "1" THEN   ##150226 add
               IF NOT (g_paper_set.r_format = "1" AND ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                       (g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                       (g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2"))) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00281"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF 
           END IF 
           ##140505 -(e) 
           
           ##邊界不可為空或負數 
           IF cl_null(g_paper_set.left)  OR g_paper_set.left < 0  THEN 
               NEXT FIELD left
           END IF 
           IF cl_null(g_paper_set.right) OR g_paper_set.right < 0 THEN 
               NEXT FIELD right
           END IF 
           IF cl_null(g_paper_set.top) OR g_paper_set.top < 0  THEN 
               NEXT FIELD top
           END IF 
           IF cl_null(g_paper_set.botton) OR  g_paper_set.botton < 0 THEN 
               NEXT FIELD botton
           END IF            
      END INPUT          

     ##GR的樣板設定
     INPUT BY NAME g_gr_temp_set.*
         ATTRIBUTES(WITHOUT DEFAULTS)
         ##150226 mark -(s)
         #ON CHANGE r_voucher
            ##憑證
            #IF g_gr_temp_set.r_voucher = "1" THEN 
                #LET g_gr_temp_set.r_label = "" 
                #LET g_gr_temp_set.r_overlay = ""  
                #LET g_dzga_m.dzga004 ="1"      
                #DISPLAY g_gr_temp_set.r_label TO formonly.r_label
                #DISPLAY g_gr_temp_set.r_overlay TO formonly.r_overlay 
                ##140505 -(s) ##憑證紙張只能選A4直、A4橫、A3橫
                #IF NOT ((g_paper_set.c_std ="1" AND g_paper_set.r_direction ="1") OR 
                        #(g_paper_set.c_std ="1" AND g_paper_set.r_direction ="2") OR 
                        #(g_paper_set.c_std ="2" AND g_paper_set.r_direction ="2")) THEN
                   #INITIALIZE g_errparam TO NULL
                   #LET g_errparam.code = "adz-00281"
                   #LET g_errparam.extend = ''
                   #LET g_errparam.popup = FALSE
                   #CALL cl_err()
                #END IF          
                ##140505 -(e)                   
            #ELSE 
                #IF (g_gr_temp_set.r_label = "" AND g_gr_temp_set.r_overlay = "") OR (cl_null(g_gr_temp_set.r_label) AND cl_null(g_gr_temp_set.r_overlay)) THEN
                   #LET g_gr_temp_set.r_voucher = "1"
                   #LET g_dzga_m.dzga004 ="1" 
                   #DISPLAY g_gr_temp_set.r_voucher TO formonly.r_voucher  
                #END IF 
            #END IF 
            ##顯示報表名稱
            #CALL adzp188_display_dzga004()              
          #
         #ON CHANGE r_label
            ##標籤
            #IF g_gr_temp_set.r_label = "1" THEN 
                #LET g_gr_temp_set.r_voucher = ""
                #LET g_gr_temp_set.r_overlay = ""   
                #LET g_dzga_m.dzga004 ="4"               
                #DISPLAY g_gr_temp_set.r_voucher TO formonly.r_voucher
                #DISPLAY g_gr_temp_set.r_overlay TO formonly.r_overlay 
            #ELSE 
                #IF (g_gr_temp_set.r_voucher ="" AND g_gr_temp_set.r_overlay ="") OR (cl_null(g_gr_temp_set.r_voucher) AND cl_null(g_gr_temp_set.r_overlay)) THEN
                   #LET g_gr_temp_set.r_label = "1"
                   #LET g_dzga_m.dzga004 ="4"  
                   #DISPLAY g_gr_temp_set.r_label TO formonly.r_label  
                #END IF                 
            #END IF 
            ##顯示報表名稱
            #CALL adzp188_display_dzga004()              
          #
         #ON CHANGE r_overlay
            ##套表
            #IF g_gr_temp_set.r_overlay = "1" THEN 
                #LET g_gr_temp_set.r_voucher = ""
                #LET g_gr_temp_set.r_label = "" 
                #LET g_dzga_m.dzga004 ="5"                
                #DISPLAY g_gr_temp_set.r_voucher  TO formonly.r_voucher
                #DISPLAY g_gr_temp_set.r_label TO formonly.r_label 
            #ELSE 
                #IF (g_gr_temp_set.r_voucher ="" AND g_gr_temp_set.r_label ="") OR (cl_null(g_gr_temp_set.r_voucher) AND cl_null(g_gr_temp_set.r_label))THEN
                   #LET g_gr_temp_set.r_overlay = "1"
                   #LET g_dzga_m.dzga004 ="5"   
                   #DISPLAY g_gr_temp_set.r_overlay TO formonly.r_overlay  
                #END IF                    
            #END IF    
            ##顯示報表名稱
            #CALL adzp188_display_dzga004() 
         ##150226 mark -(e) 

            
         ON CHANGE c_masterzone
            CALL adzp188_maintain_type2_pid()  #150807-00006 mark

         ON CHANGE c_detailrow
            CALL adzp188_maintain_type2_pid()  ##150807 mark
            IF g_gr_temp_set.c_detailtable = "Y" THEN
               LET g_gr_temp_set.c_detailrow = "1" 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00283"
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
            END IF             

         ON CHANGE c_detailtable
            IF g_gr_temp_set.c_detailtable = "Y" THEN
               LET g_gr_temp_set.c_detailrow = "1" 
            END IF 
                

         AFTER INPUT 
            ##判斷若未輸入單頭/單身
            IF g_gr_temp_set.c_masterzone ="" OR cl_null(g_gr_temp_set.c_masterzone) THEN 
               LET g_gr_temp_set.c_masterzone = 1
               DISPLAY g_gr_temp_set.c_masterzone TO formonly.c_masterzone
            END IF 
            IF g_gr_temp_set.c_detailrow ="" OR cl_null(g_gr_temp_set.c_detailrow) THEN 
               LET g_gr_temp_set.c_detailrow = 1
               DISPLAY g_gr_temp_set.c_detailrow TO formonly.c_detailrow
            END IF             
      END INPUT  
      
      
      #140116 -(e)


      
      #資料表頁簽-單身*2
      DISPLAY ARRAY g_tablelist TO s_tablelist.* ATTRIBUTES(COUNT=g_tablelist.getLength())
         BEFORE DISPLAY
            #是否有資料, 開關功能鍵
            CALL adzp188_set_action_active_by_datasize("s_tablelist", "add_table")
            
         BEFORE ROW
            #選到的Table如果已經存在已選資料表清單, 就不要出現增加功能鍵
            IF adzp188_check_table_repeat(DIALOG.getCurrentRow("s_tablelist")) THEN
               CALL gdig_curr.setActionActive("add_table", FALSE)
            ELSE
               CALL gdig_curr.setActionActive("add_table", TRUE)
            END IF

         #拖拉方式增加, 結束動作在s_tablesel的ON DROP
         ON DRAG_START(dnd)
            #判斷選到的Table是否已經存在已選資料表清單
            IF adzp188_check_table_repeat(DIALOG.getCurrentRow("s_tablelist")) THEN
               #標註拖拉功能的處理方法,NULL(不做),move(搬移),copy(複製)
               CALL dnd.setOperation(NULL)
            ELSE
               #啟動拖拉時,標定s_tablelist為起始區 
               LET ls_area = "s_tablelist"
            END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, 啟動動作在s_tablesel
         ON DROP(dnd)
            IF ls_area = "s_tablesel" THEN
               CALL dnd.dropInternal()
               CALL adzp188_choose_table(DIALOG.getCurrentRow("s_tablesel"), "del")
               CALL adzp188_refresh_seq("s_tablesel")    
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablesel", "del_table")
            END IF

         #功能鍵方式增加
         ON ACTION add_table
            IF NOT adzp188_check_table_repeat(DIALOG.getCurrentRow("s_tablelist")) THEN
               CALL adzp188_choose_table(DIALOG.getCurrentRow("s_tablelist"), "add")
                ##s_tablesel #140205
               CALL adzp188_refresh_seq("s_tablesel")
            END IF
            
      END DISPLAY
      
      DISPLAY ARRAY g_tablesel TO s_tablesel.* ATTRIBUTES(COUNT=g_tablesel.getLength())
         BEFORE DISPLAY
            #是否有資料, 開關功能鍵
            CALL adzp188_set_action_active_by_datasize("s_tablesel", "del_table")

         ON DRAG_START(dnd)
            LET ls_area = "s_tablesel"

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式增加
         ON DROP(dnd)
            IF ls_area = "s_tablelist" THEN
               CALL dnd.dropInternal()
               CALL adzp188_choose_table(DIALOG.getCurrentRow("s_tablelist"), "add")
               #增加完後, 因為指標還停留在原位置, 所以關閉增加功能鍵
               CALL gdig_curr.setActionActive("add_table", FALSE)
            END IF

         #功能鍵方式刪除
         ON ACTION del_table
            CALL adzp188_choose_table(DIALOG.getCurrentRow("s_tablesel"), "del")
            ##s_tablesel #140205
            CALL adzp188_refresh_seq("s_tablesel")
            #如果都刪光了, 就不要出現刪除功能鍵
            CALL adzp188_set_action_active_by_datasize("s_tablesel", "del_table")

         ON ACTION up_tableseq
            CALL adzp188_move_up_down("s_tablesel", "up")
            LET g_table_idx = DIALOG.getCurrentRow("s_tablesel")
            IF g_table_idx = 2 THEN CALL adzp188_get_d_reference_join(g_tablesel[g_table_idx].id) END IF  
            
         ON ACTION down_tableseq
            CALL adzp188_move_up_down("s_tablesel", "down")
            LET g_table_idx = DIALOG.getCurrentRow("s_tablesel")
            IF g_table_idx = 2 THEN CALL adzp188_get_d_reference_join(g_tablesel[g_table_idx].id) END IF  
            
      END DISPLAY
      
      #連結頁簽-單頭*2
      INPUT g_dzgb_d.dzgb004, g_dzgb_d.dzgb005, g_dzgb_d.dzgb007, g_dzgb_d.dzgb008, g_dzgb_d.dzgb009
       FROM dzgb_t.dzgb004, dzgb_t.dzgb005, dzgb_t.dzgb007, dzgb_t.dzgb008, dzgb_t.dzgb009
         ATTRIBUTES(WITHOUT DEFAULTS)
         ON CHANGE dzgb004 #131219
            IF g_dzgb_d.dzgb004 = "Y" THEN LET g_dzgb_d.dzgb008 = "N" END IF 
         ON CHANGE dzgb005
            #改變g_tablejoin1列表資料
            CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin1", g_dzgb_d.dzgb005)
         ON CHANGE dzgb008 #131219
            IF g_dzgb_d.dzgb008 = "Y" THEN LET g_dzgb_d.dzgb004 = "N" END IF             
         ON CHANGE dzgb009
            #改變g_tablejoin2列表資料
            CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin2", g_dzgb_d.dzgb009)
         ON ACTION add_tablejoin
            CALL adzp188_maintain_dzgb("","add")
         ON ACTION upd_tablejoin
            CALL adzp188_maintain_dzgb(g_join_idx,"upd")
      END INPUT
      #連結頁簽-單身*2
      DISPLAY ARRAY g_tablejoin1 TO s_tablejoin1.* ATTRIBUTES(COUNT=g_tablejoin1.getLength())
         ON ACTION add_tablejoin
            CALL adzp188_maintain_dzgb("","add")
         ON ACTION upd_tablejoin
            CALL adzp188_maintain_dzgb(g_join_idx,"upd")
      END DISPLAY
      
      DISPLAY ARRAY g_tablejoin2 TO s_tablejoin2.* ATTRIBUTES(COUNT=g_tablejoin2.getLength())
         ON ACTION add_tablejoin
            CALL adzp188_maintain_dzgb("","add")
         ON ACTION upd_tablejoin
            CALL adzp188_maintain_dzgb(g_join_idx,"upd")
      END DISPLAY
      #連結頁簽-wc單身

      DISPLAY ARRAY g_join TO s_join.* ATTRIBUTES(COUNT=g_join.getLength())
         BEFORE DISPLAY
            CALL adzp188_set_seqaction_active("s_join", "up_joinseq", "down_joinseq")
            CALL adzp188_set_action_active_by_datasize("s_join", "del_tablejoin")
            #設定wc顏色
            CALL DIALOG.setArrayAttributes("s_join", g_join1)  
         BEFORE ROW
            LET g_join_idx = DIALOG.getCurrentRow("s_join")
            CALL adzp188_separate_join_wc(g_join_idx)
            CALL adzp188_set_seqaction_active("s_join", "up_joinseq", "down_joinseq")
            CALL adzp188_set_action_active_by_datasize("s_join", "del_tablejoin")
            #設定wc顏色
            CALL DIALOG.setArrayAttributes("s_join", g_join1)  
         ON ACTION del_tablejoin
            CALL adzp188_maintain_dzgb(g_join_idx,"del")
            CALL adzp188_refresh_seq("s_join")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_join_idx > g_join.getLength() THEN
               CALL DIALOG.setCurrentRow("s_join", g_join.getLength())
               LET g_join_idx = DIALOG.getCurrentRow("s_join")
            END IF
            CALL adzp188_separate_join_wc(g_join_idx)
            CALL adzp188_set_seqaction_active("s_join", "up_joinseq", "down_joinseq")
            CALL adzp188_set_action_active_by_datasize("s_join", "del_tablejoin")
         ON ACTION up_joinseq
            CALL adzp188_move_up_down("s_join", "up")
            LET g_join_idx = DIALOG.getCurrentRow("s_join")
         ON ACTION down_joinseq
            CALL adzp188_move_up_down("s_join", "down")
            LET g_join_idx = DIALOG.getCurrentRow("s_join")
      END DISPLAY


      #欄位頁簽-樹狀
      DISPLAY ARRAY g_fieldlist TO s_fieldlist.* ATTRIBUTES(COUNT=g_fieldlist.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_fieldlist", 1)
            CALL adzp188_set_action_active_by_datasize("s_fieldlist", "add_field")
         BEFORE ROW
            LET g_fieldlist_idx = DIALOG.getCurrentRow("s_fieldlist")
            #是Table的話, 不給多選
            IF g_fieldlist[g_fieldlist_idx].isnode THEN
               CALL DIALOG.setSelectionMode("s_fieldlist", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_fieldlist", 1)
            END IF
           
         #功能鍵方式增加
         ON ACTION add_field
            #CALL adzp188_maintain_dzgc(g_fieldlist_idx, "N", "add")  #150525-00029#1 mark
            CALL adzp188_maintain_dzgc(g_fieldsel_idx, "N", "add")    #150525-00029#1  add
            CALL adzp188_refresh_seq("s_fieldsel")                    #150807-00006 add
      END DISPLAY
      
      #欄位頁簽-已選欄位列表

      INPUT ARRAY g_fieldsel FROM s_fieldsel.*
         ATTRIBUTES(COUNT=g_fieldsel.getLength(), MAXCOUNT=g_fieldsel.getLength(), WITHOUT DEFAULTS,
                    INSERT ROW = FALSE, DELETE ROW = FALSE, APPEND ROW = FALSE)
         BEFORE INPUT
            CALL adzp188_set_seqaction_active("s_fieldsel", "up_fieldseq", "down_fieldseq")
            CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_field")
            CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_userfield")

         BEFORE ROW
            LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")
            CALL adzp188_set_seqaction_active("s_fieldsel", "up_fieldseq", "down_fieldseq")
            CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_field")
            CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_userfield")

           
            ##視資料為標準欄位或自訂欄位, 顯示不同的刪除功能鍵
            CALL adzp188_set_fielddelete_active()
         ON CHANGE dzgc005_1
            ##140401 判斷主表7個保留字不能將dzgc005_1取消(S)            
            IF NOT adzp188_chk_main_table_suffix(g_fieldsel[g_fieldsel_idx].dzgc004) THEN                         
               ##是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
               CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "upd")
            ELSE 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00272"
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               #重整
               CALL adzp188_fieldsel_b_fill()
            END IF 
            ##140401 判斷主表7個保留字不能將dzgc005_1取消(E)
            ##是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            #CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "upd") #140401 MARK
            
         ON CHANGE dzgc005_2
            ##是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "upd")

         ON CHANGE dzgc_chk
           LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")

           #AFTER ROW
            ##是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            #CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "upd")
         ##功能鍵方式刪除
         ON ACTION del_field
            ##140401 判斷主表7個保留字不能將dzgc005_1取消(S)            
            IF NOT adzp188_chk_main_table_suffix(g_fieldsel[g_fieldsel_idx].dzgc004) THEN                         
               ##是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
                CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "del")
                CALL adzp188_refresh_seq("s_fieldsel")
                ##若刪除最後一筆, 則需手動讓指標跳到正確位置
                IF g_fieldsel_idx > g_fieldsel.getLength() THEN
                   CALL DIALOG.setCurrentRow("s_fieldsel", g_fieldsel.getLength())
                   LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")
                END IF
                CALL adzp188_set_seqaction_active("s_fieldsel", "up_fieldseq", "down_joinseq")
                CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_field")
                CALL adzp188_set_fielddelete_active()
            ELSE 
               #重整
               CALL adzp188_fieldsel_b_fill()
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00272"
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
            END IF 
            ##140401 判斷主表7個保留字不能將dzgc005_1取消(E)   
            ##140401-原版(S)         
            #CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "del")
            #CALL adzp188_refresh_seq("s_fieldsel")
            ##若刪除最後一筆, 則需手動讓指標跳到正確位置
            #IF g_fieldsel_idx > g_fieldsel.getLength() THEN
               #CALL DIALOG.setCurrentRow("s_fieldsel", g_fieldsel.getLength())
               #LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")
            #END IF
            #CALL adzp188_set_seqaction_active("s_fieldsel", "up_fieldseq", "down_joinseq")
            #CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_field")
            #CALL adzp188_set_fielddelete_active()
            ##140401-原版(e) 
         ##功能鍵方式刪除
         ON ACTION del_userfield
            CALL adzp188_set_usfield()  #141127 add
            CALL adzp188_maintain_dzgc(g_fieldsel_idx, g_fieldsel[g_fieldsel_idx].dzgc006, "del")    
            CALL adzp188_refresh_seq("s_fieldsel")
            ##若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_fieldsel_idx > g_fieldsel.getLength() THEN
               CALL DIALOG.setCurrentRow("s_fieldsel", g_fieldsel.getLength())
               LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")
            END IF
            CALL adzp188_set_seqaction_active("s_fieldsel", "up_fieldseq", "down_joinseq")
            CALL adzp188_set_action_active_by_datasize("s_fieldsel", "del_userfield")
            CALL adzp188_set_fielddelete_active()
         ON ACTION up_fieldseq
            CALL adzp188_move_up_down("s_fieldsel", "up")
            LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")
         ON ACTION down_fieldseq
            CALL adzp188_move_up_down("s_fieldsel", "down")
            LET g_fieldsel_idx = DIALOG.getCurrentRow("s_fieldsel")
                    
      END INPUT
      
      
      #欄位頁簽-自訂欄位輸入(dzgd004切兩個元件進一個欄位, 皆為formonly)
      INPUT g_dzgd_d.dzgd003, g_dzgd_d.dzgd005, g_dzgd004_1, g_dzgd004_2, g_dzgd006_1
       FROM formonly.dzgd003, dzgd_t.dzgd005, formonly.dzgd004_1, formonly.dzgd004_2, formonly.dzgd006_1
         ATTRIBUTES(WITHOUT DEFAULTS)

         ON CHANGE dzgd004_1
            #IF cl_null(g_dzgd004_2) THEN  #140715 add 
               CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, FALSE) RETURNING g_dzgd004_2 #140710 add
            #END IF    #140715 add

         ON CHANGE dzgd006_1
            CASE g_dzgd006_1
               ##150211 add -(s)
                WHEN "0"
                   LET g_dzgd_d.dzgd006 = "0"
               ##150211 add -(e)            
                WHEN "1"
                   LET g_dzgd_d.dzgd006 = "NULL"
                WHEN "2"
                   LET g_dzgd_d.dzgd006 = "''"
            END CASE
         ##160921-00012#1 add -(s) 
         AFTER FIELD dzgd003
               DISPLAY "dzgd003"
               CALL adzp188_set_usfield()
         AFTER FIELD dzgd005
               DISPLAY "dzgd005"
               CALL adzp188_set_usfield()    
         BEFORE FIELD dzgd004_1
               DISPLAY "dzgd004_1"
               CALL adzp188_set_usfield()
         BEFORE FIELD dzgd004_2
               DISPLAY "dzgd004_2"
               CALL adzp188_set_usfield()                 
         ##160921-00012#1 add -(s)  
         
         ON ACTION add_userfield
            #因為輸入過程中會卡住, 所以4fd中的dzgd003不對應資料庫, 這邊必須要判斷空值

            IF g_dzgd_d.dzgd003 IS NOT NULL THEN
               ##140606 add -(s)  自定欄位只能30位元
               LET l_dzgd003_str =""
               LET l_dzgd003_str = g_dzgd_d.dzgd003 CLIPPED 
               LET l_dzgd003_str = l_dzgd003_str.trim()   #150121 add
               ##IF l_dzgd003_str.getLength() > 30 THEN   #150617-00018#1 mark             
               IF l_dzgd003_str.getLength() > 30 OR l_dzgd003_str.subString(1,2) <>'l_' THEN  #150617-00018#1 add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00309"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #NEXT FIELD g_dzgd_d.dzgd003   #150901-00021#1 mark
               ELSE 
               ##140606 add -(e)
                 #CALL adzp188_maintain_dzgc("", "Y", "add")   #150525-00029#1 mark
                 CALL adzp188_maintain_dzgc(g_fieldsel_idx, "Y", "add")    #150525-00029#1 add
                 CALL adzp188_refresh_seq("s_fieldsel")
               END IF  ##140606 add
            END IF
         ##140414 add-140610 mark(s)
         ##自訂定欄位
         #ON ACTION userdef_field
           #IF g_dzgd006_1 = "3" THEN 
              ##CALL adzp188_01(g_tablesel,g_dzgd_d.dzgd003,g_dzgd_d.dzgd005, g_dzgd004_1, g_dzgd004_2) RETURNING g_dzgd_d.dzgd006
              #CALL adzp188_01() #RETURNING g_dzgd_d.dzgd006
           #END IF  
         ##140414 add-140610 mark(e) 
         BEFORE INPUT 
             ##141127 add -(s)
            CALL adzp188_set_usfield()  #140710 add     
            IF g_dzgd004_1 IS NOT NULL OR g_dzgd004_2 IS NOT NULL THEN
               DISPLAY g_dzgd004_1 TO formonly.dzgd004_1
               DISPLAY g_dzgd004_2 TO formonly.dzgd004_2
            END IF
           ##141127 add -(e)
  
      END INPUT
      
      #篩選頁簽-單頭輸入
      INPUT g_dzgf_d.dzgf004, g_dzgf_d.dzgf005, g_dzgf_d.dzgf006, g_dzgf_d.dzgf007, g_dzgf_d.dzgf008, g_dzgf_d.dzgf009, g_dzgf_d.dzgf010
       FROM dzgf_t.dzgf004, dzgf_t.dzgf005, dzgf_t.dzgf006, dzgf_t.dzgf007, dzgf_t.dzgf008, dzgf_t.dzgf009, dzgf_t.dzgf010
         BEFORE FIELD dzgf005
            DISPLAY adzp188_filter_sample("dzgf005") TO FORMONLY.sample005
         ON CHANGE dzgf005
            #改變欄位下拉選單
            CALL adzp188_set_field_comboitems("dzgf_t.dzgf006", g_dzgf_d.dzgf005, TRUE) RETURNING g_dzgf_d.dzgf006
            #選完後改變顯示範例, 對上值才不會奇怪
            DISPLAY adzp188_filter_sample("dzgf005") TO FORMONLY.sample005
         ON CHANGE dzgf004
            #選了左括號連動帶對應右括號
            IF NOT cl_null(g_dzgf_d.dzgf004) THEN
               LET g_dzgf_d.dzgf009 = g_dzgf_d.dzgf004
               DISPLAY g_dzgf_d.dzgf009 TO dzgf_t.dzgf009           
            END IF 
         AFTER FIELD dzgf004
            #選了左括號連動帶對應右括號
            IF NOT cl_null(g_dzgf_d.dzgf004) THEN
               LET g_dzgf_d.dzgf009 = g_dzgf_d.dzgf004   
               DISPLAY g_dzgf_d.dzgf009 TO dzgf_t.dzgf009   
            END IF             
         BEFORE FIELD dzgf006
            #給範例
            DISPLAY adzp188_filter_sample("dzgf006") TO FORMONLY.sample006
         AFTER FIELD dzgf006
            #選完後改變顯示範例, 對上值才不會奇怪
            DISPLAY adzp188_filter_sample("dzgf006") TO FORMONLY.sample006
         BEFORE FIELD dzgf007
            #給範例
            DISPLAY adzp188_filter_sample("dzgf007") TO FORMONLY.sample007
            ##150323 add -(s)
            LET g_dzgf_d.dzgf008 = adzp188_filter_sample("dzgf008")
            DISPLAY g_dzgf_d.dzgf008  TO dzgf_t.dzgf008
            CALL cl_set_comp_font_color("dzgf008","gray")
            ##150323 add -(e)            
         ON CHANGE dzgf007
            #有些運算子不能輸入值
            CALL adzp188_set_field_noentry("dzgf008")
            #選完後改變顯示範例, 對上值才不會奇怪
            DISPLAY adzp188_filter_sample("dzgf007") TO FORMONLY.sample007
            #選完dzgf007後改變dzgf008的範例
            #DISPLAY adzp188_filter_sample("dzgf008") TO FORMONLY.sample008  ##150323 mark
         ##150323 add -(s) 
            LET g_dzgf_d.dzgf008 = adzp188_filter_sample("dzgf008")
            DISPLAY g_dzgf_d.dzgf008  TO dzgf_t.dzgf008
            CALL cl_set_comp_font_color("dzgf008","gray")
         BEFORE FIELD dzgf008 
            CALL cl_set_comp_font_color("dzgf008","black")
            LET g_dzgf_d.dzgf008 = ""
            DISPLAY g_dzgf_d.dzgf008 TO dzgf_t.dzgf008
         ##150323 add -(e)
         
         ON ACTION add_filter
            CALL adzp188_maintain_dzgf("","add")
         ON ACTION upd_filter
            CALL adzp188_maintain_dzgf(g_filter_idx,"upd")
        
        ##150323 add -(s)
        BEFORE INPUT    
            LET g_dzgf_d.dzgf008 = adzp188_filter_sample("dzgf008")
            DISPLAY g_dzgf_d.dzgf008  TO dzgf_t.dzgf008
            CALL cl_set_comp_font_color("dzgf008","gray")
        ##150323 add -(e)              
      END INPUT
      
      #篩選頁簽-wc單身
      DISPLAY ARRAY g_filter TO s_filter.* ATTRIBUTES(COUNT=g_filter.getLength())
         BEFORE DISPLAY
            CALL adzp188_set_seqaction_active("s_filter", "up_filterseq", "down_filterseq")
            CALL adzp188_set_action_active_by_datasize("s_filter", "del_filter")  
            ##140317 add-(S)序號99不開啟刪除按鈕  140318 mark -(S) 因為考慮到應用的場景會換enterprise，若寫在報表元件裡會無法置換，所以先由r、q、t那邊傳入
            #IF g_filter[g_filter_idx].dzgf003 <> 99 THEN 
               #CALL adzp188_set_action_active_by_datasize("s_filter", "del_filter")
            #ELSE 
               #CALL gdig_curr.setActionActive("del_filter", FALSE)
            #END IF 
             ##140317 add-(E)序號99不開啟刪除按鈕 140318 mark -(S)
         BEFORE ROW
            LET g_filter_idx = DIALOG.getCurrentRow("s_filter")
            CALL adzp188_separate_filter_wc(g_filter_idx)
            CALL adzp188_set_seqaction_active("s_filter", "up_filterseq", "down_filterseq")
            CALL adzp188_set_action_active_by_datasize("s_filter", "del_filter")  
            ##140317 add-(S)序號99不開啟刪除按鈕 140318 mark -(S) 因為考慮到應用的場景會換enterprise，若寫在報表元件裡會無法置換，所以先由r、q、t那邊傳入
            #IF g_filter[g_filter_idx].dzgf003 <> 99 THEN 
               #CALL adzp188_set_action_active_by_datasize("s_filter", "del_filter")
            #ELSE 
               #CALL gdig_curr.setActionActive("del_filter", FALSE)               
            #END IF 
            ##140317 add-(E)序號99不開啟刪除按鈕 140318 mark -(S)
         ON ACTION del_filter            
            CALL adzp188_maintain_dzgf(g_filter_idx,"del")
            CALL adzp188_refresh_seq("s_filter")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_filter_idx > g_filter.getLength() THEN
               CALL DIALOG.setCurrentRow("s_filter", g_filter.getLength())
               LET g_filter_idx = DIALOG.getCurrentRow("s_filter")
            END IF
            CALL adzp188_separate_filter_wc(g_filter_idx)
            CALL adzp188_set_seqaction_active("s_filter", "up_filterseq", "down_filterseq")
            CALL adzp188_set_action_active_by_datasize("s_filter", "del_filter")
         ON ACTION up_filterseq
                CALL adzp188_move_up_down("s_filter", "up")
                LET g_filter_idx = DIALOG.getCurrentRow("s_filter")
         ON ACTION down_filterseq
            CALL adzp188_move_up_down("s_filter", "down")
            LET g_filter_idx = DIALOG.getCurrentRow("s_filter")
      END DISPLAY

      #140110 add -(s)--------------------
      #XG群組頁簽-樹狀                                      
      DISPLAY ARRAY g_xg_grouplist TO s_xg_grouplist.* ATTRIBUTES(COUNT=g_xg_grouplist.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_xg_grouplist", 1)
            CALL adzp188_set_action_active_by_datasize("s_xg_grouplist", "add_group")
         BEFORE ROW
            LET g_xg_grouplist_idx = DIALOG.getCurrentRow("s_xg_grouplist")
            #是Table的話, 不給多選
            IF g_xg_grouplist[g_xg_grouplist_idx].groupisnode THEN
               CALL DIALOG.setSelectionMode("s_xg_grouplist", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_xg_grouplist", 1)
            END IF
         #功能鍵方式增加
         ON ACTION add_group
            CALL adzp188_maintain_dzge_xg(g_xg_grouplist_idx, "add")
      END DISPLAY
      
      #XG群組頁簽-已選欄位列表
      INPUT ARRAY g_xg_groupsel FROM s_xg_groupsel.*
         ATTRIBUTES(COUNT=g_xg_groupsel.getLength(), MAXCOUNT=g_xg_groupsel.getLength(), WITHOUT DEFAULTS,
                    INSERT ROW = FALSE, DELETE ROW = FALSE, APPEND ROW = FALSE)
         BEFORE INPUT
            CALL adzp188_set_seqaction_active("s_xg_groupsel", "up_groupseq", "down_groupseq")
            CALL adzp188_set_action_active_by_datasize("s_xg_groupsel", "del_group")

         BEFORE ROW
            LET g_xg_groupsel_idx = DIALOG.getCurrentRow("s_xg_groupsel")
            CALL adzp188_set_seqaction_active("s_xg_groupsel", "up_groupseq", "down_groupseq")
            CALL adzp188_set_action_active_by_datasize("s_xg_groupsel", "del_group")

         ON CHANGE dzge005_1
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzge_xg(g_xg_groupsel_idx, "upd")  
         ON CHANGE dzge005_2
          #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            ##140606 增加跳頁判斷 只能一個跳頁 (s)
           IF g_xg_groupsel[g_xg_groupsel_idx].paging = 'Y' THEN 
             SELECT count(paging) INTO l_paging_cnt FROM adzp188_gexg_tmp     #151012-00003#1 調整tmp名稱縮為17字元
             WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
               AND paging ='Y'
             IF l_paging_cnt > 0 THEN  #已有設定跳頁
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = "adz-00308"
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_xg_groupsel[g_xg_groupsel_idx].paging ="N"
             ELSE 
                CALL adzp188_maintain_dzge_xg(g_xg_groupsel_idx, "upd")
             END IF          
           END IF
         ##140606 增加跳頁判斷 只能一個跳頁 (e)

         ##141204 add -(s)
         ON CHANGE dzge007
            CALL adzp188_maintain_dzge_xg(g_xg_groupsel_idx, "upd")
         ##141204 add -(e)         
            
         AFTER ROW
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzge_xg(g_xg_groupsel_idx, "upd")
         #功能鍵方式刪除
         ON ACTION del_group
            CALL adzp188_maintain_dzge_xg(g_xg_groupsel_idx, "del")
            CALL adzp188_refresh_seq("s_xg_groupsel")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_xg_groupsel_idx > g_xg_groupsel.getLength() THEN
               CALL DIALOG.setCurrentRow("s_xg_groupsel", g_xg_groupsel.getLength())
               LET g_xg_groupsel_idx = DIALOG.getCurrentRow("s_xg_groupsel")
            END IF
            CALL adzp188_set_seqaction_active("s_xg_groupsel", "up_groupseq", "down_groupseq")
            CALL adzp188_set_action_active_by_datasize("s_xg_groupsel", "del_group")

         ON ACTION up_groupseq
            CALL adzp188_move_up_down("s_xg_groupsel", "up")
            LET g_xg_groupsel_idx = DIALOG.getCurrentRow("s_xg_groupsel")
         ON ACTION down_groupseq
            CALL adzp188_move_up_down("s_xg_groupsel", "down")
            LET g_xg_groupsel_idx = DIALOG.getCurrentRow("s_xg_groupsel")
      END INPUT
     
      #140110 add -(e)--------------------------------
      
     #140113 add -(s)--------------------------------
     ##XG彙總頁簽-樹狀1(左)
      DISPLAY ARRAY g_summarylist1 TO s_summarylist1.* ATTRIBUTES(COUNT=g_summarylist1.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_summarylist1", 1)
            CALL adzp188_set_action_active_by_datasize("s_summarylist1", "add_summary")
         BEFORE ROW
            LET g_summarylist1_idx = DIALOG.getCurrentRow("s_summarylist1")
            #是Table的話, 不給多選
            IF g_summarylist1[g_summarylist1_idx].summaryisnode1 THEN
               CALL DIALOG.setSelectionMode("s_summarylist1", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_summarylist1", 1)
            END IF
         #140127 拖拉 add-(S)
         ON DRAG_START(dnd)
            IF adzp188_check_summary_repeat(DIALOG.getCurrentRow("s_summarylist1")) THEN
               CALL dnd.setOperation(NULL)
            ELSE
               LET ls_area = "s_summarylist1"
            END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, 啟動動作在s_summarylist2
         ON DROP(dnd)
            IF ls_area = "s_summarylist2" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_summarylist(DIALOG.getCurrentRow("s_summarylist2"), '', "del")
               CALL adzp188_refresh_seq("s_summarylist2")               
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_summarylist2", "del_summary")
            END IF
         #140127 拖拉 add-(e)
            
         #功能鍵方式增加
         ON ACTION add_summary
            ##增加至彙總樹狀2
            CALL adzp188_maintain_summarylist(g_summarylist1_idx,'', "add")
      END DISPLAY

      ##140122 -(s)
     
     ##XG彙總頁簽-樹狀2(右)      
      DISPLAY ARRAY g_summarylist2 TO s_summarylist2.* ATTRIBUTES(COUNT=g_summarylist2.getLength())
         BEFORE DISPLAY
            LET g_summarylist2_idx = DIALOG.getCurrentRow("s_summarylist2") 
            IF g_summarylist2[g_summarylist2_idx].summaryisnode2 THEN 
               CALL DIALOG.setSelectionMode("s_summarylist2", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_summarylist2", 1)
            END IF         
            CALL adzp188_set_action_active_by_datasize("s_summarylist2", "del_summary")            
         BEFORE ROW
            LET g_summarylist2_idx = DIALOG.getCurrentRow("s_summarylist2") 
            IF g_summarylist2[g_summarylist2_idx].summaryisnode2 THEN 
               CALL DIALOG.setSelectionMode("s_summarylist2", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_summarylist2", 1)
            END IF
            CALL adzp188_set_action_active_by_datasize("s_summarylist2", "del_summary")          

         ##140127 拖拉-(s)
         #拖拉方式增加, 結束動作在s_summarylist2的ON DROP
         ON DRAG_START(dnd)
            IF adzp188_check_summary_repeat(DIALOG.getCurrentRow("s_summarylist2")) THEN
               CALL dnd.setOperation(NULL)
            ELSE
               LET ls_area = "s_summarylist2"
            END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, 啟動動作在s_summarylist1
         ON DROP(dnd)
            IF ls_area = "s_summarylist1" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_summarylist(DIALOG.getCurrentRow("s_summarylist2"), '', "add")
               CALL adzp188_refresh_seq("s_summarylist2")               
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_summarylist2", "del_summary")
            END IF
         ##140127 拖拉-(e)   
         AFTER ROW
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            #CALL adzp188_maintain_summarylist(g_summarylist2_idx, '', "upd")
         #功能鍵方式刪除

             
         ON ACTION del_summary
            CALL adzp188_maintain_summarylist(g_summarylist2_idx, '', "del")
            CALL adzp188_refresh_seq("s_summarylist2")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_summarylist2_idx > g_summarylist2.getLength() THEN
               CALL DIALOG.setCurrentRow("s_summarylist2", g_summarylist2.getLength())
               LET g_summarylist2_idx = DIALOG.getCurrentRow("s_summarylist2")
            END IF
            CALL adzp188_set_action_active_by_datasize("s_summarylist2", "del_summary")
      END DISPLAY 

            #140123
      INPUT g_gzgg009 FROM gzgg_t.gzgg009
        ATTRIBUTES(WITHOUT DEFAULTS)

         ON CHANGE gzgg009
           IF g_summarylist2_idx>0 THEN 
            CALL adzp188_maintain_summarylist(g_summarylist2_idx, '', "upd")
           END IF 
            
      END INPUT 
      ##140122 -(e)
      #140113 add -(e)--------------------------------

      
      ##140223 -(s)
      ##GR群組頁籤(右上)
      DISPLAY ARRAY g_gr_grouplist1 TO s_gr_grouplist1.* ATTRIBUTES(COUNT=g_gr_grouplist1.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_gr_grouplist1", 1)
            CALL adzp188_set_action_active_by_datasize("s_gr_grouplist1", "add_group1")
            CALL adzp188_set_action_active_by_datasize("s_gr_grouplist1", "add_group2")  ##150324 add
         BEFORE ROW
            LET g_gr_grouplist1_idx = DIALOG.getCurrentRow("s_gr_grouplist1")
            LET g_gr_grouplist2_idx = DIALOG.getCurrentRow("s_gr_grouplist1")            ##150324 add  
            #是Table的話, 不給多選
            IF g_gr_grouplist1[g_gr_grouplist1_idx].groupisnode1 THEN
               CALL DIALOG.setSelectionMode("s_gr_grouplist1", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_gr_grouplist1", 1)
            END IF
         #功能鍵方式增加
         ON ACTION add_group1
            CALL adzp188_maintain_dzge_gr(g_gr_grouplist1_idx,"s_gr_groupsel1", "add")
            
         ##150324 add -(s)
         ON ACTION add_group2
            CALL adzp188_maintain_dzge_gr(g_gr_grouplist2_idx,"s_gr_groupsel2", "add")
         ##150324 add -(e)   
      END DISPLAY

      ##150324 mark -(s)
      ##GR群組頁籤(左下)
      #DISPLAY ARRAY g_gr_grouplist2 TO s_gr_grouplist2.* ATTRIBUTES(COUNT=g_gr_grouplist2.getLength())
         #BEFORE DISPLAY
            #CALL DIALOG.setSelectionMode("s_gr_grouplist2", 1)
            #CALL adzp188_set_action_active_by_datasize("s_gr_grouplist2", "add_group2")
            #
         #BEFORE ROW
            #LET g_gr_grouplist2_idx = DIALOG.getCurrentRow("s_gr_grouplist2")
            ##是Table的話, 不給多選
            #IF g_gr_grouplist2[g_gr_grouplist2_idx].groupisnode2 THEN
               #CALL DIALOG.setSelectionMode("s_gr_grouplist2", 0)
            #ELSE
               #CALL DIALOG.setSelectionMode("s_gr_grouplist2", 1)
            #END IF
            #
         ##功能鍵方式增加
         #ON ACTION add_group2
            #CALL adzp188_maintain_dzge_gr(g_gr_grouplist2_idx,"s_gr_groupsel2", "add")
      #END DISPLAY   
      ##150324 mark -(e) 
      #140224
      #GR群組頁簽-已選欄位列表1
      INPUT ARRAY g_gr_groupsel1 FROM s_gr_groupsel1.*
         ATTRIBUTES(COUNT=g_gr_groupsel1.getLength(), MAXCOUNT=g_gr_groupsel1.getLength(), WITHOUT DEFAULTS,
                    INSERT ROW = FALSE, DELETE ROW = FALSE, APPEND ROW = FALSE)
         BEFORE INPUT
            CALL adzp188_set_seqaction_active("s_gr_groupsel1", "up_groupseq1", "down_groupseq1")
            CALL adzp188_set_action_active_by_datasize("s_gr_groupsel1", "del_group1")

         BEFORE ROW
            LET g_gr_groupsel1_idx = DIALOG.getCurrentRow("s_gr_groupsel1")
            CALL adzp188_set_seqaction_active("s_gr_groupsel1", "up_groupseq1", "down_groupseq1")
            CALL adzp188_set_action_active_by_datasize("s_gr_groupsel1", "del_group1")

         ON CHANGE dzge007
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzge_gr(g_gr_groupsel1_idx, "s_gr_groupsel1","upd")  

         AFTER ROW
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzge_gr(g_gr_groupsel1_idx, "s_gr_groupsel1", "upd")
         #功能鍵方式刪除
         ON ACTION del_group1
            CALL adzp188_maintain_dzge_gr(g_gr_groupsel1_idx,  "s_gr_groupsel1","del")
            CALL adzp188_refresh_seq("s_gr_groupsel1")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_gr_groupsel1_idx > g_gr_groupsel1.getLength() THEN
               CALL DIALOG.setCurrentRow("s_gr_groupsel1", g_gr_groupsel1.getLength())
               LET g_gr_groupsel1_idx = DIALOG.getCurrentRow("s_gr_groupsel1")
            END IF
            CALL adzp188_set_seqaction_active("s_gr_groupsel1", "up_groupseq1", "down_groupseq1")
            CALL adzp188_set_action_active_by_datasize("s_gr_groupsel1", "del_group1")

         ON ACTION up_groupseq1
            CALL adzp188_move_up_down("s_gr_groupsel1", "up")
            LET g_gr_groupsel1_idx = DIALOG.getCurrentRow("s_gr_groupsel1")
         ON ACTION down_groupseq1
            CALL adzp188_move_up_down("s_gr_groupsel1", "down")
            LET g_gr_groupsel1_idx = DIALOG.getCurrentRow("s_gr_groupsel1")
      END INPUT

      #GR群組頁簽-已選欄位列表1
      INPUT ARRAY g_gr_groupsel2 FROM s_gr_groupsel2.*
         ATTRIBUTES(COUNT=g_gr_groupsel2.getLength(), MAXCOUNT=g_gr_groupsel2.getLength(), WITHOUT DEFAULTS,
                    INSERT ROW = FALSE, DELETE ROW = FALSE, APPEND ROW = FALSE)
         BEFORE INPUT
            CALL adzp188_set_seqaction_active("s_gr_groupsel2", "up_groupseq2", "down_groupseq2")
            CALL adzp188_set_action_active_by_datasize("s_gr_groupsel2", "del_group2")

         BEFORE ROW
            LET g_gr_groupsel2_idx = DIALOG.getCurrentRow("s_gr_groupsel2")
            CALL adzp188_set_seqaction_active("s_gr_groupsel2", "up_groupseq2", "down_groupseq2")
            CALL adzp188_set_action_active_by_datasize("s_gr_groupsel2", "del_group2")

         ON CHANGE dzge007
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzge_gr(g_gr_groupsel2_idx, "s_gr_groupsel2", "upd")  

         AFTER ROW
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            CALL adzp188_maintain_dzge_gr(g_gr_groupsel2_idx, "s_gr_groupsel2", "upd")
         #功能鍵方式刪除
         ON ACTION del_group2
            CALL adzp188_maintain_dzge_gr(g_gr_groupsel2_idx , "s_gr_groupsel2", "del")
            CALL adzp188_refresh_seq("s_gr_groupsel2")
            #若刪除最後一筆, 則需手動讓指標跳到正確位置
            IF g_gr_groupsel2_idx > g_gr_groupsel2.getLength() THEN
               CALL DIALOG.setCurrentRow("s_gr_groupsel2", g_gr_groupsel2.getLength())
               LET g_gr_groupsel2_idx = DIALOG.getCurrentRow("s_gr_groupsel2")
            END IF
            CALL adzp188_set_seqaction_active("s_gr_groupsel2", "up_groupseq2", "down_groupseq2")
            CALL adzp188_set_action_active_by_datasize("s_gr_groupsel2", "del_group2")

         ON ACTION up_groupseq2
            CALL adzp188_move_up_down("s_gr_groupsel2", "up")
            LET g_gr_groupsel2_idx = DIALOG.getCurrentRow("s_gr_groupsel2")
         ON ACTION down_groupseq2
            CALL adzp188_move_up_down("s_gr_groupsel2", "down")
            LET g_gr_groupsel2_idx = DIALOG.getCurrentRow("s_gr_groupsel2")
      END INPUT  
      
      INPUT g_dzge005 FROM formonly.r_dzge005
         ATTRIBUTES(WITHOUT DEFAULTS)
         BEFORE INPUT 
           DISPLAY g_dzge005 TO formonly.r_dzge005
         ##141222 調整gr group -(s)
          ON CHANGE r_dzge005
              CALL adzp188_unset_dzge005()
            
         ##141222 調整gr group -(s)
      END INPUT 
      ##140223 -(e) 

      #GR排版頁籤-樹狀(左)                                      
      DISPLAY ARRAY g_typelist1 TO s_typelist1.* ATTRIBUTES(COUNT=g_typelist1.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_typelist1", 1)
            CALL adzp188_set_action_active_by_datasize("s_typelist1", "add_type")
         BEFORE ROW
            LET g_typelist1_idx = DIALOG.getCurrentRow("s_typelist1")
            #是Table的話, 不給多選
            IF g_typelist1[g_typelist1_idx].typeisnode1 THEN
               CALL DIALOG.setSelectionMode("s_typelist1", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_typelist1", 1)
            END IF
         ##140320-(S)
         #拖拉方式增加, 結束動作在s_typelist1的ON DROP
         ON DRAG_START(dnd)
            ##判斷選到的Table是否已經存在已選資料表清單
            #IF adzp188_check_table_repeat(DIALOG.getCurrentRow("s_typelist1")) THEN
               ##標註拖拉功能的處理方法,NULL(不做),move(搬移),copy(複製)
               #CALL dnd.setOperation(NULL)
            #ELSE
               #啟動拖拉時,標定s_typelist1為起始區 
               LET ls_area = "s_typelist1"
           # END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, 啟動動作在s_typelist2
         ON DROP(dnd)
            IF ls_area = "s_typelist2" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_typelist2(DIALOG.getCurrentRow("s_typelist2"),DIALOG.getCurrentRow("s_typelist2"), "del")
               ##果都刪光了, 就不要出現增加功能鍵
               CALL adzp188_set_action_active_by_datasize("s_typelist2", "add_type")
            END IF
          ##140320-(S)
            
         #功能鍵方式增加
         ON ACTION add_type
            IF cl_null(g_typelist2_idx) OR g_typelist2_idx = 0 THEN
               ##若沒先選區塊，先設單身1
               LET g_typelist2_idx = 1
            END IF  
            CALL adzp188_maintain_typelist2(g_typelist1_idx, g_typelist2_idx,"add")
            #CALL adzp188_refresh_typelist2_seq("s_typelist2")  
      END DISPLAY  

      #GR排版頁籤-樹狀(右)    ##226 janet                                  
      DISPLAY ARRAY g_typelist2 TO s_typelist2.* ATTRIBUTES(COUNT=g_typelist2.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_typelist2", 1)
            CALL adzp188_set_action_active_by_datasize("s_typelist2", "del_type")
            CALL adzp188_set_seqaction_active("s_typelist2", "up_typeseq", "down_typeseq")
          BEFORE ROW
            LET g_typelist2_idx = DIALOG.getCurrentRow("s_typelist2")
            #是Table的話, 不給多選
            IF g_typelist2[g_typelist2_idx].typeisnode2 THEN
               CALL DIALOG.setSelectionMode("s_typelist2", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_typelist2", 1)
            END IF
            CALL adzp188_set_seqaction_active("s_typelist2", "up_typeseq", "down_typeseq")
         ##140320-(S)
         #拖拉方式增加, 結束動作在s_typelist2的ON DROP
         ON DRAG_START(dnd)
            ##判斷選到的Table是否已經存在已選資料表清單
            #IF adzp188_check_table_repeat(DIALOG.getCurrentRow("s_typelist2")) THEN
               ##標註拖拉功能的處理方法,NULL(不做),move(搬移),copy(複製)
               #CALL dnd.setOperation(NULL)
            #ELSE
               ##啟動拖拉時,標定s_typelist1為起始區 
               LET ls_area = "s_typelist2"
            #END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, 啟動動作在s_typelist2
         ON DROP(dnd)
            IF ls_area = "s_typelist1" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_typelist2(DIALOG.getCurrentRow("s_typelist1"),DIALOG.getCurrentRow("s_typelist2"), "add")
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_typelist2", "del_type")
            END IF
          ##140320-(S)

            
         #功能鍵方式增加
         ON ACTION del_type
            CALL adzp188_maintain_typelist2(g_typelist2_idx,g_typelist2_idx, "del")
            CALL adzp188_set_seqaction_active("s_typelist2", "up_typeseq", "down_typeseq")
            ##重新整理s_typelist2的順序 
            #CALL adzp188_refresh_typelist2_seq("s_typelist2")

         ON ACTION up_typeseq
             CALL adzp188_move_up_down("s_typelist2", "up")               
             LET g_typelist2_idx = DIALOG.getCurrentRow("s_typelist2")

         ON ACTION down_typeseq
            CALL adzp188_move_up_down("s_typelist2", "down")
            LET g_typelist2_idx = DIALOG.getCurrentRow("s_typelist2")
 
      END DISPLAY  


      ##140306參數頁籤-(s)
      INPUT g_arg FROM formonly.arg
         ATTRIBUTES(WITHOUT DEFAULTS)
         AFTER FIELD arg
            
            #選擇模組後, 即時改變左方資料表列表
            CALL adzp188_maintain_argsel(g_arg)
            CALL adzp188_argsel_b_fill()
            #為了讓挑選完後直接可以focus到左邊列表的第一筆
            CALL DIALOG.setCurrentRow("s_argsel",1)
            NEXT FIELD s_argsel.dzgj006
         
      END INPUT

     ##140516 XG排版左(交叉表) -(s)
                                          
      DISPLAY ARRAY g_xgtypelist1 TO s_xgtypelist1.* ATTRIBUTES(COUNT=g_typelist1.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_xgtypelist1", 1)
            CALL adzp188_set_action_active_by_datasize("s_xgtypelist1", "add_col")
            CALL adzp188_set_action_active_by_datasize("s_xgtypelist1", "add_row")
            CALL adzp188_set_action_active_by_datasize("s_xgtypelist1", "add_sum")
         BEFORE ROW
            LET g_xgtypelist1_idx = DIALOG.getCurrentRow("s_xgtypelist1")
            #是Table的話, 不給多選
            IF g_xgtypelist1[g_xgtypelist1_idx].xgtypeisnode1 THEN
               CALL DIALOG.setSelectionMode("s_xgtypelist1", 0)
            ELSE
               CALL DIALOG.setSelectionMode("s_xgtypelist1", 1)
            END IF
         ##140320-(S)
         #拖拉方式增加, 結束動作在s_typelist1的ON DROP
         ON DRAG_START(dnd)
               #啟動拖拉時,標定s_typelist1為起始區 
               LET ls_area = "s_xgtypelist1"

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, 啟動動作在左邊s_tablecol、s_tablerow、s_tablesum
         ON DROP(dnd)
            IF ls_area = "s_tablecol" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_tablecol"),"c", "del")
               ##果都刪光了, 就不要出現增加功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablecol", "add_col")
            END IF
            IF ls_area = "s_tablerow" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_tablerow"),"r", "del")
               ##果都刪光了, 就不要出現增加功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablerow", "add_row")
            END IF   
            IF ls_area = "s_tablesum" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_tablesum"),"s", "del")
               ##果都刪光了, 就不要出現增加功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablesum", "add_sum")
            END IF               
            
         #功能鍵方式增加
         ON ACTION add_row
 
            CALL adzp188_maintain_xgtype(g_xgtypelist1_idx, "r","add")
            #CALL adzp188_refresh_typelist2_seq("s_typelist2") 
            
         ON ACTION add_col 
            CALL adzp188_maintain_xgtype(g_xgtypelist1_idx, "c","add")

         ON ACTION add_sum 
            CALL adzp188_maintain_xgtype(g_xgtypelist1_idx, "s","add")            
           
      END DISPLAY  
      ##140516 XG排版左(交叉表) -(e)

      ##140516 XG排版右 (交叉表)--(s)
      #XG排版頁籤-樹狀(右)                                   
      DISPLAY ARRAY g_tablerow TO s_tablerow.* ATTRIBUTES(COUNT=g_tablerow.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_tablerow", 1)
            CALL adzp188_set_action_active_by_datasize("s_tablerow", "del_row")
            CALL adzp188_set_seqaction_active("s_tablerow", "up_row", "down_row")
          BEFORE ROW
            LET g_tablerow_idx = DIALOG.getCurrentRow("s_tablerow")
            #多選
            CALL DIALOG.setSelectionMode("s_tablerow", 1)
            CALL adzp188_set_seqaction_active("s_tablerow", "up_row", "down_row")   ##150324 add

         #拖拉方式增加, 結束動作在s_tablerow的ON DROP
         ON DRAG_START(dnd)
            ##判斷選到的Table是否已經存在已選資料表清單
            IF adzp188_check_povit_repeat("r",DIALOG.getCurrentRow("s_tablerow")) THEN
               ##標註拖拉功能的處理方法,NULL(不做),move(搬移),copy(複製)
               CALL dnd.setOperation(NULL)
            ELSE
               ##啟動拖拉時,標定s_typelist1為起始區 
               LET ls_area = "s_tablerow"
            END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, s_tablerow
         ON DROP(dnd)
            IF ls_area = "s_xgtypelist1" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_xgtypelist1"),"r", "add")
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablerow", "del_row")
            END IF

         #功能鍵方式增加
         ON ACTION del_row
            CALL adzp188_maintain_xgtype(g_tablerow_idx,"r", "del")

         ON ACTION up_row
             CALL adzp188_move_up_down("s_tablerow", "up")               
             LET g_tablerow_idx = DIALOG.getCurrentRow("s_tablerow")

         ON ACTION down_row
            CALL adzp188_move_up_down("s_tablerow", "down")
            LET g_tablerow_idx = DIALOG.getCurrentRow("s_tablerow")
 
      END DISPLAY  

      #XG排版頁籤-樹狀(右)                                   
      DISPLAY ARRAY g_tablecol TO s_tablecol.* ATTRIBUTES(COUNT=g_tablecol.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_tablecol", 1)
            CALL adzp188_set_action_active_by_datasize("s_tablecol", "del_col")
            CALL adzp188_set_seqaction_active("s_tablecol", "up_col", "down_col")
          BEFORE ROW
            LET g_tablecol_idx = DIALOG.getCurrentRow("s_tablecol")
            #多選
            CALL DIALOG.setSelectionMode("s_tablecol", 1)
            CALL adzp188_set_seqaction_active("s_tablecol", "up_col", "down_col")  ##150324 add

         #拖拉方式增加, 結束動作在s_tablerow的ON DROP
         ON DRAG_START(dnd)
            ##判斷選到的Table是否已經存在已選資料表清單
            IF adzp188_check_povit_repeat("c",DIALOG.getCurrentRow("s_tablecol")) THEN
               ##標註拖拉功能的處理方法,NULL(不做),move(搬移),copy(複製)
               CALL dnd.setOperation(NULL)
            ELSE
               ##啟動拖拉時,標定s_typelist1為起始區 
               LET ls_area = "s_tablecol"
            END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, s_tablecol
         ON DROP(dnd)
            IF ls_area = "s_xgtypelist1" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_xgtypelist1"),"c", "add")
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablecol", "del_col")
            END IF

         #功能鍵方式增加
         ON ACTION del_col
            CALL adzp188_maintain_xgtype(g_tablecol_idx,"c", "del")

         ON ACTION up_col
             CALL adzp188_move_up_down("s_tablecol", "up")               
             LET g_tablecol_idx = DIALOG.getCurrentRow("s_tablecol")

         ON ACTION down_col
            CALL adzp188_move_up_down("s_tablecol", "down")
            LET g_tablecol_idx = DIALOG.getCurrentRow("s_tablecol")
 
      END DISPLAY      

      #XG排版頁籤-樹狀(右)                                   
      DISPLAY ARRAY g_tablesum TO s_tablesum.* ATTRIBUTES(COUNT=g_tablesum.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_tablesum", 1)
            CALL adzp188_set_action_active_by_datasize("s_tablesum", "del_sum")
            CALL adzp188_set_seqaction_active("s_tablesum", "up_sum", "down_sum")
          BEFORE ROW
            LET g_tablesum_idx = DIALOG.getCurrentRow("s_tablesum")
            #多選
            CALL DIALOG.setSelectionMode("s_tablesum", 1)
            CALL adzp188_set_seqaction_active("s_tablesum", "up_sum", "down_sum")  ##150324 add

         #拖拉方式增加, 結束動作在s_tablerow的ON DROP
         ON DRAG_START(dnd)
            ##判斷選到的Table是否已經存在已選資料表清單
            IF adzp188_check_povit_repeat("s",DIALOG.getCurrentRow("s_tablesum")) THEN
               #標註拖拉功能的處理方法,NULL(不做),move(搬移),copy(複製)
               CALL dnd.setOperation(NULL)
            ELSE
               #啟動拖拉時,標定s_typelist1為起始區 
               LET ls_area = "s_tablesum"
            END IF

         ON DRAG_FINISHED(dnd)
            INITIALIZE ls_area TO NULL

         #拖拉方式刪除, s_tablecol
         ON DROP(dnd)
            IF ls_area = "s_xgtypelist1" THEN
               CALL dnd.dropInternal()
               CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_xgtypelist1"),"s", "add")
               #如果都刪光了, 就不要出現刪除功能鍵
               CALL adzp188_set_action_active_by_datasize("s_tablesum", "del_sum")
            END IF

         #功能鍵方式增加
         ON ACTION del_sum
            CALL adzp188_maintain_xgtype(g_tablesum_idx,"s", "del")

         ON ACTION up_sum
             CALL adzp188_move_up_down("s_tablesum", "up")               
             LET g_tablesum_idx = DIALOG.getCurrentRow("s_tablesum")

         ON ACTION down_sum
            CALL adzp188_move_up_down("s_tablesum", "down")
            LET g_tablesum_idx = DIALOG.getCurrentRow("s_tablesum")
 
      END DISPLAY          
      ##140516 XG排版右 (交叉表)--(e)
      
      #參數頁籤argsel
      INPUT ARRAY g_argsel FROM s_argsel.*
         ATTRIBUTES(COUNT=g_argsel.getLength(), MAXCOUNT=g_argsel.getLength(), WITHOUT DEFAULTS,
                    INSERT ROW = FALSE, DELETE ROW = FALSE, APPEND ROW = FALSE)
         BEFORE INPUT
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            #140804 add -(s)
            #IF g_argsel_idx > 0 THEN #140805 add -
                #LET l_arg = 0
                #SELECT COUNT(*) INTO l_arg FROM adzp188_dzgj_tmp 
                 #WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002        
                   #AND dzgj007 = g_cust AND dzgj008 = g_code_ide  #141017  mark 
                   #AND dzgj008 = g_code_ide                        #141017  add  
                ##若沒有值就先給tm.wc的預設值          
                #IF l_arg = 0 THEN 
                 #LET g_argsel[g_argsel_idx].dzgj006 = "where condition"
                 #LET g_argsel[g_argsel_idx].dzgj004 = "tm.wc"
                 #LET g_argsel[g_argsel_idx].dzgj005_2 = "Y"
                #ELSE 
                 #CALL adzp188_argsel_b_fill() 
                #END IF  
            #END IF
            #140804 add -(e)  

         #140730 add -(s)
         ON ROW CHANGE
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            IF g_argsel_idx > 0 THEN 
                CALL adzp188_maintain_dzgj(g_argsel_idx)  
            END IF 
         #140730 add -(e)
            
         ON CHANGE dzgj005_2
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            #若STRING有勾選，則dzgj005_1清空
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            IF g_argsel[g_argsel_idx].dzgj005_2 ="Y" THEN
               LET g_argsel[g_argsel_idx].dzgj005_1 = "" 
            END IF 
            CALL adzp188_maintain_dzgj(g_argsel_idx)  

         AFTER FIELD dzgj005_2
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            #若STRING有勾選，則dzgj005_1清空
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            IF g_argsel[g_argsel_idx].dzgj005_2 ="Y" THEN
               LET g_argsel[g_argsel_idx].dzgj005_1 = "" 
            END IF 
            CALL adzp188_maintain_dzgj(g_argsel_idx)    
            
         ON CHANGE dzgj005_1
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            #若dzgj005_1 則dzgj005_2清空
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            IF NOT cl_null(g_argsel[g_argsel_idx].dzgj005_1) OR g_argsel[g_argsel_idx].dzgj005_1 IS NOT NULL THEN
               IF adzp188_field_exist(g_argsel[g_argsel_idx].dzgj005_1) THEN 
                  LET g_argsel[g_argsel_idx].dzgj005_2 = "N"                  
               ELSE 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "aws-00003"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_argsel[g_argsel_idx].dzgj005_1 = ""
                  NEXT FIELD dzgj005_1  
               END IF
            ELSE 
               LET g_argsel[g_argsel_idx].dzgj005_2 = "Y"
            END IF 
            CALL adzp188_maintain_dzgj(g_argsel_idx)
            
         AFTER FIELD dzgj004
            IF g_argsel[g_argsel_idx].dzgj004 = "tm.wc" AND g_argsel[g_argsel_idx].dzgj005_2 = "N" THEN
               LET g_argsel[g_argsel_idx].dzgj005_2 = "Y"
            END IF   
            CALL adzp188_maintain_dzgj(g_argsel_idx)  #141105 add   
            
         AFTER FIELD dzgj005_1
               #判斷欄位是否存在
               LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
               IF NOT cl_null(g_argsel[g_argsel_idx].dzgj005_1) OR g_argsel[g_argsel_idx].dzgj005_1 IS NOT NULL THEN
                   IF adzp188_field_exist(g_argsel[g_argsel_idx].dzgj005_1) THEN 
                      LET g_argsel[g_argsel_idx].dzgj005_2 = "N"                     
                   ELSE 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "aws-00003"
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET g_argsel[g_argsel_idx].dzgj005_1 = ""
                      NEXT FIELD dzgj005_1                       
                   END IF 
               ELSE 
                  LET g_argsel[g_argsel_idx].dzgj005_2 = "Y"
               END IF 
               CALL adzp188_maintain_dzgj(g_argsel_idx)        
               
         AFTER ROW
            #是不是要進入修改功能, 可用舊值(變數未開)比對新值, 以避免時常連結資料庫
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            CALL adzp188_maintain_dzgj(g_argsel_idx)
            
         AFTER INPUT 
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            IF g_argsel_idx >0 THEN 
                IF g_argsel[g_argsel_idx].dzgj004 = "tm.wc" THEN
                   LET g_argsel[g_argsel_idx].dzgj005_2 = "Y"
                END IF 
            END IF 
            CALL adzp188_maintain_dzgj(g_argsel_idx)

         ON ACTION up_arg
            CALL adzp188_move_up_down("s_argsel", "up")
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
            
         ON ACTION down_arg
            CALL adzp188_move_up_down("s_argsel", "down")
            LET g_argsel_idx = DIALOG.getCurrentRow("s_argsel")
         
                        
      END INPUT        
      ##140306參數頁籤-(e)  

 

      BEFORE DIALOG
         LET gdig_curr = ui.Dialog.getCurrent()
          
      #140709 add-(s)
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG=TRUE

         EXIT DIALOG
      #140709 add-(e)   
      #切換到連結頁簽
      ON ACTION page_table
         #如果沒有挑選資料表, 不需要進入
         IF cl_null(g_dzga001) THEN
            NEXT FIELD dzga001
         END IF
         CALL adzp188_tablesel_b_fill()           #資料表
         
      #切換到連結頁簽
      ON ACTION page_join
          
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #改變資料表ComboBox*2
            CALL adzp188_set_tablesel_comboitems("dzgb_t.dzgb005", TRUE)
            CALL adzp188_set_tablesel_comboitems("dzgb_t.dzgb009", TRUE)    
            #設join的wc顏色
            CALL DIALOG.setArrayAttributes("s_join", g_join1)     
            
            LET g_join_idx = DIALOG.getCurrentRow("s_join")

            #預設點選的資料顯示在維護元件上
            CALL adzp188_separate_join_wc(g_join_idx)

            NEXT FIELD dzgb006
         END IF

      #切換到欄位頁簽
      ON ACTION page_field
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #預設資料
            #CALL adzp188_set_usfield()     #140710自訂欄位
            CALL adzp188_fieldlist_b_fill()
            CALL adzp188_fieldsel_b_fill()
            NEXT FIELD fieldname
         END IF

      #切換到XG群組頁簽
      ON ACTION page_group
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #預設資料
            CALL adzp188_xg_grouplist_b_fill()
            CALL adzp188_xg_groupsel_b_fill()
            #如果沒有挑選彙總資料, 不需要進入
            IF g_summarylist2.getLength() <= 0 THEN
               ##預設彙總資料存入
               CALL adzp188_summary2_default() 
               CALL adzp188_summary2_b_fill() 
            END IF 
            NEXT FIELD groupname          
         END IF

      #切換到GR群組頁簽
      ON ACTION page_group1
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #預設資料
            CALL adzp188_gr_grouplist_b_fill()            
            #如果沒有挑選GR群組資料, 不需要進入
            IF g_gr_groupsel1.getLength() <= 0 AND g_gr_groupsel2.getLength() <= 0 THEN
               ##預設GR群組資料存入
               CALL adzp188_gr_groupsel_default()                
            END IF 
            CALL adzp188_gr_groupsel_b_fill()
            NEXT FIELD groupname1          
         END IF

      ##GR群組印出複製萃取欄位
      ON ACTION grgroup_copy
         CALL adzp188_copy_dzge_from_sel1()
         CALL adzp188_gr_groupsel_b_fill()
         

      #切換到篩選頁簽
      ON ACTION page_filter
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #改變資料表ComboBox
            CALL adzp188_set_tablesel_comboitems("dzgf_t.dzgf005", TRUE)
            LET g_filter_idx = DIALOG.getCurrentRow("s_filter")
            #預設點選的資料顯示在維護元件上
            CALL adzp188_separate_filter_wc(g_filter_idx)  
            ##150323 add -(s)  
            LET g_dzgf_d.dzgf008 = adzp188_filter_sample("dzgf008")
            DISPLAY g_dzgf_d.dzgf008  TO dzgf_t.dzgf008
            CALL cl_set_comp_font_color("dzgf008","gray")
            ##150323 add -(e)            
            #CALL adzp188_set_field_comboitems("dzgf_t.dzgf006", g_tablesel[1].id, TRUE) RETURNING g_dzgf_d.dzgf006
            DISPLAY adzp188_filter_sample("dzgf005") TO FORMONLY.sample005
            DISPLAY adzp188_filter_sample("dzgf006") TO FORMONLY.sample006
            DISPLAY adzp188_filter_sample("dzgf007") TO FORMONLY.sample007
            DISPLAY adzp188_filter_sample("dzgf008") TO FORMONLY.sample008
            
         END IF

      ##140414 add-140610(s)
      ##自訂定欄位
      ON ACTION userdef_field
        IF g_dzgd006_1 = "3" THEN 
           #CALL adzp188_01(g_tablesel,g_dzgd_d.dzgd003,g_dzgd_d.dzgd005, g_dzgd004_1, g_dzgd004_2) RETURNING g_dzgd_d.dzgd006
           CALL adzp188_01() #RETURNING g_dzgd_d.dzgd006
        END IF  
      ##140414 add-140610(e) 

         
      #切換到彙總頁簽
      ON ACTION page_summary
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #如果沒有挑選彙總資料, 不需要進入
            CALL adzp188_summary2_b_fill()
            IF g_summarylist2.getLength() <=0 THEN 
                ##預設彙總資料存入
               CALL adzp188_summary2_default()     
            END IF 
            CALL adzp188_summary2_b_fill()
            NEXT FIELD summaryname1
         END IF


         
      #切換到GR排版頁簽
      ON ACTION page_type1
         #如果沒有挑選資料表, 不需要進入
         
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #如果沒有挑選排版資料, 不需要進入
            CALL adzp188_typelist1_b_fill()
            IF g_typelist2.getLength() <=0 THEN 
                ##預設彙總資料存入
               CALL adzp188_typelist2_default()    
            END IF 
            CALL adzp188_typelist2_b_fill()
            NEXT FIELD typename1
         END IF
         
      #切換到XG排版頁籤
      ON ACTION page_type  
        #140703 add -(s)
        #如果沒有挑選資料表, 不需要進入
         
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #如果沒有挑選排版資料, 不需要進入
            CALL adzp188_xgtypelist1_b_fill()
            IF g_xgtypelist1.getLength() <=0 THEN 
                ##預設彙總資料存入
               CALL adzp188_xg_type_default()    
            END IF 
            CALL adzp188_xgtypelist1_b_fill()
            NEXT FIELD xgtypename1

         END IF 
        #140703 add -(e)       

      #切換到排名次頁簽
      ON ACTION page_order
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #預設資料
         END IF         

      #切換到圖形頁簽
      ON ACTION page_chart

      #切換到主題頁簽
      ON ACTION page_theme


      #切換到參數頁簽
      ON ACTION page_arg
         #如果沒有挑選資料表, 不需要進入
         IF g_tablesel.getLength() <= 0 THEN
            NEXT FIELD table_list
         ELSE
            #預設資料
            CALL adzp188_argsel_b_fill()         
            NEXT FIELD dzgj003
         END IF
      
      ON ACTION verify_sql
         #MESSAGE ""
         #MESSAGE "驗證SQL"
         
         #IF adzp188_chk_dzgb_cnt() THEN  ##150121 add 有來源才驗證sql，沒有來源就不驗證sql #150126 mark
             ##141127  add-(s)
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00475"
             LET g_errparam.extend = NULL 
             LET g_errparam.popup = FALSE
             CALL cl_err()
             ##141127  add-(e)  
             LET g_stus = "draft_save"      #161215-00029#1 add 儲存新值       
             CALL adzp188_draft_save()
             ##組報表元件的sql ##140410-(S)

             #CALL adzp188_combine_sql_to_verify(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003) RETURNING ls_sql  ##150126 mark
             CALL adzp188_combine_sql_to_verify(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003) RETURNING ls_sql,ls_sql1  #150126 add
             IF NOT adzp188_chk_cartesian(ls_sql1)   THEN    ##150126 add -(s)            
             
                 ##驗證sql
                 IF sadzp190_sql_verify(ls_sql) THEN  ##若true

                 ELSE ##若false
                     ##產生sql檔
                    LET li_linesize = 300  ##每行寬度
                    LET li_pagesize = 20   ##一頁20行
                    CALL sadzp190_db_gen_sql_file(ls_sql,li_linesize,li_pagesize) RETURNING ls_filename
                    LET li_rowcount = 10   ##sql回傳值顯示的行數
                    ##執行sqlplus
                    CALL sadzp190_db_run(ls_filename,li_rowcount) RETURNING ls_result
                    ##彈窗提示產生完成
                     #CALL cl_err_msg(NULL, ls_result, "", 1)  ##先不用，因為在上面的function裡已有彈窗
                     #161215-00029#1 add -(s) 
                     IF cl_ask_confirm_parm("adz-01147", g_dzga001_t) THEN
                        CALL adzp188_delete_table()
                     END IF 
                     #161215-00029#1 add -(e)                     
                    # CALL adzp188_delete_table()        #161215-00029#1 mark          
                     #MESSAGE "SQL驗證錯誤"  #141127 mark
                     ##141127  add-(s)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00476"
                     LET g_errparam.extend = NULL 
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     ##141127  add-(e)              
                 END IF
                 #MESSAGE "SQL驗證完成"   #141127 mark
                 ##141127  add-(s)
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code =  "adz-00477"
                 LET g_errparam.extend = NULL 
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 ##141127  add-(e)           
                 NEXT FIELD dzga001
             ##150126 add -(s)
             ELSE
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code =  "adz-00538"
                 LET g_errparam.extend = NULL 
                 LET g_errparam.popup = FALSE
                 CALL cl_err()               
             END IF
             ##150126 add -(e) 
         #END IF   ##150121 add 有來源才驗證sql，沒有來源就不驗證sql  #150126 mark

      ON ACTION gen_4rp
         #MESSAGE "產生報表樣板(4rp)"   #141127 mark
         ##141127  add-(s)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00474"
         LET g_errparam.extend = NULL 
         LET g_errparam.popup = FALSE
         CALL cl_err()
         ##141127  add-(e)
         ##gen 4rp
         IF g_dzga_m.dzga003 ='1' THEN 
            LET g_stus = "comp_save"      #161215-00029#1 add
            CALL adzp188_draft_save()
            DELETE FROM dzgh_t WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002   #140114
                                 AND dzgh003 = g_dzga_m.dzga001
              ##GR樣板設定明細
             LET l_seq = 1
             CALL lc_type2.clear()
             LET g_sql = " SELECT * FROM adzp188_type2_tmp ",
                        # "  WHERE dzgh001 ='",g_dzga_m.dzga001,"' AND dzgh002 ='", g_dzga_m.dzga002,"'", #140923 elena mark
                         "  WHERE dzgh001 ='",g_dzga_m.dzga001,"' AND dzgh002 ='", gs_ver,"'",   #140923 elena add
                         "    AND dzgh003 ='",g_dzga_m.dzga001,"' AND pid2 IS NOT NULL",
                         "  ORDER BY pidtype2,pidseq2,idseq2 "
             PREPARE adzp188_insert_dzgh_pre1 FROM g_sql
             DECLARE adzp188_insert_dzgh_cs1 CURSOR FOR adzp188_insert_dzgh_pre1
             FOREACH adzp188_insert_dzgh_cs1 INTO lc_type2[l_seq].*
                 IF NOT cl_null(lc_type2[l_seq].pid2) THEN
                    INSERT INTO dzgh_t
                      #VALUES ( g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzga_m.dzga001,l_seq,lc_type2[l_seq].pidtype2,lc_type2[l_seq].pidseq2,lc_type2[l_seq].id2,lc_type2[l_seq].idseq2,lc_type2[l_seq].alias2,'') #140327 add lc_type2[l_seq].alias2,'' #140617 mark
                      VALUES ( g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzga_m.dzga001,l_seq,lc_type2[l_seq].pidtype2,lc_type2[l_seq].pidseq2,lc_type2[l_seq].id2,lc_type2[l_seq].idseq2,lc_type2[l_seq].alias2,'',g_cust,g_code_ide)   #140617 add
                 END IF 
                 LET l_seq = l_seq + 1 
             END FOREACH 

             ##存dzgg_t樣板單頭單(GR才存)
             DELETE FROM dzgg_t WHERE dzgg001 = g_dzga_m.dzga001 AND dzgg002 = g_dzga_m.dzga002 AND dzgg003 = g_dzga_m.dzga001 AND dzgg017 = g_code_ide #140616 add AND dzgg017 = g_code_ide  
             LET g_dzgg_d.dzgg004 = g_gr_temp_set.c_masterzone
             LET g_dzgg_d.dzgg005 = g_gr_temp_set.c_detailrow
             LET g_dzgg_d.dzgg006 = g_gr_temp_set.c_signoff
             LET g_dzgg_d.dzgg007 = g_gr_temp_set.c_memosubrep 
             IF cl_null(g_dzgg_d.dzgg006) THEN LET g_dzgg_d.dzgg006 ="Y" END IF
             IF cl_null(g_dzgg_d.dzgg007) THEN LET g_dzgg_d.dzgg007 ="Y" END IF             
             IF g_paper_set.r_format ="1" THEN  #標準
                CASE g_paper_set.c_std  ##以後若有報表紙張檔，要置換
                  WHEN "1" 
                       LET g_dzgg_d.dzgg008 = "A4"
                  WHEN "2" 
                       LET g_dzgg_d.dzgg008 = "A3"                   
                END CASE 
             ELSE ##自定義紙張
                  LET g_dzgg_d.dzgg008 = g_paper_set.custom
             END IF 
             ##紙張方向
             IF g_paper_set.r_direction ="1" THEN 
                LET g_dzgg_d.dzgg009 = "P"
             ELSE 
                LET g_dzgg_d.dzgg009 = "L"
             END IF 
             ##邊界
             LET g_dzgg_d.dzgg010 = g_paper_set.top
             LET g_dzgg_d.dzgg011 = g_paper_set.botton
             LET g_dzgg_d.dzgg012 = g_paper_set.left
             LET g_dzgg_d.dzgg013 = g_paper_set.right
             LET g_dzgg_d.dzgg014 = g_paper_set.r_direction         
             LET g_dzgg_d.dzgg015 = g_gr_temp_set.c_detailtable    ##140505單身表格化
             INSERT INTO dzgg_t
                    VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,g_dzgg_d.dzgg004,g_dzgg_d.dzgg005,g_dzgg_d.dzgg006,g_dzgg_d.dzgg007,g_dzgg_d.dzgg008,g_dzgg_d.dzgg009,g_dzgg_d.dzgg010,g_dzgg_d.dzgg011,g_dzgg_d.dzgg012,g_dzgg_d.dzgg013,g_dzgg_d.dzgg014,g_dzgg_d.dzgg015,g_cust,g_code_ide) #140616 add ,g_cust,g_code_ide
             ##重產生報表  
             CALL adzp188_comp_gen(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003,lc_cmd)      
             CALL sadzp188_gen4rp(g_dzga_m.dzga001, g_dzga_m.dzga002,g_gzza001,g_code_ide)
             ##彈窗提示產生完成
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00270"
             LET g_errparam.extend = NULL 
             LET g_errparam.popup = TRUE
             CALL cl_err()
         END IF 
         NEXT FIELD dzga001   
      
      ON ACTION draft_save
         IF adzp188_chk_dzgj_exist() > 0 THEN   #150525-00029#1 add
            IF adzp188_chk_dzge_exist() > 0 THEN   #151023-00015#1 add
                 #MESSAGE "儲存底稿"     #141127 mark
                 ##141127 add -(s)
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code =  "adz-00472"
                 LET g_errparam.extend = NULL 
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 ##141127 add -(s)   
                 LET g_stus = "draft_save"      #161215-00029#1 add        
                 CALL adzp188_draft_save()
             #151023-00015#1 add -(s)    
             ELSE 
              ##憑證頁籤列印群組未設置資料。
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code =  "adz-00741"
              LET g_errparam.extend = NULL 
              LET g_errparam.popup = TRUE
              CALL cl_err()                
             END IF 
             #151023-00015#1 add -(e)
         #150525-00029#1 add -(s)   
         ELSE 
              ##參數頁籤未設置資料。
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code =  "adz-00616"
              LET g_errparam.extend = NULL 
              LET g_errparam.popup = TRUE
              CALL cl_err()             
         END IF 
         #150525-00029#1 add -(e) 

      ON ACTION clear_view
         #MESSAGE "清除畫面資料"   #141127 mark
         ##141127 add -(s)
         IF cl_ask_confirm_parm("adz-00471", g_gzza001) THEN     ##150525-00029#1 add          
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00471"
             LET g_errparam.extend = NULL 
             LET g_errparam.popup = FALSE
             CALL cl_err()
             ##141127 add -(s)    
             CALL adzp188_clear_view()
         END IF                                                  ##150525-00029#1 add
         NEXT FIELD dzga001      
         
      ON ACTION comp_gen
         #先儲存底稿
         #MESSAGE "產生報表元件中"  #141127 mark
         ##141127 add -(s)
         ##提示重產會覆蓋原程式碼與xg樣板
         
         IF g_dzga_m.dzga003 ="2" THEN  ##150112 XG才顯示
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00473"
             LET g_errparam.extend = NULL 
             LET g_errparam.popup = TRUE
             CALL cl_err()
         END IF ##150112 XG才顯示
         
         ##產生報表元件中訊息
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00472"
         LET g_errparam.extend = NULL 
         LET g_errparam.popup = FALSE
         CALL cl_err()
         ##141127 add -(s)         
         #141105 add-(s)
         IF g_argsel_idx > 0 THEN 
             CALL adzp188_maintain_dzgj(g_argsel_idx)  
         END IF
         #141105 add-(e)    

         LET g_stus = "comp_save"      #161215-00029#1 add
         CALL adzp188_draft_save()

         ## 判斷參數頁籤是否有值
         IF adzp188_chk_dzgj_exist() > 0 THEN   #150525-00029#1 add  

            IF adzp188_chk_dzge_exist() > 0 THEN   #151023-00015#1 add         
             ##組報表元件的sql ##140410-(S)
             #IF adzp188_chk_dzgb_cnt() THEN  ##150121 add 有來源才驗證sql，沒有來源就不驗證sql 
                 #CALL adzp188_combine_sql_to_verify(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003) RETURNING ls_sql
                 CALL adzp188_combine_sql_to_verify(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003) RETURNING ls_sql,ls_sql1
                 IF NOT adzp188_chk_cartesian(ls_sql1) THEN    ##150126 add -(s)                    
                     ##驗證sql
                     IF sadzp190_sql_verify(ls_sql) THEN  ##若true
                        ##產生報表元件            
                        CALL adzp188_comp_gen(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003,lc_cmd)
                        ##彈窗提示產生完成
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "adz-00270"
                        LET g_errparam.extend = NULL 
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        ##140605 XG還要存gzgg026的欄位別名

                     ELSE ##若false
                         ##產生sql檔
                        LET li_linesize = 300  ##每行寬度
                        LET li_pagesize = 20   ##一頁20行
                        CALL sadzp190_db_gen_sql_file(ls_sql,li_linesize,li_pagesize) RETURNING ls_filename
                        LET li_rowcount = 10   ##sql回傳值顯示的行數
                        ##執行sqlplus
                        CALL sadzp190_db_run(ls_filename,li_rowcount) RETURNING ls_result
                        ##彈窗提示產生完成
                         #CALL cl_err_msg(NULL, ls_result, "", 1)  ##先不用，因為在上面的function裡已有彈窗
                         #MESSAGE "產生報表元件SQL驗證錯誤"  #141127 mark
                         #161215-00029#1 add -(s)
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code =  "adz-01148"
                         LET g_errparam.extend = NULL 
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         ##產生報表元件            
                         CALL adzp188_comp_gen(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003,lc_cmd)
                         ##彈窗提示產生完成
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code =  "adz-00270"
                         LET g_errparam.extend = NULL 
                         LET g_errparam.popup = TRUE
                         CALL cl_err()              
                         #161215-00029#1 add -(e)                         
                         #141127 add -(s)
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code =  "adz-00478"
                         LET g_errparam.extend = NULL 
                         LET g_errparam.popup = FALSE
                         CALL cl_err()
                         ##141127 add -(e)               
                     END IF
                 ##150121 add 有來源才驗證sql，沒有來源就不驗證sql-(s)
                 ELSE
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code =  "adz-00538"
                       LET g_errparam.extend = NULL 
                       LET g_errparam.popup = FALSE
                       CALL cl_err()     
                        ##產生報表元件            
                        CALL adzp188_comp_gen(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003,lc_cmd)
                        ##彈窗提示產生完成
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "adz-00270"
                        LET g_errparam.extend = NULL 
                        LET g_errparam.popup = TRUE
                        CALL cl_err()         
                 END IF
                ##150121 add 有來源才驗證sql，沒有來源就不驗證sql-(e) 

            ##151023-00015#1 add -(s)    
            ELSE 
              ##憑證頁籤列印群組未設置資料。
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code =  "adz-00741"
              LET g_errparam.extend = NULL 
              LET g_errparam.popup = TRUE
              CALL cl_err()               
            END IF 
            ##151023-00015#1 add -(e)
         #150525-00029#1 add -(s)   
         ELSE 
              ##參數頁籤未設置資料。
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code =  "adz-00616"
              LET g_errparam.extend = NULL 
              LET g_errparam.popup = TRUE
              CALL cl_err()             
         END IF 
         #150525-00029#1 add -(e)   
     ##150226 mark -(s)   
      ##切換到報表資料模型  
      #ON ACTION rpt_data_model      
         #IF NOT cl_null(g_dzga_m.dzga001) THEN
           ##若選自定義紙張，長寬必需輸入 
           #IF g_paper_set.r_format = "2" THEN  #非選標準
               #IF (cl_null(g_paper_set.len) OR cl_null(g_paper_set.width)) OR 
                  #(g_paper_set.len <= 0 OR g_paper_set.width <= 0) OR 
                  #(g_paper_set.len IS NULL OR g_paper_set.width IS NULL)
               #THEN
                   #NEXT FIELD len
               #END IF 
           #END IF
           ##邊界不可為空或負數
           #IF (cl_null(g_paper_set.left) OR cl_null(g_paper_set.right) OR 
              #cl_null(g_paper_set.top) OR cl_null(g_paper_set.botton)) OR 
              #(g_paper_set.left < 0 OR g_paper_set.right < 0 OR 
               #g_paper_set.top < 0 OR g_paper_set.botton < 0) THEN 
               #NEXT FIELD left
           #END IF           
           #
           #CALL adzp188_tablesel_b_fill()           #資料表
           #CALL adzp188_tablejoin_wclist_b_fill()   #連結
           #CALL adzp188_filter_b_fill()             #篩選
           #IF g_dzga_m.dzga003 ='2' THEN 
              #CALL adzp188_xg_grouplist_b_fill()       #群組140113
              #CALL adzp188_xg_groupsel_b_fill()       #群組140113
              #CALL adzp188_xgtypelist1_b_fill()
           #ELSE 
              #CALL adzp188_gr_grouplist_b_fill()       #群組140113
              #CALL adzp188_gr_groupsel_b_fill()       #群組140113
              #CALL adzp188_typelist1_b_fill()
              #CALL adzp188_typelist2_b_fill()               
           #END IF 
         #END IF  
         #
         #CALL gfrm_curr.setElementHidden("folder1", FALSE)
         #CALL gfrm_curr.setElementHidden("vbox17", TRUE)
         #CALL gfrm_curr.setElementStyle("rpt_data_model", "reportmainfun1")
         #CALL gfrm_curr.setElementStyle("rpt_model_setting", "reportmainfun")
         #NEXT FIELD dzga001
         #
      ##切換到樣板設定
      #ON ACTION rpt_model_setting
         #CALL gfrm_curr.setElementHidden("vbox17", FALSE)
         #CALL gfrm_curr.setElementHidden("folder1", TRUE)
         #CALL gfrm_curr.setElementStyle("rpt_data_model", "reportmainfun")
         #CALL gfrm_curr.setElementStyle("rpt_model_setting", "reportmainfun1")        
         #NEXT FIELD dzga001    ##先跳回單頭，等樣板設定寫好再跳回這頁的欄位，艾註意
      ##150226 mark -(s)

      ON ACTION fieldsel_all #140221           
         CALL adzp188_field_sel('Y')
         
      ON ACTION fieldsel_can
         CALL adzp188_field_sel('N')

         
      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION close
         EXIT DIALOG
   END DIALOG

END FUNCTION

##150506  NO.150507-00002#1 原版的adzp188_default() -(s)
#FUNCTION adzp188_default()
   #DEFINE li_cmd         STRING
   #DEFINE lc_dzga002     LIKE dzga_t.dzga002    #141013 janet mark
   #DEFINE l_display      LIKE type_t.num5
   #DEFINE l_report_type  STRING 
   #DEFINE l_tablesel     DYNAMIC ARRAY OF RECORD 
          #dzgb005        LIKE dzgb_t.dzgb005,
          #dzgb009        LIKE dzgb_t.dzgb009
          #END RECORD 
   #DEFINE ls_exist       LIKE type_t.num5
   #DEFINE ls_tableseq    LIKE type_t.num5
   #DEFINE li_cnt         LIKE type_t.num5
   #DEFINE l_dzgb011_str  STRING 
   #DEFINE l_dzgb011      LIKE dzgb_t.dzgb011
   #DEFINE l_alias        STRING 
   #DEFINE l_alias_seq    LIKE type_t.num5
   #DEFINE l_cnt          LIKE type_t.num5
   ##DEFINE lc_dzga002     STRING               #141013 janet add 
#
   ##先將暫存檔清空
   #CALL adzp188_delete_temptable()
#
   ##報表元件名稱
   #INITIALIZE g_ref_fields TO NULL
   #LET g_dzga001 = g_dzga_m.dzga001
   #LET g_ref_fields[1] = g_dzga001
   #CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
   #DISPLAY g_rtn_fields[1] TO formonly.dzga001_desc 
  #
#
   ##LET g_gzza001 = g_gzza001
   ##參考程式名稱
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_gzza001
   #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
   #DISPLAY g_rtn_fields[1] TO formonly.gzza001_desc 
#
#
#
   ##150506  NO.150507-00002#1 add 複製功能 -(s)
      #CALL cl_adz_get_code_curr_revision(g_dzga_m.dzga001,NULL, g_prog_type) RETURNING g_ver,g_code_ide,ls_err_msg   #140730 add
      #LET g_dzga_m.dzga002 = g_ver 
      #LET gs_ver = g_dzga_m.dzga002 CLIPPED  #140923 elena add
      #LET gs_ver = gs_ver.trim()             #140923 elena add  #141013 mark
      ##140617 add-(e)
      #IF g_code_ide = "s" THEN 
         ##LET g_gzgf003 = "N"   ##141013 mark
         #LET g_gzgf003 = "s"    ##141013 add
      #ELSE 
         ##LET g_gzgf003 = "Y"   ##141013 mark
         #LET g_gzgf003 = "c"    ##141013 add
      #END IF
     ##140617 add-(e) 
      #IF NOT cl_null(ls_err_msg) THEN
        #INITIALIZE g_errparam TO NULL
        #LET g_errparam.code = ls_err_msg
        #LET g_errparam.extend = ''
        #LET g_errparam.popup = TRUE
        #CALL cl_err()        
      #END IF  
   ##150506  NO.150507-00002#1 add 複製功能 -(e)
   #
  #
   ##g_dzga_m.dzga002為目前要維護的版次, 先找出是否存在此版次設計資料
   #
   #SELECT COUNT(*) INTO g_cnt FROM dzga_t 
    #WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = g_dzga_m.dzga002 
      ##AND dzga005 = g_cust AND dzga006 = g_code_ide  #141016 mark  
      #AND dzga006 = g_code_ide  #141016 add  
    #
                                        #
   #IF g_cnt > 0 THEN
      ##有資料, 表示透過已存在底稿進行再維護
      #LET li_cmd = "u"
      #LET lc_dzga002 = ''                  #141013 janet add
      #LET lc_dzga002 = g_dzga_m.dzga002
        #
      #SELECT dzga003,dzga004 INTO g_dzga_m.dzga003,g_dzga_m.dzga004 
        #FROM dzga_t  
       #WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = g_dzga_m.dzga002 
         ##AND dzga005 = g_cust AND dzga006 = g_code_ide #140613 add  #141013 mark 
         #AND dzga006 = g_code_ide #141013 add
#
      ##XG
      #IF g_dzga_m.dzga003 = '2' THEN 
          ##判斷是否有xg樣板單頭
#
          #SELECT COUNT(*) INTO g_xg_cnt FROM gzgf_t 
          #WHERE gzgfstus='Y' #AND gzgfent = g_enterprise   #140612 mark ent
            #AND gzgf001 = g_dzga_m.dzga001 AND gzgf002 = g_dzga_m.dzga001
            #AND gzgf004 = 'default' AND gzgf005 = 'default'
            ##AND gzgf003 = g_code_ide   #140612 add #140617 mark
            #AND gzgf003 = g_gzgf003      #140617 add
                        #
          #IF g_xg_cnt > 0 THEN    
              ##XG抓出最新筆樣板ID
              #SELECT gzgf000 INTO g_gzgf000 FROM gzgf_t 
              #WHERE gzgfstus='Y' #AND gzgfent = g_enterprise  #140612 mark ent
                #AND gzgf001 = g_dzga_m.dzga001 AND gzgf002 = g_dzga_m.dzga001
                #AND gzgf004 = 'default' AND gzgf005 = 'default'
                ##AND gzgf003 = g_code_ide                           #140612 add  #140617 mark
                #AND gzgf003 = g_gzgf003      #140617 add
          #END IF 
          ###150226 mark -(s)
          ##CASE g_dzga_m.dzga004
              ##WHEN "2"  #明細表
                    ##LET g_temp_set.r_detail = "1"
                    ##LET g_temp_set.r_povit = ""
                    ##LET g_temp_set.r_tree = ""   
              ##WHEN "3"  #交叉表 
                   ##LET g_temp_set.r_povit = "1"    
                   ##LET g_temp_set.r_detail = ""
                   ##LET g_temp_set.r_tree = ""                 
              ##WHEN "6"  #樹狀表
                   ##LET g_temp_set.r_tree = "1" 
                   ##LET g_temp_set.r_detail = ""
                   ##LET g_temp_set.r_povit = ""                   
          ##END CASE 
          ##DISPLAY g_temp_set.r_detail TO formonly.r_detail
          ##DISPLAY g_temp_set.r_povit TO formonly.r_povit
          ##DISPLAY g_temp_set.r_tree TO formonly.r_tree  
          ###150226 mark -(e)
         ##150330 add -(s)
         #IF g_dzga_m.dzga004 IS NULL OR g_dzga_m.dzga004="" THEN
            #LET g_dzga_m.dzga004 = "2"
         #END IF
         ##150330 add -(e)          
      #ELSE 
         ##150226 mark -(s)
         ##CASE g_dzga_m.dzga004
              ##WHEN "1"  #憑證
                   ##LET g_gr_temp_set.r_voucher = "1"
                   ##LET g_gr_temp_set.r_label = ""
                   ##LET g_gr_temp_set.r_overlay = ""                
              ##WHEN "4"  #標籤
                   ##LET g_gr_temp_set.r_label = "1"
                   ##LET g_gr_temp_set.r_voucher = ""
                   ##LET g_gr_temp_set.r_overlay = ""                   
              ##WHEN "5"  #套表
                   ##LET g_gr_temp_set.r_overlay = "1"    
                   ##LET g_gr_temp_set.r_label = ""
                   ##LET g_gr_temp_set.r_voucher = ""               
          ##END CASE  
          ##150226 mark -(e)
         ##抓出紙張、樣板相關設定dzgg_t
         #SELECT dzgg003,dzgg004,dzgg005,dzgg006,dzgg007,dzgg008,dzgg009,dzgg010,dzgg011,dzgg012,dzgg013,dzgg014,dzgg015 
           #INTO g_dzgg_d.*
           #FROM dzgg_t 
          #WHERE dzgg001 = g_dzga_m.dzga001 AND dzgg002 = g_dzga_m.dzga002 AND dzgg003 = g_dzga_m.dzga001 
            #AND dzgg017 = g_code_ide   #140612 add AND dzgg017 = g_code_ide
            #
          #LET g_gr_temp_set.c_masterzone = g_dzgg_d.dzgg004
          #LET g_gr_temp_set.c_detailrow = g_dzgg_d.dzgg005
          #LET g_gr_temp_set.c_signoff = g_dzgg_d.dzgg006
          #LET g_gr_temp_set.c_memosubrep = g_dzgg_d.dzgg007
          #CASE g_dzgg_d.dzgg008 
             #WHEN "A4"
                   #LET g_paper_set.c_std ="1"
                   #LET g_paper_set.r_format ="1"
             #WHEN "A3" 
                   #LET g_paper_set.c_std ="2"
                   #LET g_paper_set.r_format ="1"
             #OTHERWISE 
                   #LET g_paper_set.custom = g_dzgg_d.dzgg008 
                   #LET g_paper_set.r_format ="2"                   
          #END CASE 
          #IF g_dzgg_d.dzgg009 ="P" THEN 
             #LET g_paper_set.r_direction ="1"
          #ELSE 
             #LET g_paper_set.r_direction ="2"          
          #END IF
#
          #IF g_paper_set.c_std = "1" THEN  #A4
             #IF g_paper_set.r_direction = "1" THEN #直向
                #LET g_paper_set.len = 29.70
                #LET g_paper_set.width = 21.00
             #ELSE 
                #LET g_paper_set.len = 21.00 
                #LET g_paper_set.width = 29.70                  
             #END IF               
          #ELSE   #A3
             #IF g_paper_set.r_direction = "1" THEN  #直向
                #LET g_paper_set.len = 42.00
                #LET g_paper_set.width = 29.70
             #ELSE 
                #LET g_paper_set.len = 29.70 
                #LET g_paper_set.width = 42.00                  
             #END IF                      
          #END IF  
          #
         #CALL adzp188_direction_img()
#
       #
         #IF g_dzgg_d.dzgg010 IS NULL THEN LET g_dzgg_d.dzgg010 = 1.30 END IF 
         #LET g_paper_set.top = g_dzgg_d.dzgg010  
         #IF g_dzgg_d.dzgg011 IS NULL THEN LET g_dzgg_d.dzgg011 = 1.30 END IF       
         #LET g_paper_set.botton = g_dzgg_d.dzgg011 
         #IF g_dzgg_d.dzgg012 IS NULL THEN LET g_dzgg_d.dzgg012 = 1.60 END IF 
         #LET g_paper_set.left = g_dzgg_d.dzgg012 
         #IF g_dzgg_d.dzgg013 IS NULL THEN LET g_dzgg_d.dzgg013 = 1.60 END IF 
         #LET g_paper_set.right = g_dzgg_d.dzgg013
#
         #
         #LET g_paper_set.r_unit = g_dzgg_d.dzgg014 
         #LET g_gr_temp_set.c_detailtable = g_dzgg_d.dzgg015   ##140505單身表格化
         #IF cl_null(g_gr_temp_set.c_detailtable) THEN 
            #LET g_gr_temp_set.c_detailtable = "N"
         #END IF 
         ##150323 add -(s)
         #IF g_dzga_m.dzga004 IS NULL OR g_dzga_m.dzga004="" THEN
            #LET g_dzga_m.dzga004 = "1"
         #END IF
         ##150323 add -(e)
      #END IF 
    #
     #
   #ELSE
      ##沒資料, 從前一版本撈出設計資料當作預設值
      ##IF g_dzga_m.dzga002 != "1" THEN
         ##LET lc_dzga002 = g_dzga_m.dzga002 - 1
      ##END IF
      ##這裡應該要從gzgf裡抓最大值+1
      ##SELECT gzgf000+1 INTO g_gzgf000 FROM gzgf_t   #140522
      #CALL security.RandomGenerator.CreateUUIDString() RETURNING g_gzgf000   ##140522
      ##LET g_gzgf000 = '1'
   #END IF
#
   #IF NOT cl_null(lc_dzga002) THEN
      ##報表元件設計主檔  
      #INSERT INTO adzp188_dzga_tmp
         #SELECT * FROM dzga_t WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = lc_dzga002 
                                ##AND dzga005 = g_cust AND dzga006 = g_code_ide  #140612 add   #141017 mark
                                #AND dzga006 = g_code_ide      #141017 add
      ##報表元件設計-資料模型Table明細檔
      #INSERT INTO adzp188_dzgb_tmp
         #SELECT * FROM dzgb_t WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = lc_dzga002 
                                ##AND dzgb018 = g_cust AND dzgb019 = g_code_ide  #140613 add  #141017 mark 
                                #AND dzgb019 = g_code_ide                         #141017 add
      ##報表元件設計-資料模型欄位明細檔   
      #INSERT INTO adzp188_dzgc_tmp
         #SELECT * FROM dzgc_t WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = lc_dzga002 
                                ##AND dzgc008 = g_cust AND dzgc009 = g_code_ide  #140613 add  #141017 mark
                                #AND dzgc009 = g_code_ide                         #141017 add
      ##報表元件設計-資料模型自訂義欄位明細檔   
      #INSERT INTO adzp188_dzgd_tmp
         #SELECT * FROM dzgd_t WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = lc_dzga002 
                                ##AND dzgd007 = g_cust AND dzgd008 = g_code_ide  #140613 add  #141017 mark
                                #AND dzgd008 = g_code_ide                          #141017 add
#
      ##報表元件設計-資料模型篩選條件式明細檔   
      #INSERT INTO adzp188_dzgf_tmp
         #SELECT * FROM dzgf_t WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = lc_dzga002 
                                ##AND dzgf011 = g_cust AND dzgf012 = g_code_ide   #140613 add  #141017 mark
                                #AND dzgf012 = g_code_ide   #141017 add
      ##報表元件設計-資料模型資料表明細檔   
      #INSERT INTO adzp188_dzgi_tmp
         #SELECT * FROM dzgi_t WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = lc_dzga002 
                                ##AND dzgi005 = g_cust AND  dzgi006 = g_code_ide   #140613 add    #141017 mark
                                #AND  dzgi006 = g_code_ide                                        #141017 add
      ##報表元件設計-資料模型樣板明細檔  (排版) 
      #INSERT INTO adzp188_dzgh_tmp
         #SELECT * FROM dzgh_t WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = lc_dzga002 
                                ##AND dzgh011 = g_cust AND dzgh012 = g_code_ide   #140613 add   #141017 mark
                                #AND dzgh012 = g_code_ide   #141017 add
                                #AND dzgh003 = g_dzga_m.dzga001   ##樣板代號先用報表元件來命名
      ##報表元件設計-資料模型GR群組明細檔         
      #INSERT INTO adzp188_dzge_tmp
         #SELECT * FROM dzge_t WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = lc_dzga002 
                                ##AND dzge008 = g_cust AND dzge009 = g_code_ide   #140613 add   #141017 mark
                                #AND dzge009 = g_code_ide   #141017 add 
      ##報表元件設計-參數明細檔         
      #INSERT INTO adzp188_dzgj_tmp
         #SELECT * FROM dzgj_t WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = lc_dzga002 
                                ##AND dzgj007 = g_cust AND dzgj008 = g_code_ide   #140613 add   #141017 mark
                                #AND dzgj008 = g_code_ide   #141017 add       
            #
#
      ##彙總頁籤    
      #CALL adzp188_summary2_default()
       ##GR排版頁籤    
      #CALL adzp188_typelist2_default() 
#
      ##XG排版預設資料  ##140521
      #CALL adzp188_xg_type_default()  
#
      ##140609 add
      #CALL adzp188_argsel_b_fill() 
#
      ##抓最大的別名
      #LET g_sql = " SELECT dzgb011 FROM adzp188_dzgb_tmp ",
                  ##" WHERE dzgb001 = '", g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'", #140923 elena mark
                  #" WHERE dzgb001 = '", g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",  #140923 elena add
                 ## "   AND dzgb018 = '",g_cust,"'",      #140613 add     #141017 mark
                  #"   AND dzgb019 = '",g_code_ide,"'",  #140613 add                 
                  #" ORDER BY dzgb003 "                  
      #PREPARE adzp188_get_max_alias FROM g_sql
      #IF SQLCA.sqlcode THEN
          #INITIALIZE g_errparam TO NULL
          #LET g_errparam.code = SQLCA.sqlcode
          #LET g_errparam.extend = 'PREPARE:'
          #LET g_errparam.popup = TRUE
          #CALL cl_err()
          #EXIT PROGRAM
      #END IF   
      #DECLARE adzp188_get_maxalias_cs1 CURSOR FOR adzp188_get_max_alias    
      #FOREACH adzp188_get_maxalias_cs1 INTO l_dzgb011      
           #LET l_alias = ' t'
           #LET l_dzgb011_str = l_dzgb011
           #IF l_dzgb011_str.getIndexOf(l_alias,1)>0 THEN
              #LET l_dzgb011_str = l_dzgb011_str.subString(l_dzgb011_str.getIndexOf(l_alias,1)+1,l_dzgb011_str.getLength())
              #LET l_dzgb011_str = l_dzgb011_str.subString(1,l_dzgb011_str.getIndexOf(' ',1))
              #LET l_dzgb011_str = l_dzgb011_str.subString(l_dzgb011_str.getIndexOf('t',1)+1,l_dzgb011_str.getLength()-1)
              #LET l_alias_seq = l_dzgb011_str
           #END IF 
      #END FOREACH     
      #LET g_alias_seq = l_alias_seq + 1  
   #END IF
#
   #CALL adzp188_tablesel_b_fill()             #資料表
   #CALL adzp188_tablejoin_wclist_b_fill()     #連結
   #CALL adzp188_filter_b_fill()               #篩選     
   #CALL adzp188_argsel_b_fill()               ##參數頁籤  
   #SELECT COUNT(*) INTO g_arg FROM adzp188_dzgj_tmp 
    #WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
      ##AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add   #141017 mark
      #AND dzgj008 = g_code_ide #141017 add                        
       #
   #IF g_dzga_m.dzga003 ='2' THEN              ##XG
      ##抓xg群組頁籤資料
      #CALL adzp188_xg_groupsel_default()
      #CALL adzp188_xg_grouplist_b_fill()      #群組140113
      #CALL adzp188_xg_groupsel_b_fill()       #群組140113 
      #CALL adzp188_xgtypelist1_b_fill()       #排版140521
      #CALL adzp188_xgtype_b_fill()            #排版140521
   #ELSE 
   #
     #CALL adzp188_gr_gＬrouplist_b_fill()       #群組140113
     #CALL adzp188_gr_groupsel_b_fill()       #群組140113
     #CALL adzp188_typelist2_b_fill()         #排版頁籤    ##140226  
   #END IF 
   #CALL adzp188_summary2_b_fill()             #彙總140122
   ##顯示報表名稱
   #CALL adzp188_display_dzga004()
 #
   #
   #RETURN li_cmd
#
#END FUNCTION
##150506  NO.150507-00002#1 原版的adzp188_default() -(e)


##150506  NO.150507-00002#1 原版的adzp188_default() -(s)
################################################################################
# Descriptions...: 設計資料暫存檔寫入, 並預設帶出, 或參考程式輸入報表元件則抓出預設資料
# Memo...........: 
# Usage..........: CALL adzp188_default()
# Input parameter: ps_dzga001  報表元件
#                  ps_dzga002  版次
#                  ps_code_ide 客製標示
#                  ps_source   來源  空值是呼叫本身，ref是參考程式
# Return code....: li_cmd   新增/修改
# Date & Author..: 2015/5/7
# Modify.........:
################################################################################
#FUNCTION adzp188_default()  ##150506  NO.150507-00002#1 mark
FUNCTION adzp188_default(ps_dzga001,ps_dzga002,ps_code_ide,ps_source)  ##150506  NO.150507-00002#1 add 改成可與參考程式欄位共用，故傳值
   DEFINE li_cmd         STRING
   DEFINE lc_dzga002     LIKE dzga_t.dzga002    #141013 janet mark
   DEFINE l_display      LIKE type_t.num5
   DEFINE l_report_type  STRING 
   DEFINE l_tablesel     DYNAMIC ARRAY OF RECORD 
          dzgb005        LIKE dzgb_t.dzgb005,
          dzgb009        LIKE dzgb_t.dzgb009
          END RECORD 
   DEFINE ls_exist       LIKE type_t.num5
   DEFINE ls_tableseq    LIKE type_t.num5
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE l_dzgb011_str  STRING 
   DEFINE l_dzgb011      LIKE dzgb_t.dzgb011
   DEFINE l_alias        STRING 
   DEFINE l_alias_seq    LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE ps_dzga001     LIKE dzga_t.dzga001  ##150506  NO.150507-00002#1 add
   DEFINE ps_dzga002     LIKE dzga_t.dzga002  ##150506  NO.150507-00002#1 add
   DEFINE ps_code_ide    LIKE dzga_t.dzga006   ##150506  NO.150507-00002#1 add
   DEFINE ps_source      LIKE type_t.chr1     ##150506  NO.150507-00002#1 add
   DEFINE p_dzgb005      LIKE dzgb_t.dzgb005  #160615-00007#1 add
   DEFINE p_dzgb011      LIKE dzgb_t.dzgb011  #160615-00007#1 add
   DEFINE p_dzgb013      LIKE dzgb_t.dzgb013  #160615-00007#1 add
   DEFINE p_dzgb014      LIKE dzgb_t.dzgb014  #160615-00007#1 add
   DEFINE p_dzgb015      LIKE dzgb_t.dzgb015  #160615-00007#1 add
   DEFINE p_dzgb017      LIKE dzgb_t.dzgb017  #160615-00007#1 add
   DEFINE ls_dzgb013     LIKE dzgb_t.dzgb013  #160615-00007#1 add
   DEFINE ls_dzgb015     LIKE dzgb_t.dzgb015  #160615-00007#1 add 
   DEFINE ls_wc          LIKE dzgb_t.dzgb011  #160615-00007#1 add
   DEFINE p_dzgb003      LIKE dzgb_t.dzgb003  #160615-00007#1 add
   
   #先將暫存檔清空
   CALL adzp188_delete_temptable()

   #報表元件名稱
   INITIALIZE g_ref_fields TO NULL
   LET g_dzga001 = g_dzga_m.dzga001
   LET g_ref_fields[1] = g_dzga001
   CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
   DISPLAY g_rtn_fields[1] TO formonly.dzga001_desc 

   ##150222 mark -(s)
   ##參考程式名稱
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_gzza001
   #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
   #DISPLAY g_rtn_fields[1] TO formonly.gzza001_desc 
   ##150222 mark -(e)
      
   #g_dzga_m.dzga002為目前要維護的版次, 先找出是否存在此版次設計資料   
   SELECT COUNT(*) INTO g_cnt FROM dzga_t 
    WHERE dzga001 = ps_dzga001 AND dzga002 = ps_dzga002               
      AND dzga006 = ps_code_ide                                           
                                        
   IF g_cnt > 0 THEN
      #有資料, 表示透過已存在底稿進行再維護
      LET li_cmd = "u"
      LET lc_dzga002 = ''                  
      LET lc_dzga002 = ps_dzga002             
        
      #SELECT dzga003,dzga004 INTO g_dzga_m.dzga003,g_dzga_m.dzga004                           #160921-00012#1 mark
      SELECT dzga003,dzga004,gzde006 INTO g_dzga_m.dzga003,g_dzga_m.dzga004,g_dzga_m.gzde006  #160921-00012#1 add 
        FROM dzga_t  
        LEFT JOIN gzde_t ON gzde001 = ps_dzga001 AND gzde008 = ps_code_ide                     #160921-00012#1 add
       WHERE dzga001 = ps_dzga001 AND dzga002 = lc_dzga002                
         AND dzga006 = ps_code_ide   
         
       #160921-00012#1 add -(s)
       IF  g_dzga_m.gzde006 NOT MATCHES "[1-9]" THEN 
           LET g_dzga_m.gzde006 ="1"
       END IF  
       #160921-00012#1 add -(e)

         
      #XG
      IF g_dzga_m.dzga003 = '2' THEN 
          ##判斷是否有xg樣板單頭

          SELECT COUNT(*) INTO g_xg_cnt FROM gzgf_t 
          WHERE gzgfstus='Y' 
            AND gzgf001 = ps_dzga001 AND gzgf002 = ps_dzga001               
            AND gzgf004 = 'default' AND gzgf005 = 'default'
            AND gzgf003 = ps_code_ide                                      
                        
          IF g_xg_cnt > 0 THEN    
              #XG抓出最新筆樣板ID
              SELECT gzgf000 INTO g_gzgf000 FROM gzgf_t 
              WHERE gzgfstus='Y' 
                AND gzgf001 = ps_dzga001 AND gzgf002 = ps_dzga001               
                AND gzgf004 = 'default' AND gzgf005 = 'default' 
                AND gzgf003 = ps_code_ide                                      
          END IF 

         IF g_dzga_m.dzga004 IS NULL OR g_dzga_m.dzga004="" THEN
            LET g_dzga_m.dzga004 = "2"
         END IF
         #160921-00012#1  add-(s)
         IF g_dzga_m.dzga004 IS NULL OR g_dzga_m.dzga004="" THEN
            LET g_dzga_m.dzga004 = "2"
         END IF
         #160921-00012#1  add-(e)  
      ELSE 

         ##抓出紙張、樣板相關設定dzgg_t
         SELECT dzgg003,dzgg004,dzgg005,dzgg006,dzgg007,dzgg008,dzgg009,dzgg010,dzgg011,dzgg012,dzgg013,dzgg014,dzgg015 
           INTO g_dzgg_d.*
           FROM dzgg_t  
          WHERE dzgg001 = ps_dzga001 AND dzgg002 = lc_dzga002 AND dzgg003 = ps_dzga001                    
            AND dzgg017 = ps_code_ide                                                                     
            
          LET g_gr_temp_set.c_masterzone = g_dzgg_d.dzgg004
          LET g_gr_temp_set.c_detailrow = g_dzgg_d.dzgg005
          LET g_gr_temp_set.c_signoff = g_dzgg_d.dzgg006
          LET g_gr_temp_set.c_memosubrep = g_dzgg_d.dzgg007
          CASE g_dzgg_d.dzgg008 
             WHEN "A4"
                   LET g_paper_set.c_std ="1"
                   LET g_paper_set.r_format ="1"
             WHEN "A3" 
                   LET g_paper_set.c_std ="2"
                   LET g_paper_set.r_format ="1"
             OTHERWISE 
                   LET g_paper_set.custom = g_dzgg_d.dzgg008 
                   LET g_paper_set.r_format ="2"                   
          END CASE 
          IF g_dzgg_d.dzgg009 ="P" THEN 
             LET g_paper_set.r_direction ="1"
          ELSE 
             LET g_paper_set.r_direction ="2"          
          END IF

          IF g_paper_set.c_std = "1" THEN  #A4
             IF g_paper_set.r_direction = "1" THEN #直向
                LET g_paper_set.len = 29.70
                LET g_paper_set.width = 21.00
             ELSE 
                LET g_paper_set.len = 21.00 
                LET g_paper_set.width = 29.70                  
             END IF               
          ELSE   #A3
             IF g_paper_set.r_direction = "1" THEN  #直向
                LET g_paper_set.len = 42.00
                LET g_paper_set.width = 29.70
             ELSE 
                LET g_paper_set.len = 29.70 
                LET g_paper_set.width = 42.00                  
             END IF                      
          END IF  
          
         CALL adzp188_direction_img()

       
         IF g_dzgg_d.dzgg010 IS NULL THEN LET g_dzgg_d.dzgg010 = 1.30 END IF 
         LET g_paper_set.top = g_dzgg_d.dzgg010  
         IF g_dzgg_d.dzgg011 IS NULL THEN LET g_dzgg_d.dzgg011 = 1.30 END IF       
         LET g_paper_set.botton = g_dzgg_d.dzgg011 
         IF g_dzgg_d.dzgg012 IS NULL THEN LET g_dzgg_d.dzgg012 = 1.60 END IF 
         LET g_paper_set.left = g_dzgg_d.dzgg012 
         IF g_dzgg_d.dzgg013 IS NULL THEN LET g_dzgg_d.dzgg013 = 1.60 END IF 
         LET g_paper_set.right = g_dzgg_d.dzgg013

         
         LET g_paper_set.r_unit = g_dzgg_d.dzgg014 
         LET g_gr_temp_set.c_detailtable = g_dzgg_d.dzgg015   ##140505單身表格化
         IF cl_null(g_gr_temp_set.c_detailtable) THEN 
            LET g_gr_temp_set.c_detailtable = "N"
         END IF 

         IF g_dzga_m.dzga004 IS NULL OR g_dzga_m.dzga004="" THEN
            LET g_dzga_m.dzga004 = "1"
         END IF
         ##160921-00012#1  add -(s)
         IF g_dzga_m.gzde006 IS NULL OR g_dzga_m.gzde006 ="" THEN
            LET g_dzga_m.gzde006 = "1"
         END IF
         ##160921-00012#1  add -(e)
      END IF 
    
     
   ELSE

      IF ps_source ="" THEN 
         CALL security.RandomGenerator.CreateUUIDString() RETURNING g_gzgf000   
      ELSE 
         ##先不用寫好了 
      END IF

      
   END IF

   IF NOT cl_null(lc_dzga002) THEN
      #報表元件設計主檔  
      INSERT INTO adzp188_dzga_tmp
         SELECT * FROM dzga_t WHERE dzga001 = ps_dzga001 AND dzga002 = lc_dzga002            
                                AND dzga006 = ps_code_ide     

      #報表元件設計-資料模型Table明細檔
      INSERT INTO adzp188_dzgb_tmp
         SELECT * FROM dzgb_t WHERE dzgb001 = ps_dzga001 AND dzgb002 = lc_dzga002           
                                AND dzgb019 = ps_code_ide                                   
      #160615-00007#1 add - (s)
      DECLARE dzgb_data SCROLL CURSOR FOR  
      SELECT dzgb003,dzgb005,dzgb011,dzgb013,dzgb014,dzgb015,dzgb017           
        FROM dzgb_t
       WHERE dzgb001 = ps_dzga001 AND dzgb002 = ps_dzga002
      FOREACH dzgb_data INTO p_dzgb003,p_dzgb005,p_dzgb011,p_dzgb013,p_dzgb014,p_dzgb015,p_dzgb017
         IF p_dzgb013 IS NOT NULL  AND p_dzgb015 IS NOT NULL THEN 
          CALL sadzp188_get_jointable_key(p_dzgb005,p_dzgb013,p_dzgb014,p_dzgb015) RETURNING ls_dzgb013,ls_dzgb015
          LET ls_wc = adzp188_combine_ref_join_wc("", p_dzgb005, ls_dzgb013, "01", "Y", p_dzgb014, ls_dzgb015)
          UPDATE adzp188_dzgb_tmp 
             SET dzgb001 = g_dzga_m.dzga001 , dzgb002 = g_dzga_m.dzga002, dzgb019 = g_code_ide,
                 dzgb011 = ls_wc, dzgb013 = ls_dzgb013, dzgb015 = ls_dzgb015           
           WHERE dzgb001 = ps_dzga001 AND dzgb002 = ps_dzga002 AND dzgb003 = p_dzgb003
         END IF 
      END FOREACH    
      #160615-00007#1 add - (e)

                                
      #報表元件設計-資料模型欄位明細檔   
      INSERT INTO adzp188_dzgc_tmp
         SELECT * FROM dzgc_t WHERE dzgc001 = ps_dzga001 AND dzgc002 = lc_dzga002                                              
                                AND dzgc009 = ps_code_ide                                     

      #報表元件設計-資料模型自訂義欄位明細檔   
      INSERT INTO adzp188_dzgd_tmp
         SELECT * FROM dzgd_t WHERE dzgd001 = ps_dzga001 AND dzgd002 = lc_dzga002           
                                AND dzgd008 = ps_code_ide                                   

      #報表元件設計-資料模型篩選條件式明細檔   
      INSERT INTO adzp188_dzgf_tmp
         SELECT * FROM dzgf_t WHERE dzgf001 = ps_dzga001 AND dzgf002 = lc_dzga002           
                                AND dzgf012 = ps_code_ide                                   
                  
      #報表元件設計-資料模型資料表明細檔   
      INSERT INTO adzp188_dzgi_tmp
         SELECT * FROM dzgi_t WHERE dzgi001 = ps_dzga001 AND dzgi002 = lc_dzga002           
                                AND dzgi006 = ps_code_ide                                   

      #報表元件設計-資料模型樣板明細檔  (排版) 
      INSERT INTO adzp188_dzgh_tmp
         SELECT * FROM dzgh_t WHERE dzgh001 = ps_dzga001 AND dzgh002 = lc_dzga002            
                                AND dzgh012 = ps_code_ide                                    
                                AND dzgh003 = ps_dzga001   ##樣板代號先用報表元件來命名           

      #報表元件設計-資料模型GR群組明細檔         
      INSERT INTO adzp188_dzge_tmp
         SELECT * FROM dzge_t WHERE dzge001 = ps_dzga001 AND dzge002 = lc_dzga002            
                                AND dzge009 = ps_code_ide                                    
                    
      #報表元件設計-參數明細檔         
      INSERT INTO adzp188_dzgj_tmp
         SELECT * FROM dzgj_t WHERE dzgj001 = ps_dzga001 AND dzgj002 = lc_dzga002            
                                AND dzgj008 = ps_code_ide                                    

      IF ps_source = 'r' THEN 
         UPDATE adzp188_dzga_tmp 
            SET dzga001 = g_dzga_m.dzga001, dzga002 = g_dzga_m.dzga002 , dzga006 = g_code_ide
          WHERE dzga001 = ps_dzga001         


         UPDATE adzp188_dzgb_tmp 
            SET dzgb001 = g_dzga_m.dzga001 , dzgb002 = g_dzga_m.dzga002, dzgb019 = g_code_ide              
          WHERE dzgb001 = ps_dzga001   


         UPDATE adzp188_dzgc_tmp 
            SET dzgc001 = g_dzga_m.dzga001 , dzgc002 = g_dzga_m.dzga002 , dzgc009 = g_code_ide
          WHERE dzgc001 = ps_dzga001  

         UPDATE adzp188_dzgd_tmp 
            SET dzgd001 = g_dzga_m.dzga001 , dzgd002 = g_dzga_m.dzga002 , dzgd008 = g_code_ide
          WHERE dzgd001 = ps_dzga001      

         UPDATE adzp188_dzge_tmp 
            SET dzge001 = g_dzga_m.dzga001 , dzge002 = g_dzga_m.dzga002 , dzge009 = g_code_ide
          WHERE dzge001 = ps_dzga001      

         UPDATE adzp188_dzgf_tmp 
            SET dzgf001 = g_dzga_m.dzga001 , dzgf002 = g_dzga_m.dzga002 , dzgf012 = g_code_ide
          WHERE dzgf001 = ps_dzga001   

         UPDATE adzp188_dzgi_tmp 
            SET dzgi001 = g_dzga_m.dzga001 , dzgi002 = g_dzga_m.dzga002, dzgi006 = g_code_ide
          WHERE dzgi001 = ps_dzga001  

         UPDATE adzp188_dzgj_tmp 
            SET dzgj001 = g_dzga_m.dzga001 , dzgj002 = g_dzga_m.dzga002 , dzgj008 = g_code_ide
          WHERE dzgj001 = ps_dzga001   

         UPDATE adzp188_dzgh_tmp 
            SET dzgh001 = g_dzga_m.dzga001 , dzgh002 = g_dzga_m.dzga002 , dzgh003 = g_dzga_m.dzga001 , dzgh012 = g_code_ide
          WHERE dzgh001 = ps_dzga001  
         
          
      END IF 


      #抓最大的別名
      LET g_sql = " SELECT dzgb011 FROM adzp188_dzgb_tmp ",
                  " WHERE dzgb001 = '", ps_dzga001,"' AND dzgb002 = '",lc_dzga002,"'",  
                  "   AND dzgb019 = '",ps_code_ide,"'",       
                  " ORDER BY dzgb003 "                  
      PREPARE adzp188_get_max_alias FROM g_sql
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'PREPARE:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT PROGRAM
      END IF   
      DECLARE adzp188_get_maxalias_cs1 CURSOR FOR adzp188_get_max_alias    
      FOREACH adzp188_get_maxalias_cs1 INTO l_dzgb011      
           LET l_alias = ' t'
           LET l_dzgb011_str = l_dzgb011
           IF l_dzgb011_str.getIndexOf(l_alias,1)>0 THEN
              LET l_dzgb011_str = l_dzgb011_str.subString(l_dzgb011_str.getIndexOf(l_alias,1)+1,l_dzgb011_str.getLength())
              LET l_dzgb011_str = l_dzgb011_str.subString(1,l_dzgb011_str.getIndexOf(' ',1))
              LET l_dzgb011_str = l_dzgb011_str.subString(l_dzgb011_str.getIndexOf('t',1)+1,l_dzgb011_str.getLength()-1)
              LET l_alias_seq = l_dzgb011_str
           END IF 
      END FOREACH     
      LET g_alias_seq = l_alias_seq + 1  
   END IF

   
   CALL adzp188_tablesel_b_fill()             #資料表
   CALL adzp188_tablejoin_wclist_b_fill()     #連結
   CALL adzp188_filter_b_fill()               #篩選     
   CALL adzp188_argsel_b_fill()               ##參數頁籤  

   SELECT COUNT(*) INTO g_arg FROM adzp188_dzgj_tmp 
    WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
      AND dzgj008 = g_code_ide                        
       
   IF g_dzga_m.dzga003 ='2' THEN              ##XG      
      CALL adzp188_xg_groupsel_default()        #抓xg群組頁籤資料       
      CALL adzp188_summary2_default()            #彙總頁籤    
      CALL adzp188_xg_type_default()             ##XG排版預設資料  ##140521    

      IF ps_source ='r' THEN
         #抓xg群組頁籤資料 
         UPDATE adzp188_gexg_tmp              #151012-00003#1 調整tmp名稱縮為17字元
            SET dzge001 = g_dzga_m.dzga001 , dzge002 = g_dzga_m.dzga002 , dzge009 = g_code_ide
          WHERE dzge001 = ps_dzga001      
         #彙總頁籤
         UPDATE adzp188_sum2_tmp 
            SET dzgb001 = g_dzga_m.dzga001 , dzgb002 = g_dzga_m.dzga002 , ide = g_code_ide
          WHERE dzgb001 = ps_dzga001 

         #XG排版預設資料
         UPDATE adzp188_xgtype_tmp 
            SET dzgh001 = g_dzga_m.dzga001 , dzgh002 = g_dzga_m.dzga002 , ide = g_code_ide 
          WHERE dzgh001 = ps_dzga001           
            
      END IF       
      
      CALL adzp188_xg_grouplist_b_fill()      #群組140113
      CALL adzp188_xg_groupsel_b_fill()       #群組140113 
      CALL adzp188_xgtypelist1_b_fill()       #排版140521
      CALL adzp188_xgtype_b_fill()            #排版140521
      CALL adzp188_summary2_b_fill()          #彙總140122      
   ELSE 
       
      CALL adzp188_typelist2_default()        #GR排版頁籤    
      
      IF ps_source = "r" THEN 
         #GR排版預設資料
         UPDATE adzp188_type2_tmp 
            SET dzgh001 = g_dzga_m.dzga001 , dzgh002 = g_dzga_m.dzga002 , dzgh012 = g_code_ide
          WHERE dzgh001 = ps_dzga001           
      END IF 
        
     CALL adzp188_gr_grouplist_b_fill()       #群組140113
     CALL adzp188_gr_groupsel_b_fill()       #群組140113
     CALL adzp188_typelist2_b_fill()         #排版頁籤    ##140226  
   END IF 

   #顯示報表名稱
   CALL adzp188_display_dzga004()
   
   RETURN li_cmd

END FUNCTION
##150506  NO.150507-00002#1 原版的adzp188_default() -(e)

################################################################################
# Descriptions...: 資料表頁簽-準備基本的Table列表供選擇
# Memo...........: 之後改為抓畫面有的table?
# Usage..........: CALL adzp188_tablelist_b_fill(g_gzzo001)
# Input parameter: pc_gzzl001   模組代碼
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_tablelist_b_fill(pc_gzzo001)
   DEFINE   pc_gzzo001   LIKE gzzo_t.gzzo001
   DEFINE   li_cnt       LIKE type_t.num5
   DEFINE   ls_sql_cond  STRING              #150525-00029#1  add
   DEFINE   ls_param     STRING              #150525-00029#1  add


   ##150525-00029#1  add -(s)
   LET ls_param = pc_gzzo001
   LET ls_sql_cond =''
   LET ls_sql_cond = " AND dzea003 ='",ls_param.toUpperCase(),"'",
                     "  OR dzea001 LIKE '",ls_param,"%'"
    
   ##150525-00029#1  add -(e) 
   
   CALL g_tablelist.clear()

   LET g_sql = "SELECT dzea001, dzeal003 FROM dzea_t",
               "  LEFT OUTER JOIN dzeal_t ON dzeal001 = dzea001 AND dzeal002 = '",g_lang,"'",
               #" WHERE dzea003 = '",pc_gzzo001,"'",                                           #150525-00029#1 mark
               " WHERE 1=1 ",                                                                  #150525-00029#1 add
               ls_sql_cond,                                                                    #150525-00029#1 add
               " ORDER BY dzea001"
   PREPARE tablelist_b_fill_pre FROM g_sql
   DECLARE tablelist_b_fill_curs CURSOR FOR tablelist_b_fill_pre
   
   LET li_cnt = 1
   
   FOREACH tablelist_b_fill_curs INTO g_tablelist[li_cnt].*    
     IF SQLCA.sqlcode THEN
       EXIT FOREACH
     END IF
     
     LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_tablelist.deleteElement(li_cnt)

END FUNCTION

################################################################################
# Descriptions...: 資料表頁簽-已挑選資料表列表(多語系) (dzgb005, dzgb009)
# Memo...........: 
# Usage..........: CALL adzp188_tablesel_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_tablesel_b_fill()
   DEFINE li_cnt       LIKE type_t.num5

   CALL g_tablesel.clear()

   ##140206-舊版抓dzgb_tmp裡的table，但無法排主table，故改掉(S)
   #LET g_sql = "SELECT dzgb005, dzeal003 FROM adzp188_dzgb_tmp",
               #"  LEFT OUTER JOIN dzeal_t ON dzeal001 = dzgb005 AND dzeal002 = '",g_lang,"'",
               #" WHERE dzgb001 = '", g_dzga_m.dzga001,"' AND dzgb002 = '", g_dzga_m.dzga002,"'",
               #"  UNION SELECT dzgb009, dzeal003 FROM adzp188_dzgb_tmp",
               #"  LEFT OUTER JOIN dzeal_t ON dzeal001 = dzgb009 AND dzeal002 = '",g_lang,"'",
               #" WHERE dzgb001 = '", g_dzga_m.dzga001,"' AND dzgb002 = '", g_dzga_m.dzga002,"'"
   ##140206-(e)
   LET g_sql = "SELECT dzgi004, dzeal003,dzgi003 FROM adzp188_dzgi_tmp",
               "  LEFT OUTER JOIN dzeal_t ON dzeal001 = dzgi004 AND dzeal002 = '",g_lang,"'",
               #" WHERE dzgi001 = '", g_dzga_m.dzga001,"' AND dzgi002 = '", g_dzga_m.dzga002,"'", #140923 elena mark
               " WHERE dzgi001 = '", g_dzga_m.dzga001,"' AND dzgi002 = '", gs_ver,"'",            #140923 elena add
               #"   AND dzgi005 = '",g_cust,"'",     #140613 add  #141017 mark
               "   AND dzgi006 = '",g_code_ide,"'",     #140613 add
               " ORDER BY dzgi003 "
   PREPARE tablesel_b_fill_pre FROM g_sql
   DECLARE tablesel_b_fill_curs CURSOR FOR tablesel_b_fill_pre
   
   LET li_cnt = 1   
   FOREACH tablesel_b_fill_curs INTO g_tablesel[li_cnt].*    
     IF SQLCA.sqlcode THEN
       EXIT FOREACH
     END IF
       
        LET li_cnt = li_cnt + 1

   END FOREACH

   CALL g_tablesel.deleteElement(li_cnt)

END FUNCTION

################################################################################
# Descriptions...: 資料表頁簽-檢查挑選的table是否有重覆, 重覆就不進"已選資料表"
# Memo...........: 
# Usage..........: CALL adzp188_check_table_repeat(DIALOG.getCurrentRow()) RETURNING li_result
# Input parameter: pi_idx      s_tablelist上focus的行數
# Return code....: TRUE/FALSE  是否重覆
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_check_table_repeat(pi_idx)
   DEFINE pi_idx     LIKE type_t.num5
   DEFINE li_i       LIKE type_t.num5
   DEFINE li_repeat  LIKE type_t.num5

   FOR li_i = 1 TO g_tablesel.getLength()
       #先檢查是否有重覆
       IF g_tablesel[li_i].id = g_tablelist[pi_idx].id THEN
          LET li_repeat = TRUE
          EXIT FOR
       END IF
   END FOR

   RETURN li_repeat

END FUNCTION



################################################################################
# Descriptions...: 彙總頁簽-檢查挑選的欄位是否有重覆, 重覆就不進"彙總已選資料表"
# Memo...........: 
# Usage..........: CALL adzp188_check_summary_repeat(DIALOG.getCurrentRow()) RETURNING li_result
# Input parameter: pi_idx      s_tablelist上focus的行數
# Return code....: TRUE/FALSE  是否重覆
# Date & Author..: 2014/01/27
# Modify.........:
################################################################################
FUNCTION adzp188_check_summary_repeat(pi_idx)
   DEFINE pi_idx     LIKE type_t.num5
   DEFINE li_i       LIKE type_t.num5
   DEFINE li_repeat  LIKE type_t.num5

   FOR li_i = 1 TO g_summarylist2.getLength()
       #先檢查是否有重覆
       IF g_summarylist2[li_i].summaryid2 = g_summarylist1[pi_idx].summaryid1 THEN
          LET li_repeat = TRUE
          EXIT FOR
       END IF
   END FOR

   RETURN li_repeat

END FUNCTION
################################################################################
# Descriptions...: 資料表頁簽-維護選擇的Table
# Memo...........: 
# Usage..........: CALL adzp188_choose_table(DIALOG.getCurrentRow(), "add")
# Input parameter: pi_idx   s_tablelist/s_tablesel上focus的行數
# ...............: ps_type  增加(由s_tablelist寫到s_tablesel)或刪除(s_tablesel的pi_idx行)
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_choose_table(pi_idx, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE l_wc         STRING 
   DEFINE l_del_table  LIKE dzea_t.dzea001
   DEFINE l_gztz001    LIKE gztz_t.gztz001
   DEFINE l_table      STRING 
   DEFINE l_table_len  LIKE type_t.num5
   DEFINE l_tab_spce   STRING
   DEFINE l_wc_tmp     base.StringBuffer
   DEFINE l_next_wc    LIKE dzgb_t.dzgb011
   DEFINE l_do         LIKE type_t.num5
   DEFINE l_dzgb005    LIKE dzgb_t.dzgb005
   DEFINE l_table_str  STRING 
   DEFINE l_del_field  LIKE dzgc_t.dzgc004
   DEFINE l_i          LIKE type_t.num5          ##150525-00029#1 add
   DEFINE l_dzgd006    DYNAMIC ARRAY OF STRING   ##150525-00029#1 add
   

   CASE ps_type
      WHEN "add"
         #從左邊資料表列表複製一份到右方已選擇列表,
         #不刪除左方資料, 因為一改變模組, 要再將已選擇略過不呈現太複雜, 也可能影響速度
         #CALL g_tablesel.appendElement()
         #LET li_i = g_tablesel.getLength()
         #LET g_tablesel[li_i].id = g_tablelist[pi_idx].id
         #LET g_tablesel[li_i].name = g_tablelist[pi_idx].NAME
         #LET g_tablesel[li_i].seq = li_i   
         SELECT MAX(dzgi003)+1 INTO li_i FROM adzp188_dzgi_tmp
          WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
            #AND dzgi005 = g_cust AND dzgi006 = g_code_ide  #140613 add  #141017 mark
            AND dzgi006 = g_code_ide  #141017 add
            
         IF li_i = 0 OR cl_null(li_i) THEN LET li_i =1 END IF 
         
         INSERT INTO adzp188_dzgi_tmp
         VALUES ( g_dzga_m.dzga001,g_dzga_m.dzga002,li_i,g_tablelist[pi_idx].id,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                  
      WHEN "del"
         #從右方已選擇列表移除就好, 為了功能鍵開關處理, 用UI刪除可連同變數一起, 反之不行.
#        CALL g_tablesel.deleteElement(pi_idx)
         ##連帶JOIN頁籤裡的也要刪除--(S)
         LET l_del_table = g_tablesel[pi_idx].id 
         CALL adzp188_tablejoin_wclist_b_fill()
         LET l_do = 0
         LET l_dzgb005 = g_join[1].dzgb005
         FOR li_i = 1 TO g_join.getLength()
             LET l_wc = g_join[li_i].wc 
             IF l_dzgb005 <> g_join[li_i].dzgb005 THEN
                LET l_do = li_i
                LET l_dzgb005 = g_join[li_i].dzgb005  
             END IF 
             IF g_join[li_i].dzgb005 = l_del_table OR g_join[li_i].dzgb009 = l_del_table 
                OR l_wc.getIndexOf(l_del_table,1) > 0 THEN
                ##判斷若下一句也是相同table的話，要加上table名-(s)
                #IF li_i + 1 < = g_join.getLength() THEN 
                   #IF g_join[li_i+1].dzgb005 = g_join[li_i].dzgb005 THEN                    
                      #LET l_table = g_join[li_i].dzgb005
                      #LET l_table_len = l_table.getLength()
                      #空白長度是table長+5
                      #LET l_tab_spce = l_table_len + 5 SPACE 
                      #LET l_wc_tmp = base.StringBuffer.create()
                      #CALL l_wc_tmp.append(g_join[li_i+1].wc)
                      #直接用table取代table長度的空白
                      #CALL l_wc_tmp.replace(l_tab_spce,l_table,1)
                      #LET l_next_wc = l_wc_tmp.toString()  
                      #若有別名，要移除掉
                      #CALL adzp188_ref_wc_delalias(l_next_wc,g_join[li_i+1].dzgb009) RETURNING g_join[li_i+1].wc,g_join[li_i+1].dzgb017
#
                      #140408 delete 由refence來的dzgc欄位-(s)
                      #DELETE FROM adzp188_dzgc_tmp
                       #WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                         #AND dzgc004 = g_join[li_i].dzgb016 AND dzgc007 = g_join[li_i].dzgb017
                      #140408 delete 由refence來的dzgc欄位-(e)
                      #
                      #UPDATE adzp188_dzgb_tmp SET dzgb011 = l_next_wc, dzgb017 = g_join[li_i+1].dzgb017
                       #WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                         #AND dzgb003 = g_join[li_i+1].dzgb003 
                   #END IF 
                #END IF 
                ##判斷若下一句也是相同table的話，要加上table名-(e)                  
                ##140422-(S)

                IF li_i = 1 OR li_i = l_do THEN 
                     
                      LET l_table = g_join[li_i].dzgb005
                      LET l_table_len = l_table.getLength()
                      ##空白長度是table長+5
                      LET l_tab_spce = l_table_len + 5 SPACE 
                      LET l_wc_tmp = base.StringBuffer.create()
                      CALL l_wc_tmp.append(g_join[li_i+1].wc)
                      ##直接用table取代table長度的空白
                      CALL l_wc_tmp.replace(l_tab_spce,l_table,1)
                      LET l_next_wc = l_wc_tmp.toString()  
                      ##若有別名，要移除掉
                      #CALL adzp188_ref_wc_delalias(l_next_wc,g_join[li_i+1].dzgb009) RETURNING g_join[li_i+1].wc,g_join[li_i+1].dzgb017

                      ##140408 delete 由refence來的dzgc欄位-(s)
                      DELETE FROM adzp188_dzgc_tmp
                       WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                         AND dzgc004 = g_join[li_i].dzgb016 AND dzgc007 = g_join[li_i].dzgb017
                         #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  #141017 mark
                         AND dzgc009 = g_code_ide #141017 add
                      ##140408 delete 由refence來的dzgc欄位-(e)
                      ##140506 -(s)  ##組合欄位也要刪除, 全刪
                      LET l_table_str = l_del_table
                      LET l_del_field = "l_",l_table_str.subString(1,l_table_str.getIndexOf("_",1)-1),"%"
                      DELETE FROM adzp188_dzgc_tmp
                       WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                         AND dzgc004 LIKE l_del_field
                         #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  #141017 mark
                         AND dzgc009 = g_code_ide #141017 add
                         ##AND dzgc004 LIKE "l_%"                     
                      ##140506 -(e)
                      UPDATE adzp188_dzgb_tmp SET dzgb011 = l_next_wc, dzgb017 = g_join[li_i+1].dzgb017
                       WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                         AND dzgb003 = g_join[li_i+1].dzgb003
                         #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add   #141017 mark
                         AND dzgb019 = g_code_ide #141017 add 
                 
                END IF 
                ##140422-(e)
                ##140603  -(s)               
                ##delete 由refence來的dzgc欄位-(s)
                DELETE FROM adzp188_dzgc_tmp
                 WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                   AND dzgc004 = g_join[li_i].dzgb016 AND dzgc007 = g_join[li_i].dzgb017
                   #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  #141017 mark
                   AND dzgc009 = g_code_ide #141017 add
                
                ##組合欄位也要刪除, 全刪
                LET l_table_str = l_del_table
                LET l_del_field = "l_",l_table_str.subString(1,l_table_str.getIndexOf("_",1)-1),"%"
                DELETE FROM adzp188_dzgc_tmp
                 WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                   AND dzgc004 LIKE l_del_field
                  ##AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  #141017 mark
                   AND dzgc009 = g_code_ide #141017 add
                 
                ##140603 -(e)

                #150525-00029#1 add -(s)
                ##自定義欄位也要刪
                LET l_table_str = l_del_table
                LET l_del_field = "%",l_table_str.subString(1,l_table_str.getIndexOf("_",1)-1),"%"

               #DECLARE dzgd006 SCROLL CURSOR FOR
                #SELECT dzgd006 FROM adzp188_dzgd_tmp
                 #WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                   #AND dzgd006 LIKE l_del_field
                   #AND dzgd009 = g_code_ide 
               #CALL l_dzgd006.clear()    
               #LET l_i = 1
               #FOREACH get_dzgd006_data_cs INTO l_dzgd006[l_i].*
                  #LET l_i = l_i + 1
               #END FOREACH  
               #CALL l_dzgd006.deleteElement(l_ii)                  
               #FOR l_i = 1 TO l_dzgd006.getLength()  

               LET g_sql = " DELETE FROM adzp188_dzgc_tmp gc               ",
                           "  WHERE EXISTS (                               ",
                           "         SELECT * FROM adzp188_dzgd_tmp gd     ",
                           "          WHERE dzgd001 = ?                    ",
                           "            AND dzgd002 = ?                    ",
                           "            AND dzgd006 LIKE '",l_del_field   ,"'",
                           "            AND dzgd008 =?                     ",
                           "            AND gd.dzgd003 = gc.dzgc004        )"
               PREPARE del_dzgc004_pre FROM g_sql
               EXECUTE del_dzgc004_pre USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_code_ide
               
                DELETE FROM adzp188_dzgd_tmp
                 WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                   AND dzgd006 LIKE l_del_field
                   AND dzgd009 = g_code_ide 

                   
                #150525-00029#1 add -(e)
                
               
                DELETE FROM adzp188_dzgb_tmp
                 WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                   AND dzgb003 = g_join[li_i].dzgb003  
                   #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add   #141017 mark
                   AND dzgb019 = g_code_ide #141017 add 
                IF STATUS THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = STATUS
                   LET g_errparam.extend = 'delete adzp188_dzgb_tmp:'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                END IF  
             END IF 

         END FOR 
         #重整seq   
         CALL adzp188_tablejoin_wclist_b_fill()
         CALL adzp188_refresh_seq("s_join")  
                
    
         ##連帶JOIN頁籤裡的也要刪除--(S)

       
         ##連帶欄位dzgc也要刪-(s)
         CALL adzp188_fieldsel_b_fill()   
         FOR li_i = 1 TO g_fieldsel.getLength()
             SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = g_fieldsel[li_i].dzgc004
                AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
                ##161227-00056#1 add -(s)
                AND gztz001 NOT LIKE 'erp%'   
                AND gztz001 NOT LIKE 'all%'
                AND gztz001 NOT LIKE 'b2b%'
                AND gztz001 NOT LIKE 'pos%'
                AND gztz001 NOT LIKE 'dsm%'
                ##161227-00056#1 add -(e)                
             IF l_gztz001 = g_tablesel[pi_idx].id THEN
                DELETE FROM adzp188_dzgc_tmp
                 WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                   AND dzgc004 = g_fieldsel[li_i].dzgc004 
                   #AND dzgc008 = g_cust AND dzgc009 = g_code_ide  #140613 add    #141017 mark
                   AND dzgc009 = g_code_ide  #141017 add              
             END IF 
         END FOR
         CALL adzp188_refresh_seq("s_fieldsel")  ##150617-00018 add 刪了dzgc要重排順序
         CALL adzp188_fieldsel_b_fill()         
         ##連帶欄位dzgc也要刪-(e)

         ##連帶群組dzge也要刪-(s)
         CALL adzp188_gr_groupsel_b_fill() 
         FOR li_i = 1 TO g_gr_groupsel1.getLength()
             SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = g_gr_groupsel1[li_i].dzge006
                AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
                ##161227-00056#1 add -(s)
                AND gztz001 NOT LIKE 'erp%'   
                AND gztz001 NOT LIKE 'all%'
                AND gztz001 NOT LIKE 'b2b%'
                AND gztz001 NOT LIKE 'pos%'
                AND gztz001 NOT LIKE 'dsm%'
                ##161227-00056#1 add -(e)                
             IF l_gztz001 = g_tablesel[pi_idx].id THEN
                ##只要刪一次把欄位刪掉即可
                DELETE FROM adzp188_dzge_tmp
                 WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                   AND dzge004 = g_gr_groupsel1[li_i].dzge004
                   # AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add  #141017 mark
                   AND dzge009 = g_code_ide  #141017add 
             END IF 
         END FOR 
         CALL adzp188_gr_groupsel_b_fill()         
         ##連帶群組dzge也要刪-(e)      

         ##連帶群組dzge也要刪-(s)
         CALL adzp188_filter_b_fill()  
         FOR li_i = 1 TO g_filter.getLength()
             SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = g_filter[li_i].dzgf006
                AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
                ##161227-00056#1 add -(s)
                AND gztz001 NOT LIKE 'erp%'   
                AND gztz001 NOT LIKE 'all%'
                AND gztz001 NOT LIKE 'b2b%'
                AND gztz001 NOT LIKE 'pos%'
                AND gztz001 NOT LIKE 'dsm%'
                ##161227-00056#1 add -(e)                
             IF l_gztz001 = g_tablesel[pi_idx].id THEN
                ##只要刪一次把欄位刪掉即可
                DELETE FROM adzp188_dzgf_tmp
                 WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                   AND dzgf006 = g_filter[li_i].dzgf006 
                   #AND dzgf011 = g_cust AND dzgf012 = g_code_ide #140613 add    #141017 mark
                   AND dzgf012 = g_code_ide #141017 add              
             END IF 
         END FOR 
         CALL adzp188_filter_b_fill()          
         ##連帶群組dzge也要刪-(e)        
         
         #CALL gdig_curr.deleteRow("s_tablesel", pi_idx)
         
         DELETE FROM adzp188_dzgi_tmp 
          WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
            AND dzgi004 = g_tablesel[pi_idx].id
            #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add  #141017 mark
            AND dzgi006 = g_code_ide #141017 add

         ##140401 主表格被刪，第2個表格就當主表格需增加保留字欄位 -(s)
         IF pi_idx = 1 THEN 
            IF NOT cl_null(g_tablesel[pi_idx+1].id) THEN 
               CALL adzp188_add_main_table_suffix(g_tablesel[pi_idx+1].id)
            END IF 
         END IF 
         ##140401 主表格被刪，第2個表格就當主表格需增加保留字欄位 -(s)
         ##若單身被刪, 要重新抓新單身的相關資訊dzgb、dzgc 140408 -(S)
         IF pi_idx = 2 THEN 
            CALL adzp188_get_d_reference_join(g_tablesel[pi_idx+1].id)
         END IF  
        
         ##若單身被刪, 要重新抓新單身的相關資訊dzgb、dzgc 140408 -(E)   
 
 
   END CASE
   CALL adzp188_tablesel_b_fill() 

END FUNCTION

################################################################################
# Descriptions...: 連結頁簽-準備基本的欄位列表供選擇
# Memo...........: 之後改為抓畫面有的欄位?
# Usage..........: CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin1", g_dzgb_d.dzgb005)
# Input parameter: ps_array   s_tablejoin1或s_tablejoin2
# ...............: pc_dzeb001 指定的資料表代碼
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_tablejoin_fieldlist_b_fill(ps_array, pc_dzeb001)
   DEFINE ps_array     STRING
   DEFINE pc_dzeb001   LIKE dzeb_t.dzeb001
   DEFINE li_cnt       LIKE type_t.num5

   LET g_sql = "SELECT dzeb002, dzebl003 FROM dzeb_t",
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzeb002 AND dzebl002 = '",g_lang,"'",
               " WHERE dzeb001 = '",pc_dzeb001,"'",
               " ORDER BY dzeb002"
   PREPARE tablejoin_fieldlist_b_fill_pre FROM g_sql
   DECLARE tablejoin_fieldlist_b_fill_curs CURSOR FOR tablejoin_fieldlist_b_fill_pre

   LET li_cnt = 1

   CASE ps_array
      WHEN "s_tablejoin1"
         CALL g_tablejoin1.clear()
         FOREACH tablejoin_fieldlist_b_fill_curs INTO g_tablejoin1[li_cnt].*
           IF SQLCA.sqlcode THEN
             EXIT FOREACH
           END IF
           ##判斷非blob、clob欄位才存入
           IF adzp188_chk_field_blobclob(g_tablejoin1[li_cnt].id) THEN 
              LET li_cnt = li_cnt + 1
           END IF 
         END FOREACH
         CALL g_tablejoin1.deleteElement(li_cnt)
      WHEN "s_tablejoin2"
         CALL g_tablejoin2.clear()
         FOREACH tablejoin_fieldlist_b_fill_curs INTO g_tablejoin2[li_cnt].*
           IF SQLCA.sqlcode THEN
             EXIT FOREACH
           END IF
           ##判斷非blob、clob欄位才存入
           IF adzp188_chk_field_blobclob(g_tablejoin2[li_cnt].id) THEN            
              LET li_cnt = li_cnt + 1
           END IF 
         END FOREACH
         CALL g_tablejoin2.deleteElement(li_cnt)
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 連結頁簽-已建立的連結資料 (包含g_join與g_dzgb_d)
# Memo...........: 
# Usage..........: CALL adzp188_tablejoin_wclist_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_tablejoin_wclist_b_fill()
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE ls_str       STRING
   DEFINE ls_tmp       STRING 
   DEFINE ls_space_str STRING
   DEFINE l_wc_str     STRING  
   DEFINE l_dzgb005_cnt LIKE type_t.num5
   DEFINE l_suffix_str STRING 


   CALL g_join.clear()

   LET g_sql = "SELECT dzgb003, dzgb004, dzgb005, dzgb006, dzgb007, dzgb008, dzgb009, dzgb010,dzgb011,'',",
               "       dzgb012, dzgb013, dzgb014, dzgb015, dzgb016, dzgb017 ",
               " FROM adzp188_dzgb_tmp",
               #" WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'",   #140923 elena mark
               " WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",             #140923 elena add
               #"   AND dzgb018 ='",g_cust,"'",              #140613 add  #141017mark
               "   AND dzgb019 ='",g_code_ide,"'",              #140613 add
               " ORDER BY dzgb003"
            
   PREPARE tablejoin_wclist_b_fill_pre FROM g_sql
   DECLARE tablejoin_wclist_b_fill_curs CURSOR FOR tablejoin_wclist_b_fill_pre

   LET li_cnt = 1

   FOREACH tablejoin_wclist_b_fill_curs INTO g_join[li_cnt].*
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF
      
      IF cl_null(g_join[li_cnt].dzgb006) THEN  #參考程式產生的欄位是空
         LET g_join[li_cnt].flag ="Y"
         LET g_join1[li_cnt].wc = 'blue'
      ELSE 
         LET g_join[li_cnt].wc = adzp188_combine_join_wc(g_join[li_cnt].dzgb004, g_join[li_cnt].dzgb005, g_join[li_cnt].dzgb006, g_join[li_cnt].dzgb007, g_join[li_cnt].dzgb008, g_join[li_cnt].dzgb009, g_join[li_cnt].dzgb010)
         ##140319-(s)
         ##add 判斷主檔與reference table是否有ent'site'ld(ent.site.legal), 若有要加上
         CALL adzp188_chk_table_suffix(g_join[li_cnt].dzgb009,g_join[li_cnt].dzgb005,g_join[li_cnt].wc) RETURNING  l_suffix_str
         IF NOT cl_null(l_suffix_str) THEN
            LET g_join[li_cnt].wc  = g_join[li_cnt].wc , " AND ",l_suffix_str 
         END IF 
         ##140319-(s)
         IF li_cnt>1 THEN  
             LET l_dzgb005_cnt = 0 
             SELECT COUNT(dzgb005) INTO l_dzgb005_cnt FROM adzp188_dzgb_tmp 
              WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
                AND dzgb005 = g_join[li_cnt].dzgb005
                #AND dzgb018 = g_cust AND dzgb019 = g_code_ide     #140613 add  #141017 mark
                AND dzgb019 = g_code_ide     #141017 add
                
             IF l_dzgb005_cnt > 0 THEN  
                 LET ls_tmp = g_join[li_cnt].dzgb005
                 LET ls_space_str = ls_tmp.getLength()+ 5 SPACE 
                 LET l_wc_str = g_join[li_cnt].wc
                 LET l_wc_str =ls_space_str, l_wc_str.subString(l_wc_str.getindexof(g_join[li_cnt].dzgb005,1)+ls_tmp.getLength() ,l_wc_str.getLength())
                 LET g_join[li_cnt].wc = l_wc_str 
             END IF 
             ##增加別名
             IF NOT cl_null(g_join[li_cnt].dzgb012) THEN   ##140325排除foreign key組成的不置換別名
                CALL adzp188_ref_wc_addalias(g_join[li_cnt].wc,g_join[li_cnt].dzgb009) RETURNING g_join[li_cnt].wc,g_join[li_cnt].dzgb017
             END IF 
         END IF 
         #LET g_join[li_cnt].wc = adzp188_ref_wc_addalias(g_join[li_cnt].wc,g_join[li_cnt].dzgb009)
      END IF  
      
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_join.deleteElement(li_cnt)

END FUNCTION

################################################################################
# Descriptions...: 連結頁簽-組合join條件回傳
# Memo...........: 
# Usage..........: CALL adzp188_combine_join_wc(ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010)
# Input parameter: ps_dzgb004    資料表1外部連結
# ...............: ps_dzgb005    資料表1
# ...............: ps_dzgb006    資料表1欄位
# ...............: ps_dzgb007    運算字元
# ...............: ps_dzgb008    資料表2外部連結
# ...............: ps_dzgb009    資料表2
# ...............: ps_dzgb010    資料表2欄位
# Return code....: str           組合條件
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_combine_join_wc(ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010)
   DEFINE ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010   STRING
   DEFINE ls_str   STRING

   #不確定組合規則, 先暫時用分鏡範例來組
   IF ps_dzgb004 = "Y" THEN
      LET ls_str = ps_dzgb005, " RIGHT OUTER JOIN ", ps_dzgb009, " ON "
   END IF   
   IF ps_dzgb008 = "Y" THEN
      LET ls_str = ps_dzgb005, " LEFT OUTER JOIN ", ps_dzgb009, " ON "
   END IF
   #LET ls_str = ls_str, ps_dzgb005, ".", ps_dzgb006
   LET ls_str = ls_str, ps_dzgb009, ".", ps_dzgb010
   CASE ps_dzgb007
      WHEN "01" LET ls_str = ls_str, " = ",  ps_dzgb005, ".", ps_dzgb006 #ps_dzgb009, ".", ps_dzgb010
      WHEN "02" LET ls_str = ls_str, " <> ", ps_dzgb009, ".", ps_dzgb010
      WHEN "03" LET ls_str = ls_str, " > ", ps_dzgb009, ".", ps_dzgb010
      WHEN "04" LET ls_str = ls_str, " < ", ps_dzgb009, ".", ps_dzgb010
      WHEN "05" LET ls_str = ls_str, " >= ", ps_dzgb009, ".", ps_dzgb010
      WHEN "06" LET ls_str = ls_str, " <= ", ps_dzgb009, ".", ps_dzgb010
      WHEN "07" LET ls_str = ls_str, " BETWEEN ?"
      WHEN "08" LET ls_str = ls_str, " NOT BETWEEN ?"
      WHEN "09" LET ls_str = ls_str, " LIKE ?"
      WHEN "10" LET ls_str = ls_str, " NOT LIKE ?"
      WHEN "11" LET ls_str = ls_str, " IN ?"
      WHEN "12" LET ls_str = ls_str, " NOT IN ?"
      WHEN "13" LET ls_str = ls_str, " IS NULL "
      WHEN "14" LET ls_str = ls_str, " IS NOT NULL "
   END CASE

   
   RETURN ls_str

END FUNCTION


################################################################################
# Descriptions...: 連結頁簽-組合預設fk的值條件回傳
# Memo...........: 
# Usage..........: CALL adzp188_combine_ref_join_wc(ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010)
# Input parameter: ps_dzgb004    資料表1外部連結
# ...............: ps_dzgb005    資料表1
# ...............: ps_dzgb006    資料表1欄位
# ...............: ps_dzgb007    運算字元
# ...............: ps_dzgb008    資料表2外部連結
# ...............: ps_dzgb009    資料表2
# ...............: ps_dzgb010    資料表2欄位
# Return code....: str           組合條件
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_combine_ref_join_wc(ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010)
   DEFINE ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010   STRING
   DEFINE ls_str      STRING
   DEFINE l_token1    base.StringTokenizer 
   DEFINE l_token2    base.StringTokenizer
   DEFINE ls_next1    STRING
   DEFINE ls_next2    STRING
   DEFINE l_token1_cnt LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_have       LIKE type_t.num5
   DEFINE ls_dzgb010   LIKE dzgb_t.dzgb010
   DEFINE l_suffix_str STRING 


   #不確定組合規則, 先暫時用分鏡範例來組
   IF ps_dzgb004 = "Y" THEN
      LET ls_str = ps_dzgb009, " RIGHT OUTER JOIN ", ps_dzgb005, " ON "
   END IF   
   IF ps_dzgb008 = "Y" THEN
      LET ls_str = ps_dzgb005 , " LEFT OUTER JOIN ", ps_dzgb009, " ON "
   END IF
   
   LET l_token1 = base.StringTokenizer.create(ps_dzgb006,",")
   LET l_token2 = base.StringTokenizer.create(ps_dzgb010,",")
   LET l_token1_cnt = l_token1.countTokens()
   LET l_cnt = 1
   WHILE l_token1.hasMoreTokens()
         LET ls_next1 = l_token1.nextToken()
         LET ls_next2 = l_token2.nextToken() 
         #判斷欄位存在，組成inbb_t.inbb001，若是傳進來的值是2，就不用組成inbb_t.2
         LET ls_dzgb010 = ls_next1
         LET l_have = 0
         SELECT COUNT(*) INTO l_have FROM gztz_t WHERE gztz002 = ls_dzgb010 
            AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
            ##161227-00056#1 add -(s)
            AND gztz001 NOT LIKE 'erp%'   
            AND gztz001 NOT LIKE 'all%'
            AND gztz001 NOT LIKE 'b2b%'
            AND gztz001 NOT LIKE 'pos%'
            AND gztz001 NOT LIKE 'dsm%'
            ##161227-00056#1 add -(e)            
         IF l_cnt < l_token1_cnt THEN 
            IF l_have > 0 THEN 
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", "' '"  ," AND "
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", ps_dzgb005, ".", ls_next1  ," AND "
               END IF 
            ELSE
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ",  "' '"  ," AND "
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ",  ls_next1  ," AND "
               END IF 
            END IF 
         ELSE 
            IF l_have > 0 THEN
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", "' '" 
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", ps_dzgb005, ".", ls_next1
               END IF 
            ELSE
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ",  "' '"  ," AND "
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", ls_next1
               END IF 
            END IF 
         END IF 
         LET l_cnt = l_cnt + 1
   END WHILE 

   ##140318 add 判斷主檔與reference table是否有ent'site'ld(ent.site.legal), 若有要加上
   CALL adzp188_chk_table_suffix(ps_dzgb009,ps_dzgb005,ls_str) RETURNING  l_suffix_str
   IF NOT cl_null(l_suffix_str) THEN
      LET ls_str = ls_str , " AND ",l_suffix_str 
   END IF 
   
   RETURN ls_str

END FUNCTION


################################################################################
# Descriptions...: 判斷REFERENCE的資料是否有誤，若有誤寫到string.buf顯示於畫面
# Memo...........: 
# Usage..........: CALL adzp188_separate_join_wc(g_join_idx)
# Input parameter: pi_idx   選擇資料
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_chk_sql_join_errmsg(pi_idx)
   DEFINE pi_idx   LIKE type_t.num5
   DEFINE li_i     LIKE type_t.num5

 

END FUNCTION


################################################################################
# Descriptions...: 連結頁簽-將選擇的join條件轉顯示在單檔, 以供直接維護
# Memo...........: 
# Usage..........: CALL adzp188_separate_join_wc(g_join_idx)
# Input parameter: pi_idx   選擇資料
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_separate_join_wc(pi_idx)
   DEFINE pi_idx   LIKE type_t.num5
   DEFINE li_i     LIKE type_t.num5

   IF pi_idx > 0 THEN
      #131230新版 -(s)
      IF NOT cl_null(g_join[pi_idx].dzgb006) THEN   #配置出來
         LET g_dzgb_d.dzgb004 = g_join[pi_idx].dzgb004
         LET g_dzgb_d.dzgb005 = g_join[pi_idx].dzgb005
         LET g_dzgb_d.dzgb007 = g_join[pi_idx].dzgb007
         LET g_dzgb_d.dzgb008 = g_join[pi_idx].dzgb008
         LET g_dzgb_d.dzgb009 = g_join[pi_idx].dzgb009
         CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin1", g_dzgb_d.dzgb005)
         CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin2", g_dzgb_d.dzgb009)
         FOR li_i = 1 TO g_tablejoin1.getLength()
             IF g_tablejoin1[li_i].id = g_join[pi_idx].dzgb006 THEN
                EXIT FOR
             END IF
         END FOR
         CALL gdig_curr.setCurrentRow("s_tablejoin1", li_i)
         FOR li_i = 1 TO g_tablejoin2.getLength()
             IF g_tablejoin2[li_i].id = g_join[pi_idx].dzgb010 THEN
                EXIT FOR
             END IF
         END FOR
         CALL gdig_curr.setCurrentRow("s_tablejoin2", li_i)
      ELSE   #參考預設
          LET g_dzgb_d.dzgb004 = "N"
          LET g_dzgb_d.dzgb005 = g_tablesel[1].id
          LET g_dzgb_d.dzgb007 = "01"
          LET g_dzgb_d.dzgb008 = "N"
          LET g_dzgb_d.dzgb009 = g_tablesel[1].id
          CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin1", g_dzgb_d.dzgb005)
          CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin2", g_dzgb_d.dzgb009)
          CALL gdig_curr.setCurrentRow("s_tablejoin1", 1)
          CALL gdig_curr.setCurrentRow("s_tablejoin2", 1)         
      END IF 
      #131230新版 -(e)

   ELSE
      LET g_dzgb_d.dzgb004 = "N"
      LET g_dzgb_d.dzgb005 = g_tablesel[1].id
      LET g_dzgb_d.dzgb007 = "01"
      LET g_dzgb_d.dzgb008 = "N"
      LET g_dzgb_d.dzgb009 = g_tablesel[1].id
      CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin1", g_dzgb_d.dzgb005)
      CALL adzp188_tablejoin_fieldlist_b_fill("s_tablejoin2", g_dzgb_d.dzgb009)
      CALL gdig_curr.setCurrentRow("s_tablejoin1", 1)
      CALL gdig_curr.setCurrentRow("s_tablejoin2", 1)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 連結頁簽-維護dzgb_t及更新wc組合字串
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzgb(1, "add)
# Input parameter: pi_idx     指定序號
# ...............: ps_type    add新增, upd修改或del刪除
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzgb(pi_idx, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_type      STRING
   DEFINE l_idx_wc     STRING 
   DEFINE l_table      STRING 
   DEFINE l_table_len  LIKE type_t.num5
   DEFINE l_wc_tmp     base.StringBuffer
   DEFINE l_next_wc    LIKE dzgb_t.dzgb011
   DEFINE l_tab_spce   STRING   
   DEFINE l_cnt        SMALLINT            #140923 elena add

   CASE ps_type
      WHEN "add"
         #檢查單頭是否存入, 若還未存入必須先INSERT單頭
         #dzga_t count IS NULL, INSERT INTO dzga_t

         #從s_tablejoin1, s_tablejoin2抓取dzgb006, dzgb010的值
         LET g_dzgb_d.dzgb006 = g_tablejoin1[gdig_curr.getCurrentRow("s_tablejoin1")].id
         LET g_dzgb_d.dzgb010 = g_tablejoin2[gdig_curr.getCurrentRow("s_tablejoin2")].id

         #是否必須檢查dzgb004~dzgb010都必須有值
         
         SELECT MAX(dzgb003) + 1 INTO g_dzgb_d.dzgb003 FROM adzp188_dzgb_tmp
          WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
         IF cl_null(g_dzgb_d.dzgb003) OR g_dzgb_d.dzgb003 = 0 THEN
            LET g_dzgb_d.dzgb003 = 1
         END IF
         INSERT INTO adzp188_dzgb_tmp
         VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzgb_d.dzgb003, g_dzgb_d.dzgb004, g_dzgb_d.dzgb005, g_dzgb_d.dzgb006, g_dzgb_d.dzgb007, g_dzgb_d.dzgb008, g_dzgb_d.dzgb009, g_dzgb_d.dzgb010,g_dzgb_d.dzgb011,'','','','','','') #將配置的wc存入，因為怕有別名
         #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzgb_d.dzgb003, g_dzgb_d.dzgb004, g_dzgb_d.dzgb005, g_dzgb_d.dzgb006, g_dzgb_d.dzgb007, g_dzgb_d.dzgb008, g_dzgb_d.dzgb009, g_dzgb_d.dzgb010,'') #原版
      WHEN "upd"
         IF pi_idx > 0 THEN
            #從s_tablejoin1, s_tablejoin2抓取dzgb006, dzgb010的值
            LET g_dzgb_d.dzgb006 = g_tablejoin1[gdig_curr.getCurrentRow("s_tablejoin1")].id
            LET g_dzgb_d.dzgb010 = g_tablejoin2[gdig_curr.getCurrentRow("s_tablejoin2")].id
            UPDATE adzp188_dzgb_tmp SET dzgb004 = g_dzgb_d.dzgb004, dzgb005 = g_dzgb_d.dzgb005,
                                        dzgb006 = g_dzgb_d.dzgb006, dzgb007 = g_dzgb_d.dzgb007,
                                        dzgb008 = g_dzgb_d.dzgb008, dzgb009 = g_dzgb_d.dzgb009,
                                        dzgb010 = g_dzgb_d.dzgb010, dzgb011 = g_dzgb_d.dzgb011
             WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
               AND dzgb003 = g_join[pi_idx].dzgb003
         END IF
      WHEN "del"
         IF pi_idx > 0 THEN

            ##140218  若刪的是left join第一句，則下一句要補上主table名-(S)
            LET l_idx_wc = g_join[pi_idx].wc
            ##刪除的這句是join且是第一句有主報表
            IF l_idx_wc.getIndexOf(g_join[pi_idx].dzgb005,1)>0 AND l_idx_wc.getIndexOf('JOIN',1)>0 THEN
                ##下一筆
                IF pi_idx + 1 < = g_join.getLength() THEN 
                   IF g_join[pi_idx+1].dzgb005 = g_join[pi_idx].dzgb005 THEN                    
                      LET l_table = g_join[pi_idx].dzgb005
                      LET l_table_len = l_table.getLength()
                      ##空白長度是table長+5
                      LET l_tab_spce = l_table_len+5 SPACE 
                      LET l_wc_tmp = base.StringBuffer.create()
                      CALL l_wc_tmp.append(g_join[pi_idx+1].wc)
                      ##直接用table取代table長度的空白
                      CALL l_wc_tmp.replace(l_tab_spce,l_table,1)
                      LET l_next_wc = l_wc_tmp.toString()                      
                      UPDATE adzp188_dzgb_tmp SET dzgb011 = l_next_wc
                       WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                         AND dzgb003 = g_join[pi_idx+1].dzgb003 
                   END IF 
                END IF    
            END IF   
            ##140218 add-(S)
             
            DELETE FROM adzp188_dzgb_tmp
             WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
               AND dzgb003 = g_join[pi_idx].dzgb003
         END IF
   END CASE

   CALL adzp188_tablejoin_wclist_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 上下移動排序
# Memo...........: 
# Usage..........: CALL adzp188_move_up_down("s_join", "up")
# Input parameter: ps_array   移動的array名稱
# ...............: ps_type    往上移動/往下移動
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_move_up_down(ps_array, ps_type)
   DEFINE ps_array   STRING
   DEFINE ps_type    STRING
   DEFINE li_step    LIKE type_t.num5
   DEFINE li_idx     LIKE type_t.num5   #目前指定的位置
   DEFINE li_idx_p   LIKE type_t.num5   #目的位置
   DEFINE li_idx_t   LIKE type_t.num5   #暫時的位置(因為序號是key)
   DEFINE li_cur_idx LIKE type_t.num5   #for typelist2
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_key3    STRING
   DEFINE ls_key4    STRING             #140701 add
   DEFINE ls_key5    STRING             #150327 add
   DEFINE ls_seq     STRING

   IF ps_type = "up" THEN
      LET li_step = -1
   ELSE
      LET li_step = 1
   END IF

   LET li_idx = gdig_curr.getCurrentRow(ps_array)
   LET li_idx_p = li_idx + li_step
   #array對應的Table及順序欄位指定
   CASE ps_array
      WHEN "s_tablesel"
         LET ls_table = "adzp188_dzgi_tmp"
         LET ls_key1 = "dzgi001"
         LET ls_key2 = "dzgi002"
         LET ls_key3 = "dzgi006"   #140701 add
         LET ls_seq = "dzgi003"   
         
      WHEN "s_join"
         LET ls_table = "adzp188_dzgb_tmp"
         LET ls_key1 = "dzgb001"
         LET ls_key2 = "dzgb002"
         LET ls_key3 = "dzgb019"   #140701 add
         LET ls_seq = "dzgb003"
         
      WHEN "s_fieldsel"
         LET ls_table = "adzp188_dzgc_tmp"
         LET ls_key1 = "dzgc001"
         LET ls_key2 = "dzgc002"
         LET ls_key3 = "dzgc009"   #140701 add
         LET ls_seq = "dzgc003"
         
      WHEN "s_filter"
         LET ls_table = "adzp188_dzgf_tmp"
         LET ls_key1 = "dzgf001"
         LET ls_key2 = "dzgf002"
         LET ls_key3 = "dzgf012"  #140701 add
         LET ls_seq = "dzgf003"
         
      WHEN "s_xg_groupsel"   
         LET ls_table = "adzp188_gexg_tmp  "    #151012-00003#1 調整tmp名稱縮為17字元
         LET ls_key1 = "dzge001"
         LET ls_key2 = "dzge002"
         LET ls_key3 = "dzge009"  #140701 add
         LET ls_seq = "dzge004"
         
      WHEN "s_gr_groupsel1"   
         LET ls_table = "adzp188_dzge_tmp"
         LET ls_key1 = "dzge001"
         LET ls_key2 = "dzge002"
         LET ls_key3 = "dzge003"
         LET ls_key4 = "dzge009"  #140701 add
         LET ls_seq = "dzge004" 
         
      WHEN "s_gr_groupsel2"   
         LET ls_table = "adzp188_dzge_tmp"
         LET ls_key1 = "dzge001"
         LET ls_key2 = "dzge002"
         LET ls_key3 = "dzge003"
         LET ls_key4 = "dzge009"  #140701 add
         LET ls_seq = "dzge004"  
 
      WHEN "s_typelist2"   
         LET ls_table = "adzp188_type2_tmp"
         LET ls_key1 = "dzgh001"
         LET ls_key2 = "dzgh002"
         LET ls_key3 = "dzgh003"
         LET ls_key4 = "dzgh012"   #140701 add
         LET ls_seq = "idseq2"  
         LET li_cur_idx = li_idx + li_step  ##140314 畫面idx
         LET li_idx = g_typelist2[gdig_curr.getCurrentRow(ps_array)].typeseq2  #真正index
         LET li_idx_p = li_idx + li_step      

      ##140403 -(S)
      WHEN "s_argsel"
         LET ls_table = "adzp188_dzgj_tmp"
         LET ls_key1 = "dzgj001"
         LET ls_key2 = "dzgj002"
         LET ls_key3 = "dzgj008"  #140701 add
         LET ls_seq = "dzgj003"      
      ##140403 -(E)  

      ##150327 add -(s)
      WHEN "s_tablecol"
         LET ls_table = "adzp188_xgtype_tmp"
         LET ls_key1 = "dzgh001"
         LET ls_key2 = "dzgh002"
         LET ls_key3 = "type"  
         LET ls_key4 = "ide" 
         LET ls_seq = "fieldseq"       

      WHEN "s_tablerow"
         LET ls_table = "adzp188_xgtype_tmp"
         LET ls_key1 = "dzgh001"
         LET ls_key2 = "dzgh002"
         LET ls_key3 = "type"  
         LET ls_key4 = "ide" 
         LET ls_seq = "fieldseq"  
         
      WHEN "s_tablesum"
         LET ls_table = "adzp188_xgtype_tmp"
         LET ls_key1 = "dzgh001"
         LET ls_key2 = "dzgh002"
         LET ls_key3 = "type"  
         LET ls_key4 = "ide" 
         LET ls_seq = "fieldseq"          
      ##150327 add -(e)
   END CASE
   ##140313 add -(S)
   CASE ps_array
        ##150327 add -(s)
        WHEN "s_tablecol" 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,                      
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",                       
                       "   AND ",ls_key3," = 'c'" ," AND ",ls_key4," = '",g_code_ide,"'"    
       WHEN "s_tablerow" 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,                      
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",                       
                       "   AND ",ls_key3," = 'r'" ," AND ",ls_key4," = '",g_code_ide,"'"                           
       WHEN "s_tablesum" 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,                      
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",                       
                       "   AND ",ls_key3," = 's'" ," AND ",ls_key4," = '",g_code_ide,"'"    
       ##150327 add -(e)
        WHEN "s_gr_groupsel1" 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",  #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",             #141013 add 
                       # "   AND ",ls_key3," = '1'"                                          #140701 mark
                       "   AND ",ls_key3," = '1'" ," AND ",ls_key4," = '",g_code_ide,"'"     #140701 add
        WHEN "s_gr_groupsel2" 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",  #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",   #141013 add
                       #"   AND ",ls_key3," = '2'"                                           #140701 mark
                       "   AND ",ls_key3," = '2'" ," AND ",ls_key4," = '",g_code_ide,"'"     #140701 add
        WHEN "s_typelist2" 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",   #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",              #141013 add
                       #"   AND ",ls_key3," = '", g_dzga_m.dzga001,"'",                      #140701 mark
                       "   AND ",ls_key3," = '", g_dzga_m.dzga001,"'"," AND ",ls_key4," = '",g_code_ide,"'",  #140701 add
                       "   AND pidtype2 = '",g_typelist2[gdig_curr.getCurrentRow(ps_array)].typepidtype2 ,"'",  ##140314
                       "   AND pidseq2 = '",g_typelist2[gdig_curr.getCurrentRow(ps_array)].typepidseq2,"'"  ##140314    
        OTHERWISE 
            LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",   #141013  mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",    #141013 add
                       "   AND ",ls_key3," = '",g_code_ide,"'"   #140701 add
   END CASE 
   ##140313 add -(e)
   ##140313 mark -(S)
   #IF ps_array ="s_gr_groupsel1" OR ps_array ="s_gr_groupsel2"  OR ps_array ="s_typelist2" THEN 
       #LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
                   #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",
                   #"   AND ",ls_key3," = '",ls_key3 ,"'"
   #ELSE    
       #LET g_sql = "SELECT MAX(",ls_seq,") + 1 FROM ",ls_table,
                   #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'"
   #END IF 
   ##140313 mark -(S)
   PREPARE change_dzgb_seq_tmploction_pre FROM g_sql
   EXECUTE change_dzgb_seq_tmploction_pre INTO li_idx_t
   IF li_idx_t IS NULL THEN
      LET li_idx_t = 1
   END IF
   ##140313 add -(S)
   CASE ps_array
       WHEN "s_gr_groupsel1"
           LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",  #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",   #141013 add
                       "   AND ",ls_key3," = '1'" ," AND ",ls_seq," = ?" ," AND ",ls_key4," = '",g_code_ide,"'"     #140701 add   
       WHEN "s_gr_groupsel2"
           LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",   #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",              #141013 add 
                       "   AND ",ls_key3," = '2'" ," AND ",ls_seq," = ?" ," AND ",ls_key4," = '",g_code_ide,"'"     #140701 add   
       WHEN "s_typelist2"
           LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",   #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",              #141013 add
                       #"   AND ",ls_key3," = '", g_dzga_m.dzga001,"'"                                               #140701 mark
                       "   AND ",ls_key3," = '", g_dzga_m.dzga001,"'"  ," AND ",ls_key4," = '",g_code_ide,"'" ,    #140701 add
                       "   AND pidtype2 = '",g_typelist2[gdig_curr.getCurrentRow(ps_array)].typepidtype2 ,"'",  ##140314
                       "   AND pidseq2 = '",g_typelist2[gdig_curr.getCurrentRow(ps_array)].typepidseq2,"'",  ##140314                           
                       "   AND ",ls_seq," = ?"  
       ##150330 add -(s)
       WHEN "s_tablerow"
          LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",                    
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_seq," = ?",  #141013 add
                       "   AND ",ls_key3," = 'r'", " AND ",ls_key4," = '",g_code_ide,"'"   
                       
       WHEN "s_tablecol"
          LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",                    
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_seq," = ?",  #141013 add
                       "   AND ",ls_key3," = 'c'", " AND ",ls_key4," = '",g_code_ide,"'"            

       WHEN "s_tablesum"
          LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",                    
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_seq," = ?",  #141013 add
                       "   AND ",ls_key3," = 's'", " AND ",ls_key4," = '",g_code_ide,"'"            
                                              
      ##150330 add -(e)                    

       OTHERWISE 
          LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                      # " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"' AND ",ls_seq," = ?",  #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_seq," = ?",  #141013 add
                       "   AND ",ls_key3," = '",g_code_ide,"'"   #140701 add            
   END CASE 
   ##140313 add -(E)
   
   #兩組資料交換位置 (前提: 排序位置=序號)
   ##140313 mark -(s)
   #IF ps_array ="s_gr_groupsel1" OR ps_array ="s_gr_groupsel2" OR ps_array ="s_typelist2" THEN
      #LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                   #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",
                   #"   AND ",ls_key3," = '",ls_key3 ,"'" ," AND ",ls_seq," = ?"   
   #ELSE 
       #LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                   #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"' AND ",ls_seq," = ?"
   #END IF      
   ##140313 mark -(e)   
   PREPARE change_dzgb_seq_pre FROM g_sql
   #先把目的位置的資料搬去最後一筆
   EXECUTE change_dzgb_seq_pre USING li_idx_t, li_idx_p
   #把指定位置的資料搬到目的位置
   EXECUTE change_dzgb_seq_pre USING li_idx_p, li_idx
   #再把暫時丟到最後一筆的資料放回指定位置
   EXECUTE change_dzgb_seq_pre USING li_idx, li_idx_t

   #重整
   CASE ps_array
      WHEN "s_tablesel"
         CALL adzp188_tablesel_b_fill()   
      WHEN "s_join"
         CALL adzp188_tablejoin_wclist_b_fill()
      WHEN "s_fieldsel"
         CALL adzp188_fieldsel_b_fill()
      WHEN "s_filter"
         CALL adzp188_filter_b_fill()
      WHEN "s_xg_groupsel"
         CALL adzp188_xg_groupsel_b_fill()  
      WHEN "s_gr_groupsel1" 
         CALL adzp188_gr_groupsel_b_fill()
      WHEN "s_gr_groupsel2" 
         CALL adzp188_gr_groupsel_b_fill()
      WHEN "s_typelist2"
         CALL adzp188_typelist2_b_fill() 
      WHEN "s_argsel"
         CALL adzp188_argsel_b_fill()  
      ##150330 add -(s)
      WHEN "s_tablerow"
         CALL adzp188_xgtype_b_fill()
      WHEN "s_tablecol"
         CALL adzp188_xgtype_b_fill()   
      WHEN "s_tablesum"
         CALL adzp188_xgtype_b_fill()             
      ##150330 add -(e)         
   END CASE
   #最後, 指標要跟著指定資料跑
   IF ps_array ="s_typelist2" THEN 
      CALL gdig_curr.setCurrentRow(ps_array, li_cur_idx)
   ELSE 
      CALL gdig_curr.setCurrentRow(ps_array, li_idx_p)
   END IF 
   #上下按鍵要跟著開關
   CASE ps_array
      WHEN "s_tablesel"
         CALL adzp188_set_seqaction_active("s_tablesel", "up_tableseq", "down_tableseq")  
      WHEN "s_join"
         CALL adzp188_set_seqaction_active("s_join", "up_joinseq", "down_joinseq")
      WHEN "s_fieldsel"
         CALL adzp188_set_seqaction_active("s_fieldsel", "up_fieldseq", "down_fieldseq")
      WHEN "s_filter"
         CALL adzp188_set_seqaction_active("s_filter", "up_filterseq", "down_filterseq")
      WHEN "s_xg_groupsel"
         CALL adzp188_set_seqaction_active("s_xg_groupsel", "up_groupseq", "down_groupseq")   
      WHEN "s_gr_groupsel1"
         CALL adzp188_set_seqaction_active("s_gr_groupsel1", "up_groupseq1", "down_groupseq1") 
      WHEN "s_gr_groupsel2"
         CALL adzp188_set_seqaction_active("s_gr_groupsel2", "up_groupseq2", "down_groupseq2") 
      WHEN "s_typelist2"
         CALL adzp188_set_seqaction_active("s_typelist2", "up_typeseq", "down_typeseq") 
      WHEN "s_argsel"
         CALL adzp188_set_seqaction_active("s_argsel", "up_arg", "down_arg")    
      ##150330 add -(s)
      WHEN "s_tablecol"
         CALL adzp188_set_seqaction_active("s_tablecol", "up_col", "down_col")
      WHEN "s_tablerow"
         CALL adzp188_set_seqaction_active("s_tablerow", "up_row", "down_row")     
      WHEN "s_tablesum"
         CALL adzp188_set_seqaction_active("s_tablesum", "up_sum", "down_sum")            
      ##150330 add -(e)         
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 整批維護刪除後的序號
# Memo...........: 
# Usage..........: CALL adzp188_refresh_seq(ps_array)
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_refresh_seq(ps_array)
   DEFINE ps_array   STRING
   DEFINE li_i       LIKE type_t.num5
   DEFINE li_idx_t   LIKE type_t.num10   #暫時的位置(因為序號是key會重覆,好挫折)
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_key3    STRING
   DEFINE ls_key4    STRING #140613 add for二次開發 
   DEFINE ls_key5    STRING #140613 add for二次開發   
   DEFINE ls_seq     STRING

   #array對應的Table及順序欄位指定
   CASE ps_array
      WHEN "s_tablesel"
         LET ls_table = "adzp188_dzgi_tmp"
         LET ls_key1 = "dzgi001"
         LET ls_key2 = "dzgi002"
         LET ls_key3 = "dzgi005"  #140613 add
         LET ls_key4 = "dzgi006"  #140613 add
         LET ls_seq = "dzgi003"   
      WHEN "s_join"
         LET ls_table = "adzp188_dzgb_tmp"
         LET ls_key1 = "dzgb001"
         LET ls_key2 = "dzgb002"
         LET ls_key3 = "dzgb018"  #140613 add
         LET ls_key4 = "dzgb019"  #140613 add
         LET ls_seq = "dzgb003"
      WHEN "s_fieldsel"
         LET ls_table = "adzp188_dzgc_tmp"
         LET ls_key1 = "dzgc001"
         LET ls_key2 = "dzgc002"
         LET ls_key3 = "dzgc008"  #140613 add
         LET ls_key4 = "dzgc009"  #140613 add
         LET ls_seq = "dzgc003"
      WHEN "s_filter"
         LET ls_table = "adzp188_dzgf_tmp"
         LET ls_key1 = "dzgf001"
         LET ls_key2 = "dzgf002"
         LET ls_key3 = "dzgf011"  #140613 add
         LET ls_key4 = "dzgf012"  #140613 add
         LET ls_seq = "dzgf003"
      #WHEN "s_typelist2"  #140313
         #LET ls_table = "adzp188_type2_tmp"
         #LET ls_key1 = "dzgh001"
         #LET ls_key2 = "dzgh002"
         #LET ls_key3 = "dzgh003"
         #LET ls_seq = "idseq2"     
      WHEN "s_gr_groupsel1"
         LET ls_table = "adzp188_dzge_tmp"
         LET ls_key1 = "dzge001"
         LET ls_key2 = "dzge002"
         LET ls_key4 = "dzge008"  #140613 add
         LET ls_key5 = "dzge009"  #140613 add
         LET ls_seq = "dzge003"   
      WHEN "s_gr_groupsel2"
         LET ls_table = "adzp188_dzge_tmp"
         LET ls_key1 = "dzge001"
         LET ls_key2 = "dzge002"
         LET ls_key4 = "dzge008"  #140613 add
         LET ls_key5 = "dzge009"  #140613 add
         LET ls_seq = "dzge003"           
         
   END CASE

   ##140313 add -(S)
   CASE ps_array
       WHEN "s_gr_groupsel1"
           LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",  #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",   #141013 add
                       "   AND ",ls_key3," = '1'" ," AND ",ls_seq," = ?", 
                       #"   AND ",ls_key4," = '",g_cust,"' AND ",ls_key5," = '",g_code_ide,"'"      #140613 add  #141017 mark
                       "   AND ",ls_key5," = '",g_code_ide,"'"      #141017add
       WHEN "s_gr_groupsel2"
           LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",   #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"'",    #141013 add
                       "   AND ",ls_key3," = '2'" ," AND ",ls_seq," = ?" , 
                       #"   AND ",ls_key4," = '",g_cust,"' AND ",ls_key5," = '",g_code_ide,"'"      #140613 add  #141017 mark
                       "   AND ",ls_key5," = '",g_code_ide,"'"      #141017 add
       #WHEN "s_typelist2"
           #LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"'",
                       #"   AND ",ls_key3," = '", g_dzga_m.dzga001,"'"  ,
                       #"   AND pidtype2 = '",g_typelist2[gdig_curr.getCurrentRow(ps_array)].typepidtype2 ,"'",  ##140314
                       #"   AND pidseq2 = '",g_typelist2[gdig_curr.getCurrentRow(ps_array)].typepidseq2,"'",  ##140314                           
                       #"   AND ",ls_seq," = ?"    
                       
       OTHERWISE 
          LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                       #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"' AND ",ls_seq," = ?" ,  #141013 mark
                       " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_seq," = ?" ,   #141013 add
                       #"    AND ",ls_key3," = '",g_cust,"' AND ",ls_key4," = '",g_code_ide,"'"       #140613 add  #141017 mark
                       "    AND ",ls_key4," = '",g_code_ide,"'"       #141017 add                        
   END CASE 
   ##140313 add -(E)
   ##140314 -mark -(S)
   #IF ps_array = "s_typelist2" THEN 
       #LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                   #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,
                   #"' AND ",ls_key3," = '",g_dzga_m.dzga001,"' AND ",ls_seq," = ?"
   #ELSE 
       #LET g_sql = "UPDATE ",ls_table," SET ", ls_seq," = ?",
                   #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"' AND ",ls_seq," = ?"
   #END IF 
    ##140314 -mark -(e)
   PREPARE batch_refresh_seq_pre FROM g_sql

   #將序號調整為目前Table所視順序
   FOR li_i = 1 TO gdig_curr.getArrayLength(ps_array)
       #先搬去好遙遠的位置上排序, 這樣就不會重覆
       LET li_idx_t = li_i * 10000
       CASE ps_array
          WHEN "s_tablesel"
             EXECUTE batch_refresh_seq_pre USING li_idx_t, g_tablesel[li_i].seq
             LET g_tablesel[li_i].seq = li_idx_t       
          WHEN "s_join"
             EXECUTE batch_refresh_seq_pre USING li_idx_t, g_join[li_i].dzgb003
             LET g_join[li_i].dzgb003 = li_idx_t
          WHEN "s_fieldsel"
             EXECUTE batch_refresh_seq_pre USING li_idx_t, g_fieldsel[li_i].dzgc003
             LET g_fieldsel[li_i].dzgc003 = li_idx_t
          WHEN "s_filter"
             EXECUTE batch_refresh_seq_pre USING li_idx_t, g_filter[li_i].dzgf003
             LET g_filter[li_i].dzgf003 = li_idx_t   
             ##140317 add-(S) 140318mark 因為考慮到應用的場景會換enterprise，若寫在報表元件裡會無法置換，所以先由r、q、t那邊傳入
             #IF g_filter[li_i].dzgf003 <> 99 THEN  
                 #EXECUTE batch_refresh_seq_pre USING li_idx_t, g_filter[li_i].dzgf003
                 #LET g_filter[li_i].dzgf003 = li_idx_t
             #END IF                               
             ##140317 add -(E)   
          #WHEN "s_typelist2"
             #IF g_typelist2[li_i].typeseq2 <> 0 THEN 
                 #LET li_idx_t = g_typelist2[li_i].typeseq2  * 10000
                #EXECUTE batch_refresh_seq_pre USING li_idx_t, g_typelist2[li_i].typeseq2
                #LET g_typelist2[li_i].typeseq2 = li_idx_t
             #END IF              
       END CASE
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = STATUS
          LET g_errparam.extend = ps_array
          LET g_errparam.popup = TRUE
          CALL cl_err()
       END IF 
   END FOR

   #再跑一次讓序號還原
   FOR li_i = 1 TO gdig_curr.getArrayLength(ps_array)
       CASE ps_array
          WHEN "s_tablesel"
             EXECUTE batch_refresh_seq_pre USING li_i, g_tablesel[li_i].seq    
          WHEN "s_join"
             EXECUTE batch_refresh_seq_pre USING li_i, g_join[li_i].dzgb003
          WHEN "s_fieldsel"
             EXECUTE batch_refresh_seq_pre USING li_i, g_fieldsel[li_i].dzgc003
          WHEN "s_filter"
              EXECUTE batch_refresh_seq_pre USING li_i, g_filter[li_i].dzgf003
              ## 140318mark-(s) 因為考慮到應用的場景會換enterprise，若寫在報表元件裡會無法置換，所以先由r、q、t那邊傳入
             #IF g_filter[li_i].dzgf003 <> 99 THEN  ##140317 add
                #EXECUTE batch_refresh_seq_pre USING li_i, g_filter[li_i].dzgf003
             #END IF 
             ## 140318mark-(e)
             
          #WHEN "s_typelist2"
              #IF g_typelist2[li_i].typeseq2 <> 0 THEN 
                 #LET idx = g_typelist2[li_i].typeseq2
                 #EXECUTE batch_refresh_seq_pre USING idx,  g_typelist2[li_i].typeseq2  
              #END IF                    
       END CASE
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = STATUS
          LET g_errparam.extend = ps_array
          LET g_errparam.popup = TRUE
          CALL cl_err()
       END IF 
   END FOR

   #重整
   CASE ps_array
      WHEN "s_tablesel"
         CALL adzp188_tablesel_b_fill()   
      WHEN "s_join"
         CALL adzp188_tablejoin_wclist_b_fill()
      WHEN "s_fieldsel"
         CALL adzp188_fieldsel_b_fill()
      WHEN "s_filter"
         CALL adzp188_filter_b_fill()
      #WHEN "s_typelist2"
         #CALL adzp188_typelist2_b_fill()

   END CASE

END FUNCTION

################################################################################
# Descriptions...: 欄位頁簽-動態切換標準欄位/自訂欄位的刪除功能鍵
# Memo...........: 
# Usage..........: CALL adzp188_set_fielddelete_active()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_fielddelete_active()

   IF g_fieldsel_idx > 0 THEN
      CASE g_fieldsel[g_fieldsel_idx].dzgc006
         WHEN "Y"
            CALL gdig_curr.setActionActive("del_field", FALSE)
            CALL gdig_curr.setActionActive("del_userfield", TRUE)
         WHEN "N"
            CALL gdig_curr.setActionActive("del_field", TRUE)
            CALL gdig_curr.setActionActive("del_userfield", FALSE)
      END CASE
   END IF

END FUNCTION

################################################################################
# Descriptions...: 欄位頁簽-樹狀欄位列表
# Memo...........: 
# Usage..........: CALL adzp188_fieldlist_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_fieldlist_b_fill()
   DEFINE li_i     LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   DEFINE ls_dzgb017 DYNAMIC ARRAY OF VARCHAR(15)
   DEFINE ls_i     LIKE type_t.num5

   
   CALL g_fieldlist.clear()    ##欄位頁籤的欄位樹狀清單
   CALL g_udfieldlist.clear()  ##自訂欄位的欄位樹狀清單
   CALL ls_dzgb017.clear()

   ##抓取別名
   LET g_sql = " SELECT dzgb017 FROM adzp188_dzgb_tmp ", 
               "  WHERE dzgb001 = ? AND dzgb002 = ?", 
               "    AND dzgb014 = ? ",
               #"    AND dzgb018 = ? AND dzgb019 =?"   #140613 add #141017 mark
               "    AND dzgb019 =?"   #141017 add
   PREPARE adzp188_get_dzgb017_pre FROM g_sql               
   DECLARE adzp188_get_dzgb017_cs1 CURSOR FOR adzp188_get_dzgb017_pre   
               
   #用被選的資料表產生父節點, 子節點為各自所屬欄位(兩個頁簽各自處理一樣的table+field, 效能不好要優化)
   LET li_cnt = 1
   FOR li_i = 1 TO g_tablesel.getLength()
       LET g_fieldlist[li_cnt].name = g_tablesel[li_i].id,":", g_tablesel[li_i].name
       LET g_fieldlist[li_cnt].id = g_tablesel[li_i].id
       LET g_fieldlist[li_cnt].exp = TRUE   #預設全開    #150525-00029#1 mark
       LET g_fieldlist[li_cnt].exp = FALSE  #改不展      #150525-00029#1 add
       LET g_fieldlist[li_cnt].isnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線

       ##自訂欄位開窗的欄位清單 140415-(s)
       LET g_udfieldlist[li_cnt].name = g_tablesel[li_i].id,":", g_tablesel[li_i].name
       LET g_udfieldlist[li_cnt].id = g_tablesel[li_i].id
       LET g_udfieldlist[li_cnt].exp = TRUE   #預設全開  #150525-00029#1 mark
       LET g_udfieldlist[li_cnt].exp = FALSE  #改不展    #150525-00029#1 add
       LET g_udfieldlist[li_cnt].isnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
       ##自訂欄位開窗的欄位清單 140415-(s)
       CALL adzp188_fieldlist_b_fill_child(g_tablesel[li_i].id,g_tablesel[li_i].id, li_cnt) RETURNING li_cnt

       ##140218 增加別名到可選擇清單 -(s)
       LET ls_i = 1       
       #FOREACH  adzp188_get_dzgb017_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id INTO ls_dzgb017[ls_i]  #140613 mark
       #FOREACH  adzp188_get_dzgb017_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id,g_cust,g_code_ide INTO ls_dzgb017[ls_i]  #140613 add  #141017 mark
       FOREACH  adzp188_get_dzgb017_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id,g_code_ide INTO ls_dzgb017[ls_i]  #141017 add
          IF NOT cl_null(ls_dzgb017[ls_i]) AND ls_dzgb017[ls_i] <> g_tablesel[li_i].id THEN 
             LET g_fieldlist[li_cnt].name = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],"):", g_tablesel[li_i].name
             LET g_fieldlist[li_cnt].id = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],")"
             #LET g_fieldlist[li_cnt].exp = TRUE   #預設全開  #150525-00029#1 mark
             LET g_fieldlist[li_cnt].exp = FALSE   #改不展    #150525-00029#1 add
             LET g_fieldlist[li_cnt].isnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線  
             ##自訂欄位開窗的欄位清單 140415-(s)
             LET g_udfieldlist[li_cnt].name = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],"):", g_tablesel[li_i].name
             LET g_udfieldlist[li_cnt].id = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],")"
             LET g_udfieldlist[li_cnt].exp = TRUE   #預設全開  #150525-00029#1 mark
             LET g_udfieldlist[li_cnt].exp = FALSE  #改不展   #150525-00029#1 add
             LET g_udfieldlist[li_cnt].isnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線               
             ##自訂欄位開窗的欄位清單 140415-(e)
             CALL adzp188_fieldlist_b_fill_child(g_tablesel[li_i].id, ls_dzgb017[ls_i],li_cnt) RETURNING li_cnt
             LET ls_i = ls_i + 1
          END IF 
       END FOREACH 
       ##140218 增加別名到可選擇清單 -(e)
   END FOR

END FUNCTION



################################################################################
# Descriptions...: 欄位頁簽-樹狀欄位列表(子節點)
# Memo...........: 
# Usage..........: CALL adzp188_fieldlist_b_fill_child(table_id, sn) RETURNING li_idx
# Input parameter: pc_dzea001   資料表
# ...............: pc_alias     別名
# ...............: pi_idx       最後節點位置
# Return code....: pi_idx       接下來的節點位置
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_fieldlist_b_fill_child(pc_dzea001,pc_alias, pi_idx)
   DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pc_alias     LIKE dzea_t.dzea001
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003

   LET g_sql = "SELECT dzeb002, dzebl003 FROM dzeb_t",
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzeb002 AND dzebl002 = '",g_lang,"'",
               " WHERE dzeb001 = '",pc_dzea001,"'",
               " ORDER BY dzeb002"
   PREPARE fieldlist_b_fill_pre FROM g_sql
   DECLARE fieldlist_b_fill_curs CURSOR FOR fieldlist_b_fill_pre

   LET pi_idx = pi_idx + 1
   FOREACH fieldlist_b_fill_curs INTO lc_dzeb002, lc_dzebl003
      ##欄位若是blob或clob不存入清單
      IF adzp188_chk_field_blobclob(lc_dzeb002) THEN 
         LET g_fieldlist[pi_idx].name = lc_dzeb002,":", lc_dzebl003
         LET g_fieldlist[pi_idx].id = lc_dzeb002
         IF pc_dzea001 = pc_alias THEN 
            LET g_fieldlist[pi_idx].pid = pc_dzea001
         ELSE 
            LET g_fieldlist[pi_idx].pid = pc_dzea001,"(",pc_alias,")"
         END IF 
         LET g_fieldlist[pi_idx].exp = FALSE
         LET g_fieldlist[pi_idx].isnode = FALSE
         LET g_fieldlist[pi_idx].alias = pc_alias

         ##自訂欄位視窗的欄位樹狀 140415-(s)
         LET g_udfieldlist[pi_idx].name = lc_dzeb002,":", lc_dzebl003
         LET g_udfieldlist[pi_idx].id = lc_dzeb002
         IF pc_dzea001 = pc_alias THEN 
            LET g_udfieldlist[pi_idx].pid = pc_dzea001
         ELSE 
            LET g_udfieldlist[pi_idx].pid = pc_dzea001,"(",pc_alias,")"
         END IF 
         LET g_udfieldlist[pi_idx].exp = FALSE
         LET g_udfieldlist[pi_idx].isnode = FALSE
         LET g_udfieldlist[pi_idx].alias = pc_alias
         ##自訂欄位視窗的欄位樹狀 140415-(e)
         
         LET pi_idx = pi_idx + 1
      END IF 
   END FOREACH

   RETURN pi_idx
END FUNCTION


################################################################################
# Descriptions...: GR排版頁簽-樹狀欄位列表(gr_grouplist1'gr_grouplist2)
# Memo...........: 
# Usage..........: CALL adzp188_gr_grouplist_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/23
# Modify.........:
################################################################################
FUNCTION adzp188_typelist1_b_fill()
   DEFINE li_i     LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   DEFINE ls_i     LIKE type_t.num5
   DEFINE lc_tablename LIKE dzeal_t.dzeal003
   DEFINE l_def_cnt    LIKE type_t.num5
   DEFINE ls_dzgb017 DYNAMIC ARRAY OF VARCHAR(15)   #140327

   
   CALL g_typelist1.clear()
   CALL ls_dzgb017.clear()    #140327

   ##抓取別名
   LET g_sql = " SELECT dzgb017 FROM adzp188_dzgb_tmp ", 
               "  WHERE dzgb001 = ? AND dzgb002 = ?", 
               "    AND dzgb014 = ? ",
               #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'"   #140703 add  #141017 mark
               "    AND dzgb019 ='",g_code_ide,"'"   #141017 add
   PREPARE adzp188_get_dzgb017_pre1 FROM g_sql               
   DECLARE adzp188_get_dzgb017_cs2 CURSOR FOR adzp188_get_dzgb017_pre1      

   LET li_cnt = 1
   FOR li_i = 1 TO g_tablesel.getLength()     
       SELECT dzeal003 INTO lc_tablename FROM dzeal_t 
        WHERE dzeal001 = g_tablesel[li_i].id AND dzeal002 = g_lang 
       ##GR排版頁籤左邊的樹也是相同來源 
       LET g_typelist1[li_cnt].typename1 = g_tablesel[li_i].id,":", lc_tablename
       LET g_typelist1[li_cnt].typeid1 = g_tablesel[li_i].id
       #LET g_typelist1[li_cnt].typeexp1 = TRUE   #預設全開   #150525-00029#1 mark
       LET g_typelist1[li_cnt].typeexp1 = FALSE   #不展開     #150525-00029#1 add
       LET g_typelist1[li_cnt].typeisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線          
       
       CALL adzp188_typelist1_b_fill_child(g_tablesel[li_i].id,'', li_cnt,'N') RETURNING li_cnt

      ##140327 增加別名到可選擇清單 -(s)
       LET ls_i = 1       
       FOREACH  adzp188_get_dzgb017_cs2 USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id INTO ls_dzgb017[ls_i]
          IF NOT cl_null(ls_dzgb017[ls_i]) AND ls_dzgb017[ls_i] <> g_tablesel[li_i].id THEN 
             LET g_typelist1[li_cnt].typename1 = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],"):", g_tablesel[li_i].name
             LET g_typelist1[li_cnt].typeid1 = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],")"
             LET g_typelist1[li_cnt].typeexp1 = TRUE   #預設全開#150525-00029#1 mark   
             LET g_typelist1[li_cnt].typeexp1 = FALSE  #不展開  #150525-00029#1 add
             LET g_typelist1[li_cnt].typeisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線         
             CALL adzp188_typelist1_b_fill_child(g_tablesel[li_i].id, ls_dzgb017[ls_i],li_cnt,'N') RETURNING li_cnt            
             LET ls_i = ls_i + 1
          END IF 
       END FOREACH 
       ##140327 增加別名到可選擇清單 -(e)
       
   END FOR

   #判斷是否有自定義欄位
   SELECT COUNT(*) INTO l_def_cnt FROM adzp188_dzgc_tmp  
    WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
      AND dzgc006 ='Y' 
   IF l_def_cnt > 0 THEN
       LET g_typelist1[li_cnt].typename1 = "自定義" ,":", "自定義欄位" 
       LET g_typelist1[li_cnt].typeid1 = "自定義"
       LET g_typelist1[li_cnt].typeexp1 = TRUE   #預設全開#150525-00029#1 mark   
       LET g_typelist1[li_cnt].typeexp1 = FALSE  #不展開  #150525-00029#1 add
       LET g_typelist1[li_cnt].typeisnode1  = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線

       CALL adzp188_typelist1_b_fill_child("自定義",'', li_cnt,'Y') RETURNING li_cnt       
   END IF    

END FUNCTION


################################################################################
# Descriptions...: GR排版頁簽-樹狀欄位列表(子節點)
# Memo...........: 
# Usage..........: CALL adzp188_typelist1_b_fill_child(table_id, sn,p_def) RETURNING li_idx
# Input parameter: pc_dzea001   資料表
# ...............: pi_idx       最後節點位置
# Return code....: p_def        接下來的節點位置
# Date & Author..: 2014/01/10
# Modify.........:
################################################################################
FUNCTION adzp188_typelist1_b_fill_child(pc_dzea001, pc_dzgb017,pi_idx,p_def)
   DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pc_dzgb017   LIKE dzgb_t.dzgb017
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE p_def        LIKE dzgc_t.dzgc006
   DEFINE lc_dzgc007   LIKE dzgc_t.dzgc007
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_prefix    STRING 

   
   IF p_def = "N" THEN ##非自定義欄位 
       LET lc_prefix = pc_dzea001
       LET lc_prefix = lc_prefix.subString(1,lc_prefix.getIndexOf("_",1)-1) 
       IF cl_null(pc_dzgb017) THEN 
           LET g_sql = " SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp ",  ##140327add dzgc007
                       "        LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                       " WHERE dzgc004 LIKE '",lc_prefix.trim(),"%'", " AND dzgc006 ='",p_def,"'",
                       #" AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'", #140923 elena mark
                       " AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",            #140923 elena add
                       " AND dzgc007 ='",pc_dzea001,"'",
                       " AND dzgc009 ='",g_code_ide,"'",  #140714 add
                       " ORDER BY dzgc003 "
       ELSE 
           LET g_sql = " SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp ",  ##140327add dzgc007
                       "        LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                       " WHERE dzgc004 LIKE '",lc_prefix.trim(),"%'", " AND dzgc006 ='",p_def,"'",
                       #" AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",        #140923 elena mark
                       " AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",                   #140923 elena add
                       " AND dzgc007 ='",pc_dzgb017,"'",
                       " AND dzgc009 ='",g_code_ide,"'",  #140714 add
                       " ORDER BY dzgc003 "       
       END IF 
                   
       PREPARE typelist_b_fill_pre FROM g_sql
       DECLARE typelist_b_fill_curs CURSOR FOR typelist_b_fill_pre
       
       LET pi_idx = pi_idx + 1
       FOREACH typelist_b_fill_curs INTO lc_dzgc004, lc_dzebl003, lc_dzgc007
          LET g_typelist1[pi_idx].typename1 = lc_dzgc004,":", lc_dzebl003
          LET g_typelist1[pi_idx].typeid1 = lc_dzgc004
          IF cl_null(pc_dzgb017) THEN 
             LET g_typelist1[pi_idx].typepid1 = pc_dzea001
          ELSE 
             LET g_typelist1[pi_idx].typepid1 = pc_dzea001,"(",pc_dzgb017,")"
          END IF 
          LET g_typelist1[pi_idx].typeexp1 = FALSE
          LET g_typelist1[pi_idx].typeisnode1 = FALSE      
          LET g_typelist1[pi_idx].typealias1 = lc_dzgc007  ##140327add dzgc007
          LET pi_idx = pi_idx + 1
       END FOREACH
   ELSE 

       LET g_sql = "SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp",
                   " LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                   #" WHERE dzgc001 ='",g_dzga_m.dzga001,"' AND dzgc002 ='",g_dzga_m.dzga002,"'",   #140923 elena mark
                   " WHERE dzgc001 ='",g_dzga_m.dzga001,"' AND dzgc002 ='",gs_ver,"'",              #140923 elena add
                   " AND  dzgc006 ='",p_def,"'",
                   " AND dzgc009 ='",g_code_ide,"'",  #140714 add
                   " ORDER BY dzgc003"
       PREPARE typelist_b_fill_pre1 FROM g_sql
       DECLARE typelist_b_fill_curs1 CURSOR FOR typelist_b_fill_pre1  
       LET pi_idx = pi_idx + 1 
       FOREACH typelist_b_fill_curs1 INTO lc_dzgc004, lc_dzebl003,lc_dzgc007##140327add dzgc007
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) THEN 
             SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
              WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                AND dzgd003 = lc_dzgc004 
                AND dzgd008 = g_code_ide  #140714 add
          END IF 
          LET g_typelist1[pi_idx].typename1 = lc_dzgc004,":", lc_dzebl003
          LET g_typelist1[pi_idx].typeid1 = lc_dzgc004
          LET g_typelist1[pi_idx].typepid1 = pc_dzea001
          LET g_typelist1[pi_idx].typeexp1 = FALSE
          LET g_typelist1[pi_idx].typeisnode1 = FALSE     
          LET g_typelist1[pi_idx].typealias1 = lc_dzgc007  ##140327add dzgc007
          LET pi_idx = pi_idx + 1
       END FOREACH  
       
   END IF 
   RETURN pi_idx
END FUNCTION


################################################################################
# Descriptions...: GR群組頁簽-樹狀欄位列表(gr_grouplist1'gr_grouplist2)
# Memo...........: 
# Usage..........: CALL adzp188_gr_grouplist_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/23
# Modify.........:
################################################################################
FUNCTION adzp188_gr_grouplist_b_fill()
   DEFINE li_i     LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   DEFINE ls_i     LIKE type_t.num5
   DEFINE l_def_cnt LIKE type_t.num5


   #140223janet
   CALL g_gr_grouplist1.clear()
   #CALL g_gr_grouplist2.clear()   ##150324 mark

   LET li_cnt = 1
   FOR li_i = 1 TO g_tablesel.getLength()
       #gr_grouplist1
       LET g_gr_grouplist1[li_cnt].groupname1 = g_tablesel[li_i].id,":", g_tablesel[li_i].name
       LET g_gr_grouplist1[li_cnt].groupid1 = g_tablesel[li_i].id
       LET g_gr_grouplist1[li_cnt].groupexp1 = TRUE   #預設全開  
       LET g_gr_grouplist1[li_cnt].groupisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線

       ##150324 共用grouplist1 mark-(s)
       #gr_grouplist2
       #LET g_gr_grouplist2[li_cnt].groupname2 = g_tablesel[li_i].id,":", g_tablesel[li_i].name
       #LET g_gr_grouplist2[li_cnt].groupid2 = g_tablesel[li_i].id
       #LET g_gr_grouplist2[li_cnt].groupexp2 = TRUE   #預設全開
       #LET g_gr_grouplist2[li_cnt].groupisnode2 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線       
       ##150324 共用grouplist1 mark-(s)   
       #CALL adzp188_gr_grouplist_b_fill_child(g_tablesel[li_i].id, li_cnt) RETURNING li_cnt #140714 mark
       CALL adzp188_gr_grouplist_b_fill_child(g_tablesel[li_i].id, li_cnt,'N') RETURNING li_cnt  #140714 add
   END FOR

   #140714 add 自定義欄位-(s)
   #判斷是否有自定義欄位
   SELECT COUNT(*) INTO l_def_cnt FROM adzp188_dzgc_tmp  
    WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002  
      AND dzgc006 ='Y'  
      #AND dzgc008 = g_cust AND dzgc009 = g_code_ide   #140613 add  #141017 mark
      AND dzgc009 = g_code_ide   #141017 add 
   IF l_def_cnt > 0 THEN
       LET g_gr_grouplist1[li_cnt].groupname1 = "自定義" ,":", "自定義欄位" 
       LET g_gr_grouplist1[li_cnt].groupid1 = "自定義"
       LET g_gr_grouplist1[li_cnt].groupexp1 = TRUE   #預設全開      
       LET g_gr_grouplist1[li_cnt].groupisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
       ##150324 共用grouplist1 mark-(s)
       #LET g_gr_grouplist2[li_cnt].groupname2 = "自定義" ,":", "自定義欄位" 
       #LET g_gr_grouplist2[li_cnt].groupid2 = "自定義"
       #LET g_gr_grouplist2[li_cnt].groupexp2 = TRUE   #預設全開
       #LET g_gr_grouplist2[li_cnt].groupisnode2 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
       ##150324 共用grouplist1 mark-(e) 
       CALL adzp188_gr_grouplist_b_fill_child("自定義", li_cnt,'Y') RETURNING li_cnt       
   END IF 
   

   #140714 add 自定義欄位-(e)

END FUNCTION


################################################################################
# Descriptions...: GR群組頁簽-樹狀欄位列表(子節點)
# Memo...........: 
# Usage..........: CALL adzp188_gr_grouplist_b_fill_child(pc_dzea001, pi_idx,p_def) RETURNING li_idx
# Input parameter: pc_dzea001   資料表
# ...............: pi_idx       最後節點位置
# ...............: p_def        是否為自定義欄位   #140714 add
# Return code....: pi_idx       接下來的節點位置
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
#FUNCTION adzp188_gr_grouplist_b_fill_child(pc_dzea001, pi_idx)  #140714  mark
FUNCTION adzp188_gr_grouplist_b_fill_child(pc_dzea001, pi_idx,p_def)   #140714  add
   DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pc_alias     LIKE dzea_t.dzea001
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE p_def        LIKE type_t.chr1   #140714 add
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004  #140714 add

   IF p_def="N" THEN  #140714 add
       LET g_sql = "SELECT dzeb002, dzebl003 FROM dzeb_t",
                   "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzeb002 AND dzebl002 = '",g_lang,"'",
                   " WHERE dzeb001 = '",pc_dzea001,"'",
                   " ORDER BY dzeb002"
       PREPARE gr_grouplist_b_fill_pre FROM g_sql
       DECLARE gr_grouplist_b_fill_curs CURSOR FOR gr_grouplist_b_fill_pre

       LET pi_idx = pi_idx + 1
       FOREACH gr_grouplist_b_fill_curs INTO lc_dzeb002, lc_dzebl003
          ##欄位若是blob或clob不存入清單
          IF adzp188_chk_field_blobclob(lc_dzeb002) THEN           
             #gr_grouplist1
             LET g_gr_grouplist1[pi_idx].groupname1 = lc_dzeb002,":", lc_dzebl003
             LET g_gr_grouplist1[pi_idx].groupid1 = lc_dzeb002
             LET g_gr_grouplist1[pi_idx].grouppid1 = pc_dzea001
             LET g_gr_grouplist1[pi_idx].groupexp1 = FALSE
             LET g_gr_grouplist1[pi_idx].groupisnode1 = FALSE

             ##150324 共用grouplist1 mark -(s)
             ##gr_grouplist2
             #LET g_gr_grouplist2[pi_idx].groupname2 = lc_dzeb002,":", lc_dzebl003
             #LET g_gr_grouplist2[pi_idx].groupid2 = lc_dzeb002
             #LET g_gr_grouplist2[pi_idx].grouppid2 = pc_dzea001
             #LET g_gr_grouplist2[pi_idx].groupexp2 = FALSE
             #LET g_gr_grouplist2[pi_idx].groupisnode2 = FALSE
             ##150324 共用grouplist1 mark -(e)
             
             LET pi_idx = pi_idx + 1
          END IF 
       END FOREACH
   #140714 add-(s)
   ELSE 
       LET g_sql = "SELECT dzgc004, dzebl003 FROM adzp188_dzgc_tmp",
                   " LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                   " WHERE dzgc006 ='",p_def,"'",
                  # "   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",   #140613 add  #141013 mark 
                   "   AND dzgc009 ='",g_code_ide,"'",                                           #141013 add                              
                   " ORDER BY dzgc004"
       PREPARE gr_grouplist_b_fill_pre1 FROM g_sql
       DECLARE gr_grouplist_b_fill_curs1 CURSOR FOR gr_grouplist_b_fill_pre1  
        LET pi_idx = pi_idx + 1 
        FOREACH gr_grouplist_b_fill_curs1 INTO lc_dzgc004, lc_dzebl003
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) THEN 
             SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
              WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002            
                AND dzgd003 = lc_dzgc004
                #AND dzgd007 = g_cust AND dzgd008 = g_code_ide    #140613 add    #141013 mark
                AND dzgd008 = g_code_ide                                         #141013 add
          END IF         
          LET g_gr_grouplist1[pi_idx].groupname1 = lc_dzgc004,":", lc_dzebl003
          LET g_gr_grouplist1[pi_idx].groupid1 = lc_dzgc004
          LET g_gr_grouplist1[pi_idx].grouppid1 = pc_dzea001
          LET g_gr_grouplist1[pi_idx].groupexp1 = FALSE
          LET g_gr_grouplist1[pi_idx].groupisnode1 = FALSE
          
          ##150324 共用grouplist1 mark -(s) 
          ##gr_grouplist2
          #LET g_gr_grouplist2[pi_idx].groupname2 = lc_dzgc004,":", lc_dzebl003
          #LET g_gr_grouplist2[pi_idx].groupid2 = lc_dzgc004
          #LET g_gr_grouplist2[pi_idx].grouppid2 = pc_dzea001
          #LET g_gr_grouplist2[pi_idx].groupexp2 = FALSE
          #LET g_gr_grouplist2[pi_idx].groupisnode2 = FALSE        
          ##150324 共用grouplist1 mark -(e) 
          LET pi_idx = pi_idx + 1
       END FOREACH  
       
   END IF 
   #140714 add-(e)

   RETURN pi_idx
END FUNCTION


################################################################################
# Descriptions...: 欄位頁簽-已挑選欄位列表
# Memo...........: 
# Usage..........: CALL adzp188_fieldsel_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_fieldsel_b_fill()
   DEFINE lc_dzgc003   LIKE dzgc_t.dzgc003
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_dzgc005   LIKE dzgc_t.dzgc005
   DEFINE lc_dzgc006   LIKE dzgc_t.dzgc006
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lc_dzgcchk   LIKE type_t.chr1 
   DEFINE lc_dzgc007   LIKE dzgc_t.dzgc007
   DEFINE lc_dzgd006   LIKE dzgd_t.dzgd006    ##140508公式

   CALL g_fieldsel.clear()

   LET g_sql = "SELECT dzgd005 FROM adzp188_dzgd_tmp",
               #" WHERE dzgd001 = '", g_dzga_m.dzga001,"' AND dzgd002 = '", g_dzga_m.dzga002,"' AND dzgd003 = ?",  #140923 elena mark
               " WHERE dzgd001 = '", g_dzga_m.dzga001,"' AND dzgd002 = '", gs_ver,"' AND dzgd003 = ?",             #140923 elena add
               "   AND dzgd008 ='",g_code_ide,"'"  #140702 add
   PREPARE get_udfield_name_pre FROM g_sql

   LET g_sql = " SELECT 'N',dzgc007,dzgc003, dzgc004, dzebl003, dzgc005, dzgc006,dzgd006 FROM adzp188_dzgc_tmp",   ##140508 dzgd006
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
               "  LEFT OUTER JOIN adzp188_dzgd_tmp ON dzgd001 = dzgc001 AND dzgd002 = dzgc002 AND dzgd003 = dzgc004 ",  ##140508公式 
               #" WHERE dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",    #140923 elena mark
               " WHERE dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",              #140923 elena add
               "   AND dzgc009 ='",g_code_ide,"'",  #140702 add
               " ORDER BY dzgc003"
   PREPARE fieldsel_b_fill_pre FROM g_sql
   DECLARE fieldsel_b_fill_curs CURSOR FOR fieldsel_b_fill_pre
   LET li_cnt = 1
   FOREACH fieldsel_b_fill_curs INTO lc_dzgcchk,lc_dzgc007,lc_dzgc003, lc_dzgc004, lc_dzebl003, lc_dzgc005, lc_dzgc006,lc_dzgd006

      IF cl_null(lc_dzebl003) THEN 
         SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
          WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002  
            AND dzgd003 = lc_dzgc004 
            AND dzgd008 = g_code_ide   #140702 add
      END IF 
  
      IF g_fieldsel[li_cnt].dzgcchk = "N" THEN  
         LET g_fieldsel[li_cnt].dzgcchk = lc_dzgcchk
      END IF 
      LET g_fieldsel[li_cnt].dzgc007 = lc_dzgc007
      LET g_fieldsel[li_cnt].dzgcchk = lc_dzgcchk   
      LET g_fieldsel[li_cnt].dzgc004 = lc_dzgc004
      LET g_fieldsel[li_cnt].name = lc_dzebl003
      CASE lc_dzgc005
         WHEN "1"
            LET g_fieldsel[li_cnt].ext = "Y"
            LET g_fieldsel[li_cnt].print = "Y"
         WHEN "2"
            LET g_fieldsel[li_cnt].ext = "Y"
            LET g_fieldsel[li_cnt].print = "N"
         WHEN "3"
            LET g_fieldsel[li_cnt].ext = "N"
            LET g_fieldsel[li_cnt].print = "Y"
      END CASE
      LET g_fieldsel[li_cnt].dzgc006 = lc_dzgc006
      IF lc_dzgc006 = "Y" THEN
         EXECUTE get_udfield_name_pre USING lc_dzgc004 INTO g_fieldsel[li_cnt].name
      END IF
      LET g_fieldsel[li_cnt].dzgc003 = lc_dzgc003
      LET g_fieldsel[li_cnt].dzgd006 = lc_dzgd006
      LET li_cnt = li_cnt + 1
   END FOREACH

END FUNCTION



################################################################################
# Descriptions...: 欄位頁簽-維護自訂欄位明細及設定值, 需在進入前指定g_dzgd_d.*的值
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzgd("add")
# Input parameter: ps_type      add新增/upd修改/del刪除
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzgd(ps_type)
   DEFINE ps_type      STRING


   CASE ps_type
      WHEN "add"
        
         ##140327 add-(S)  判斷存入的dzgd006
         CASE g_dzgd006_1
            ##150211 add -(s)
            WHEN "0"
                LET g_dzgd_d.dzgd006 = "0"
            ##150211 add -(e)           
            WHEN "1"
               LET g_dzgd_d.dzgd006 = "NULL"
            WHEN "2"
               LET g_dzgd_d.dzgd006 = "''"

         END CASE
        ##140327 add-(e) 
         ##141013 mark -(s)
         #INSERT INTO adzp188_dzgd_tmp
         #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzgd_d.dzgd003, g_dzgd_d.dzgd004,          
                #g_dzgd_d.dzgd005, g_dzgd_d.dzgd006,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
         ##141013 mark -(e)       
         ##141013 add -(s)   
         LET g_sql = " INSERT INTO adzp188_dzgd_tmp ",                    
                     "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?)" 
         PREPARE adzp188_dzgd_tmp_ins_pre FROM g_sql
         EXECUTE adzp188_dzgd_tmp_ins_pre USING g_dzgd_d.dzgd003, g_dzgd_d.dzgd004, g_dzgd_d.dzgd005, g_dzgd_d.dzgd006,g_cust,g_code_ide 
         ##141013 add -(e)
                
      WHEN "upd"
         #修改的時機點還不確定, 先不寫
      WHEN "del"
         DELETE FROM adzp188_dzgd_tmp
          WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002 AND dzgd003 = g_dzgd_d.dzgd003  
            #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add  #141013 mark
            AND dzgd008 = g_code_ide #141013 add  
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 篩選頁簽-篩選條件列表
# Memo...........: 
# Usage..........: CALL adzp188_filter_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_filter_b_fill()
   DEFINE li_cnt   LIKE type_t.num5

   CALL g_filter.clear()

   LET g_sql = " SELECT dzgf003, dzgf004, dzgf005, dzgf006, dzgf007, dzgf008, dzgf009, dzgf010, '' FROM adzp188_dzgf_tmp",
               #" WHERE dzgf001 = '",g_dzga_m.dzga001,"' AND dzgf002 = '",g_dzga_m.dzga002,"'",     #140923 elena mark
                " WHERE dzgf001 = '",g_dzga_m.dzga001,"' AND dzgf002 = '",gs_ver,"'",              #140923 elena add
               #"   AND dzgf011 = '",g_cust,"' AND dzgf012 = '",g_code_ide,"'",       #140613 add  #141013 mark
               "   AND dzgf012 = '",g_code_ide,"'",       #141013 add
               " ORDER BY dzgf003"
   PREPARE filter_b_fill_pre FROM g_sql
   DECLARE filter_b_fill_curs CURSOR FOR filter_b_fill_pre
   
   LET li_cnt = 1
   
   FOREACH filter_b_fill_curs INTO g_filter[li_cnt].*    
      IF SQLCA.sqlcode THEN
        EXIT FOREACH
      END IF
      
      LET g_filter[li_cnt].wc = adzp188_combine_filter_wc(g_filter[li_cnt].dzgf004, g_filter[li_cnt].dzgf005, g_filter[li_cnt].dzgf006, g_filter[li_cnt].dzgf007, g_filter[li_cnt].dzgf008, g_filter[li_cnt].dzgf009, g_filter[li_cnt].dzgf010)

      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL g_filter.deleteElement(li_cnt)

   DISPLAY adzp188_combine_all_filter_wc() TO FORMONLY.filter_wc_combine

END FUNCTION

################################################################################
# Descriptions...: 篩選頁簽-組合filter條件回傳
# Memo...........: 
# Usage..........: CALL adzp188_combine_filter_wc(ps_dzgf004, ps_dzgf005, ps_dzgf006, ps_dzgf007, ps_dzgf008, ps_dzgf009, ps_dzgf010)
# Input parameter: ps_dzgf004    (
# ...............: ps_dzgf005    資料表
# ...............: ps_dzgf006    欄位
# ...............: ps_dzgf007    運算字元
# ...............: ps_dzgf008    值
# ...............: ps_dzgf009    )
# ...............: ps_dzgf010    AND/OR
# Return code....: str           組合條件
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_combine_filter_wc(ps_dzgf004, ps_dzgf005, ps_dzgf006, ps_dzgf007, ps_dzgf008, ps_dzgf009, ps_dzgf010)
   DEFINE ps_dzgf004, ps_dzgf005, ps_dzgf006, ps_dzgf007, ps_dzgf008, ps_dzgf009, ps_dzgf010   STRING
   DEFINE ls_wc   STRING
   DEFINE ls_con_str LIKE type_t.chr1 

   IF ps_dzgf004 IS NOT NULL THEN
      ##140804 add -(s)
      CASE ps_dzgf004
         WHEN "1"  LET ls_wc = "( "
         WHEN "2"  LET ls_wc = "(( "
         WHEN "3"  LET ls_wc = "((( "
         WHEN "4"  LET ls_wc = "(((( "
         WHEN "5"  LET ls_wc = "((((( "          
      END CASE 
      ##140804 add -(e) 
      #LET ls_wc = ps_dzgf004," "  ##140804 mark
   END  IF
   LET ls_wc = ls_wc, ps_dzgf005,".",ps_dzgf006
   CASE ps_dzgf007
      WHEN "01" LET ls_wc = ls_wc, " ="
      WHEN "02" LET ls_wc = ls_wc, " <>"
      WHEN "03" LET ls_wc = ls_wc, " >"
      WHEN "04" LET ls_wc = ls_wc, " <"
      WHEN "05" LET ls_wc = ls_wc, " >="
      WHEN "06" LET ls_wc = ls_wc, " <="
      WHEN "07" LET ls_wc = ls_wc, " BETWEEN"
      WHEN "08" LET ls_wc = ls_wc, " NOT BETWEEN"
      WHEN "09" LET ls_wc = ls_wc, " LIKE"
      WHEN "10" LET ls_wc = ls_wc, " NOT LIKE"
      WHEN "11" LET ls_wc = ls_wc, " IN"
      WHEN "12" LET ls_wc = ls_wc, " NOT IN"
      WHEN "13" LET ls_wc = ls_wc, " IS NULL"
      WHEN "14" LET ls_wc = ls_wc, " IS NOT NULL"
   END CASE
   CASE
      WHEN  ps_dzgf007 = "11" OR ps_dzgf007 = "12"
         LET ls_wc = ls_wc, " (", ps_dzgf008 ,")"
      WHEN ps_dzgf007 = "13" OR ps_dzgf007 = "14"
      WHEN ps_dzgf007 = "07" OR ps_dzgf007 = "08"
         LET ls_wc = ls_wc, " ", ps_dzgf008 
      OTHERWISE
         #判斷欄位型態
         #131219未寫完-(S)  #140217
         #CALL adzp188_decide_field_type(ps_dzgf006) RETURNING ls_con_str
         #LET ls_wc = ls_wc, " ",ls_con_str, ps_dzgf008,ls_con_str
         #131219未寫完-(S)
         LET ls_wc = ls_wc, " '", ps_dzgf008,"'"
   END CASE
   IF ps_dzgf009 IS NOT NULL THEN
      ##140804 add -(s)
      CASE ps_dzgf009
         WHEN "1"  LET ls_wc = ls_wc," )"
         WHEN "2"  LET ls_wc = ls_wc," ))"
         WHEN "3"  LET ls_wc = ls_wc," )))"
         WHEN "4"  LET ls_wc = ls_wc," ))))"
         WHEN "5"  LET ls_wc = ls_wc," )))))"          
      END CASE 
      ##140804 add -(e)   
      #LET ls_wc = ls_wc, " ", ps_dzgf009  #140804 mark
   END IF
   CASE ps_dzgf010
      WHEN "1" LET ls_wc = ls_wc, " AND"
      WHEN "2" LET ls_wc = ls_wc, " OR"
   END CASE

   RETURN ls_wc

END FUNCTION

################################################################################
# Descriptions...: 篩選頁簽-組合全部篩選條件回傳
# Memo...........: 
# Usage..........: CALL adzp188_combine_all_filter_wc() RETURNING ls_filter_wc
# Input parameter: None
# Return code....: ls_filter_wc   組合字串
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_combine_all_filter_wc()
   DEFINE ls_filter_wc   STRING
   DEFINE li_i           LIKE type_t.num5

   FOR li_i = 1 TO g_filter.getLength()
       LET ls_filter_wc = ls_filter_wc, " ", g_filter[li_i].wc
   END FOR

   RETURN ls_filter_wc

END FUNCTION

################################################################################
# Descriptions...: 判斷欄位型態後回傳組的字串是' 或空
# Memo...........: 
# Usage..........: CALL adzp188_decide_field_type() RETURNING ls_con_str
# Input parameter: None
# Return code....: ls_con_str   組合字串
# Date & Author..: 2014/02/17
# Modify.........:
################################################################################
FUNCTION adzp188_decide_field_type(p_field)
DEFINE p_field        LIKE dzgf_t.dzgf006
DEFINE ls_con_str     STRING 
DEFINE l_datatype     LIKE dzeb_t.dzeb007
DEFINE l_length       LIKE dzeb_t.dzeb008
DEFINE l_gztz001      LIKE gztz_t.gztz001

   SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = p_field
      AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
      ##161227-00056#1 add -(s)
      AND gztz001 NOT LIKE 'erp%'   
      AND gztz001 NOT LIKE 'all%'
      AND gztz001 NOT LIKE 'b2b%'
      AND gztz001 NOT LIKE 'pos%'
      AND gztz001 NOT LIKE 'dsm%'
      ##161227-00056#1 add -(e)      
   LET ls_con_str =""
   #CALL cl_xg_get_column_info('ds',l_gztz001,p_field)    #150901-00021#1 mark
   CALL cl_rpt_get_column_info('ds',l_gztz001,p_field)    #150901-00021#1 add
        RETURNING l_datatype,l_length
   CASE l_datatype
        WHEN "varchar"  LET ls_con_str = "\'"
        WHEN "varchar2" LET ls_con_str = "\'"
        WHEN "number"   LET ls_con_str = ""
        WHEN "date"     LET ls_con_str = "\'"
        WHEN "datetime" LET ls_con_str = "\'"
        OTHERWISE       LET ls_con_str = "\'"
   END CASE 
        
  

END FUNCTION 

################################################################################
# Descriptions...: 篩選頁簽-產生範例字串
# Memo...........: 
# Usage..........: CALL adzp188_filter_sample("dzgf004") RETURNING ls_sample
# Input parameter: ps_fieldname   要呈現哪一個欄位的範例
# Return code....: ls_sample      範例字串
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_filter_sample(ps_fieldname)
   DEFINE ps_fieldname   STRING
   DEFINE ls_sample      STRING
   DEFINE lcb_item       ui.ComboBox
   DEFINE lc_dzeb002     LIKE dzeb_t.dzeb002

   CASE ps_fieldname
      WHEN "dzgf005"
         #若dzgf005無值, 範例為產生出的ComboBox第一個選項; 有值, 範例為輸入值
         LET lcb_item = ui.ComboBox.forName("dzgf_t.dzgf005")
         IF lcb_item IS NOT NULL THEN
            IF cl_null(g_dzgf_d.dzgf005) THEN
               LET ls_sample = lcb_item.getItemName(1)
            ELSE
               LET ls_sample = g_dzgf_d.dzgf005
            END IF
         END IF
      WHEN "dzgf006"
         #若dzgf006無值, 範例為產生出的ComboBox第一個選項; 有值, 範例為輸入值
         LET lcb_item = ui.ComboBox.forName("dzgf_t.dzgf006")
         IF lcb_item IS NOT NULL THEN
            IF cl_null(g_dzgf_d.dzgf006) THEN
               LET ls_sample = lcb_item.getItemName(1)
            ELSE
               LET ls_sample = g_dzgf_d.dzgf006
            END IF
         END IF
      WHEN "dzgf007"
         #若dzgf007無值, 範例為產生出的ComboBox第一個選項; 有值, 範例為輸入值的text
         LET lcb_item = ui.ComboBox.forName("dzgf_t.dzgf007")
         IF lcb_item IS NOT NULL THEN
            IF cl_null(g_dzgf_d.dzgf007) THEN
               LET ls_sample = lcb_item.getItemText(1)
            ELSE
               LET ls_sample = lcb_item.getTextOf(g_dzgf_d.dzgf007)
            END IF
         END IF
      WHEN "dzgf008"
         #視dzgf007的值, 顯示不同的範例
         CASE g_dzgf_d.dzgf007
            WHEN "01" LET ls_sample = "X"
            WHEN "02" LET ls_sample = "X"
            WHEN "03" LET ls_sample = "2013/01/01"
            WHEN "04" LET ls_sample = "10000"
            WHEN "05" LET ls_sample = "2013/01/01"
            WHEN "06" LET ls_sample = "10000"
            WHEN "07" LET ls_sample = "0 AND 9"
            WHEN "08" LET ls_sample = "0 AND 9"
            WHEN "09" LET ls_sample = "001%"
            WHEN "10" LET ls_sample = "001%"
            WHEN "11" LET ls_sample = "('A','B','C')"
            WHEN "12" LET ls_sample = "('A','B','C')"
            WHEN "13" LET ls_sample = ""
            WHEN "14" LET ls_sample = ""
         END CASE
   END CASE

   RETURN ls_sample

END FUNCTION

################################################################################
# Descriptions...: 篩選頁簽-將選擇的filter條件轉顯示在單檔, 以供直接維護
# Memo...........: 
# Usage..........: CALL adzp188_separate_filter_wc(g_filter_idx)
# Input parameter: pi_idx   選擇資料
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_separate_filter_wc(pi_idx)
   DEFINE pi_idx   LIKE type_t.num5
   DEFINE li_i     LIKE type_t.num5
   DEFINE lcb_item       ui.ComboBox

   IF pi_idx > 0 THEN
      LET g_dzgf_d.dzgf004 = g_filter[pi_idx].dzgf004
      LET g_dzgf_d.dzgf005 = g_filter[pi_idx].dzgf005
      CALL adzp188_set_field_comboitems("dzgf_t.dzgf006", g_dzgf_d.dzgf005, TRUE) RETURNING g_dzgf_d.dzgf006
      LET g_dzgf_d.dzgf006 = g_filter[pi_idx].dzgf006
      LET g_dzgf_d.dzgf007 = g_filter[pi_idx].dzgf007
      LET g_dzgf_d.dzgf008 = g_filter[pi_idx].dzgf008
      LET g_dzgf_d.dzgf009 = g_filter[pi_idx].dzgf009
      LET g_dzgf_d.dzgf010 = g_filter[pi_idx].dzgf010
   ELSE
      LET g_dzgf_d.dzgf004 = ""
      LET g_dzgf_d.dzgf005 = g_tablesel[1].id
      CALL adzp188_set_field_comboitems("dzgf_t.dzgf006", g_dzgf_d.dzgf005, TRUE) RETURNING g_dzgf_d.dzgf006
      LET lcb_item = ui.ComboBox.forName("dzgf_t.dzgf006")
      IF lcb_item IS NOT NULL THEN
         LET g_dzgf_d.dzgf006 = lcb_item.getItemName(1)
      END IF
      LET g_dzgf_d.dzgf007 = "01"
   END IF

END FUNCTION

################################################################################
# Descriptions...: 篩選頁簽-維護dzgf_t及更新wc組合字串
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzgf(1, "add)
# Input parameter: pi_idx     指定序號
# ...............: ps_type    add新增, upd修改或del刪除
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzgf(pi_idx, ps_type)
   DEFINE pi_idx     LIKE type_t.num5
   DEFINE ps_type    STRING

   CASE ps_type
      WHEN "add"
         #檢查單頭是否存入, 若還未存入必須先INSERT單頭
         #dzga_t count IS NULL, INSERT INTO dzga_t

         #是否必須檢查dzgf004~dzgf010都必須有值?

         SELECT MAX(dzgf003) + 1 INTO g_dzgf_d.dzgf003 FROM adzp188_dzgf_tmp
          WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002       
          #141013 mark -(s)
            #AND dzgf011 = g_cust AND dzgf012 = g_code_ide #140613 add
            ## AND dzgf003 < 99                                             ##140317 add  ##140318 mark     
          #141013 mark -(e)
            AND dzgf012 = g_code_ide   #141013 add

           
         IF cl_null(g_dzgf_d.dzgf003) OR g_dzgf_d.dzgf003 = 0 THEN
            LET g_dzgf_d.dzgf003 = 1
         END IF
         ##141013 mark -(s)
         #INSERT INTO adzp188_dzgf_tmp
         #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzgf_d.dzgf003, g_dzgf_d.dzgf004, g_dzgf_d.dzgf005,
                #g_dzgf_d.dzgf006, g_dzgf_d.dzgf007, g_dzgf_d.dzgf008, g_dzgf_d.dzgf009, g_dzgf_d.dzgf010,
                #g_cust,g_code_ide)  #140613 add
         ##141013 mark -(e) 
         ##141013 add -(s)   
         LET g_sql = " INSERT INTO adzp188_dzgf_tmp ",                    
                     "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?,?)" 
         PREPARE adzp188_dzgf_tmpp_ins_pre FROM g_sql
         EXECUTE adzp188_dzgf_tmpp_ins_pre USING g_dzgf_d.dzgf003, g_dzgf_d.dzgf004, g_dzgf_d.dzgf005,
                g_dzgf_d.dzgf006, g_dzgf_d.dzgf007, g_dzgf_d.dzgf008, g_dzgf_d.dzgf009, g_dzgf_d.dzgf010,
                g_cust,g_code_ide
         ##141013 add -(e)

                
      WHEN "upd"
         IF pi_idx > 0 THEN
            UPDATE adzp188_dzgf_tmp SET dzgf004 = g_dzgf_d.dzgf004, dzgf005 = g_dzgf_d.dzgf005,
                                        dzgf006 = g_dzgf_d.dzgf006, dzgf007 = g_dzgf_d.dzgf007,
                                        dzgf008 = g_dzgf_d.dzgf008, dzgf009 = g_dzgf_d.dzgf009,
                                        dzgf010 = g_dzgf_d.dzgf010
             WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002 
               AND dzgf003 = g_filter[pi_idx].dzgf003
               #AND dzgf011 = g_cust AND dzgf012 = g_code_ide #140613 add  #141013 mark
               AND dzgf012 = g_code_ide  ##141013 add
             
         END IF
      WHEN "del"
         IF pi_idx > 0 THEN
            DELETE FROM adzp188_dzgf_tmp
             WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
               AND dzgf003 = g_filter[pi_idx].dzgf003   
               #AND dzgf011 = g_cust AND dzgf012 = g_code_ide #140613 add  ##141013 mark
               AND dzgf012 = g_code_ide ##141013 add
 
         END IF
   END CASE

   CALL adzp188_filter_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 開立設計資料暫存檔
# Memo...........: 
# Usage..........: CALL adzp188_create_design_temptable()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_create_design_temptable()

   #LIKE的方式還不能用, 等架構組
   #dzga_t報表元件設計主檔
#  CREATE TEMP TABLE adzp188_dzga_tmp
#  (
#  dzgastus   LIKE dzga_t.dzgastus,
#  dzga001    LIKE dzga_t.dzga001,
#  dzga002    LIKE dzga_t.dzga002,
#  dzga003    LIKE dzga_t.dzga003,
#  dzga004    LIKE dzga_t.dzga004,
#  dzgaownid  LIKE dzga_t.dzgaownid,
#  dzgaowndp  LIKE dzga_t.dzgaownep,
#  dzgacrtid  LIKE dzga_t.dzgacrtid,
#  dzgacrtdp  LIKE dzga_t.dzgacrtdp,
#  dzgacrtdt  LIKE dzga_t.dzgacrtdt,
#  dzgamodid  LIKE dzga_t.dzgamodid,
#  dzgamoddt  LIKE dzga_t.dzgamoddt
#  );
#  #dzgb_t資料表明細
#  CREATE TEMP TABLE adzp188_dzgb_tmp
#  (
#  dzgb001    LIKE dzgb_t.dzgb001,
#  dzgb002    LIKE dzgb_t.dzgb002,
#  dzgb003    LIKE dzgb_t.dzgb003,
#  dzgb004    LIKE dzgb_t.dzgb004,
#  dzgb005    LIKE dzgb_t.dzgb005,
#  dzgb006    LIKE dzgb_t.dzgb006,
#  dzgb007    LIKE dzgb_t.dzgb007,
#  dzgb008    LIKE dzgb_t.dzgb008,
#  dzgb009    LIKE dzgb_t.dzgb009,
#  dzgb010    LIKE dzgb_t.dzgb010
#  );
#  #dzgc_t欄位明細
#  CREATE TEMP TABLE adzp188_dzgc_tmp
#  (
#  dzgc001    LIKE dzgc_t.dzgc001,
#  dzgc002    LIKE dzgc_t.dzgc002,
#  dzgc003    LIKE dzgc_t.dzgc003,
#  dzgc004    LIKE dzgc_t.dzgc004,
#  dzgc005    LIKE dzgc_t.dzgc005,
#  dzgc006    LIKE dzgc_t.dzgc006
#  );
#  #dzgd_t自訂欄位
#  CREATE TEMP TABLE adzp188_dzgd_tmp
#  (
#  dzgd001    LIKE dzgd_t.dzgd001,
#  dzgd002    LIKE dzgd_t.dzgd002,
#  dzgd003    LIKE dzgd_t.dzgd003,
#  dzgd004    LIKE dzgd_t.dzgd004,
#  dzgd005    LIKE dzgd_t.dzgd005,
#  dzgd006    LIKE dzgd_t.dzgd006
#  );
#  #dzgd_t篩選資料
#  CREATE TEMP TABLE adzp188_dzgf_tmp
#  (
#  dzgf001    LIKE dzgf_t.dzgf001,
#  dzgf002    LIKE dzgf_t.dzgf002,
#  dzgf003    LIKE dzgf_t.dzgf003,
#  dzgf004    LIKE dzgf_t.dzgf004,
#  dzgf005    LIKE dzgf_t.dzgf005,
#  dzgf006    LIKE dzgf_t.dzgf006,
#  dzgf007    LIKE dzgf_t.dzgf007,
#  dzgf008    LIKE dzgf_t.dzgf008,
#  dzgf009    LIKE dzgf_t.dzgf009,
#  dzgf010    LIKE dzgf_t.dzgf010
#  );

   CREATE TEMP TABLE adzp188_dzga_tmp
   (
   dzgastus   VARCHAR(10),   
   dzga001    VARCHAR(20),     ##報表元件代號
   dzga002    VARCHAR(15),     ##版次
   dzga003    VARCHAR(1),
   dzga004    VARCHAR(20),
   dzgaownid  VARCHAR(10),
   dzgaowndp  VARCHAR(10),
   dzgacrtid  VARCHAR(10),
   dzgacrtdp  VARCHAR(10),
   dzgacrtdt  DATE,
   dzgamodid  VARCHAR(10),
   dzgamoddt  DATE,
   dzga005    VARCHAR(40),      #140612 add 客戶名稱
   dzga006    VARCHAR(1)       #140612 add 客製標示
   );
   #dzgb_t資料表明細
   CREATE TEMP TABLE adzp188_dzgb_tmp
   (
   dzgb001    VARCHAR(20),     ##報表元件代號                      
   dzgb002    VARCHAR(1000),   ##版次#140923 elena add
   #dzgb002    VARCHAR(15),    #140923 elena mark
   dzgb003    INTEGER,
   dzgb004    VARCHAR(1),
   dzgb005    VARCHAR(15),
   dzgb006    VARCHAR(20),
   dzgb007    VARCHAR(2),
   dzgb008    VARCHAR(1),
   dzgb009    VARCHAR(15),
   dzgb010    VARCHAR(20),
   dzgb011    VARCHAR(2000),
   dzgb012    VARCHAR(60),
   dzgb013    VARCHAR(80),
   dzgb014    VARCHAR(15),
   dzgb015    VARCHAR(80),
   dzgb016    VARCHAR(20),
   dzgb017    VARCHAR(15),
   dzgb018    VARCHAR(40),          #140612 add客戶名稱  
   dzgb019    VARCHAR(1)            #140612 add客製標示
   );
   #dzgc_t欄位明細
   CREATE TEMP TABLE adzp188_dzgc_tmp
   (
   dzgc001    VARCHAR(20),  #KEY1##報表元件代號    
   dzgc002    VARCHAR(15),   #KEY##版次2
   dzgc003    INTEGER,      #KEY3
   #dzgc004    VARCHAR(20),
   dzgc004    VARCHAR(40),  ##140506 欄位放大至40
   dzgc005    VARCHAR(1),
   dzgc006    VARCHAR(1),
   dzgc007    VARCHAR(15),
   dzgc008    VARCHAR(40),          #140612 add客戶名稱
   dzgc009    VARCHAR(1)            #140612 add客製標示   
   );
   #dzgd_t自訂欄位
   CREATE TEMP TABLE adzp188_dzgd_tmp
   (
   dzgd001    VARCHAR(20),##報表元件代號
   dzgd002    VARCHAR(15),##版次
   #dzgd003    VARCHAR(20),
   dzgd003    VARCHAR(40),   ##140506 欄位放大至40
   dzgd004    VARCHAR(20),
   dzgd005    VARCHAR(80),
   dzgd006    VARCHAR(2000),
   dzgd007    VARCHAR(40),          #140612 add客戶名稱
   dzgd008    VARCHAR(1)            #140612 add客製標示   
   );
   #dzgd_t篩選資料
   CREATE TEMP TABLE adzp188_dzgf_tmp
   (
   dzgf001    VARCHAR(20),##報表元件代號
   dzgf002    VARCHAR(15),##版次
   dzgf003    SMALLINT,
   dzgf004    VARCHAR(5),
   dzgf005    VARCHAR(15),
   dzgf006    VARCHAR(20),
   dzgf007    VARCHAR(2),
   dzgf008    VARCHAR(50),
   dzgf009    VARCHAR(5),
   dzgf010    VARCHAR(1),
   dzgf011    VARCHAR(40),          #140612 add客戶名稱
   dzgf012    VARCHAR(1)            #140612 add客製標示      
   );

   #dzgb_t資料表明細_處理順序及wc
   CREATE TEMP TABLE adzp188_dzgb_tmp1
   (
   dzgb001    VARCHAR(20),##報表元件代號    
   dzgb002    VARCHAR(15),##版次
   dzgb003    INTEGER,
   dzgb004    VARCHAR(1),
   dzgb005    VARCHAR(15),
   dzgb006    VARCHAR(20),
   dzgb007    VARCHAR(2),
   dzgb008    VARCHAR(1),
   dzgb009    VARCHAR(15),
   dzgb010    VARCHAR(20),
   dzgb011    VARCHAR(2000),
   dzgb012    VARCHAR(60),
   dzgb013    VARCHAR(80),
   dzgb014    VARCHAR(15),
   dzgb015    VARCHAR(80),
   dzgb016    VARCHAR(20),
   dzgb017    VARCHAR(15),
   dzgb018    VARCHAR(40), #140612 add     客戶名稱     
   dzgb019    VARCHAR(1)  #140612 add      客製標示
   );

   #dzge_t群組明細 GR
   CREATE TEMP TABLE adzp188_dzge_tmp
   (
   dzge001    VARCHAR(20),##報表元件代號
   dzge002    VARCHAR(15),##版次
   dzge003    VARCHAR(1),
   dzge004    INTEGER,
   dzge005    VARCHAR(1),
   #dzge006    VARCHAR(20),  #140714 mark
   dzge006    VARCHAR(40),   #140714 add
   dzge007    VARCHAR(1),
   dzge008    VARCHAR(40), #140612 add     客戶名稱     
   dzge009    VARCHAR(1)   #140612 add     客製標示
   );   

   #dzge_t xg群組明細
   #151012-00003#1 調整tmp名稱縮為17字元
   CREATE TEMP TABLE adzp188_gexg_tmp      
   (
   dzge001    VARCHAR(20),##報表元件代號
   dzge002    VARCHAR(15),##版次   
   #dzge006    VARCHAR(20),       #欄位  #140714 mark
   dzge006    VARCHAR(40),       #欄位   #140714 add
   group1     VARCHAR(1),
   sort       VARCHAR(1),
   paging     VARCHAR(1),
   dzge004    INTEGER,
   dzge008    VARCHAR(40), #140612 add    客戶名稱      
   dzge009    VARCHAR(1)   #140612 add    客製標示
   );

   #彙總已選右邊樹狀明細
   CREATE TEMP TABLE adzp188_sum2_tmp
   (
    dzgb001    VARCHAR(20),##報表元件代號
    dzgb002    VARCHAR(15),##版次    
    id2        VARCHAR(20),
    pid2       VARCHAR(20),
    type2      VARCHAR(1),
    pidseq2    INTEGER,        #判斷是否為節點
    alias      VARCHAR(15),     #140606 add
    cust       VARCHAR(40),#140613 add     客戶名稱
    ide        VARCHAR(1)  #140613 add     客製標示
   );

   #資料表已選明細
   CREATE TEMP TABLE adzp188_dzgi_tmp
   (
    dzgi001    VARCHAR(20),##報表元件代號
    dzgi002    VARCHAR(15),##版次   
    dzgi003    INTEGER,
    dzgi004    VARCHAR(15),
    dzgi005    VARCHAR(40), #140612 add     客戶名稱     
    dzgi006    VARCHAR(1)   #140612 add     客製標示 
   );

   #GR排版已選右邊樹狀明細  ##140226
   CREATE TEMP TABLE adzp188_dzgh_tmp
   (
    dzgh001    VARCHAR(20),##報表元件代號
    dzgh002    VARCHAR(15),##版次    
    dzgh003    VARCHAR(20),
    dzgh004    INTEGER,
    dzgh005    VARCHAR(1),
    dzgh006    INTEGER,           #判斷是否為節點
   # dzgh007    VARCHAR(20),
    dzgh007    VARCHAR(40),       ##140506 欄位放大至40
    dzgh008    INTEGER,
    dzgh009    VARCHAR(15),
    dzgh010    VARCHAR(40),
    dzgh011    VARCHAR(40), #140612 add    客戶名稱      
    dzgh012    VARCHAR(1)   #140612 add    客製標示  
   );   
   
   #GR排版已選左邊樹狀明細
   CREATE TEMP TABLE adzp188_type2_tmp
   (
    dzgh001    VARCHAR(20),##報表元件代號
    dzgh002    VARCHAR(15),##版次    
    dzgh003    VARCHAR(20), 
    #id2        VARCHAR(20), 
    id2        VARCHAR(80),     ##140506 欄位放大至80 欄位名
    pid2       VARCHAR(20),
    idseq2     INTEGER,         #欄位順序
    pidseq2    INTEGER,         #區塊順序
    pidtype2   VARCHAR(1),      #單頭/單身
    alias2     VARCHAR(15),      #140327表格別名 
    dzgh011    VARCHAR(40),     #140613 客戶代號
    dzgh012    VARCHAR(1)       #140613 客製標示
   );  

   #參數頁籤明細  ##140311
   CREATE TEMP TABLE adzp188_dzgj_tmp
   (
    dzgj001    VARCHAR(20),##報表元件代號
    dzgj002    VARCHAR(15),##版次    
    dzgj003    INTEGER,
    dzgj004    VARCHAR(60),
    dzgj005    VARCHAR(20),
    dzgj006    VARCHAR(80),
    dzgj007    VARCHAR(40), #140612 add     客戶名稱     
    dzgj008    VARCHAR(1)   #140612 add     客製標示 

   );   

   #XG排版右側交叉表
   CREATE TEMP TABLE adzp188_xgtype_tmp
   (
    dzgh001    VARCHAR(20),##報表元件代號
    dzgh002    VARCHAR(15),##版次    
    type       VARCHAR(1),      ##類別 c、r、s
    field      VARCHAR(80),     ##欄位放大至80
    fieldseq   INTEGER,         #欄位順序
    alias      VARCHAR(15),      #140606表格別名 
    cust       VARCHAR(40), #140613 客戶代號      
    ide        VARCHAR(1)   #140613 客製標示         
   );  

END FUNCTION

################################################################################
# Descriptions...: 儲存底稿
# Memo...........: 
# Usage..........: CALL adzp188_draft_save()
# Input parameter: None
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_draft_save()
   DEFINE li_cnt             LIKE type_t.num5
   #DEFINE ls_gzgf_max        LIKE type_t.num5           ##140512 mark
   DEFINE ls_gzgf_max        LIKE gzgf_t.gzgf000         ##140512 add
   DEFINE l_gzgf_cnt         LIKE type_t.num5
   DEFINE lc_type2           DYNAMIC ARRAY OF RECORD 
            dzgh001          LIKE dzgh_t.dzgh001,
            dzgh002          LIKE dzgh_t.dzgh002,    
            dzgh003          LIKE dzgh_t.dzgh003, 
            id2              LIKE type_t.chr20,  
            pid2             LIKE type_t.chr20,
            idseq2           LIKE type_t.num5,         #欄位順序
            pidseq2          LIKE type_t.num5,         #區塊順序
            pidtype2         LIKE type_t.chr1,         #單頭/單身 
            alias2           LIKE dzgh_t.dzgh009         #表格別名  
            END RECORD 
   DEFINE l_seq              LIKE type_t.num5
   DEFINE l_gzgf006          LIKE gzgf_t.gzgf005
   DEFINE l_gzgf003          LIKE gzgf_t.gzgf003        #140630add
   DEFINE l_dzgc             type_g_dzgc_d                #141020 add
   ##150812-00006#1 add -(s)
   DEFINE l_gzgf020          LIKE gzgf_t.gzgf020,  
          l_gzgf021          LIKE gzgf_t.gzgf021, 
          l_gzgf022          LIKE gzgf_t.gzgf022,
          l_gzgf023          LIKE gzgf_t.gzgf023  
   ##150812-00006#1 add -(e)
   DEFINE l_dzga001          LIKE dzga_t.dzga001       #161215-00029#1   add   

   
   #先處理主檔資料
        ##141020 add -(s)
         #SELECT count(*) INTO li_cnt FROM adzp188_dzgc_tmp WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                                          #AND dzgc009 = g_code_ide  
#
        #LET g_sql = "  SELECT dzgc003,dzgc004,dzgc005,dzgc006,dzgc007 FROM adzp188_dzgc_tmp ",
                    #"  WHERE dzgc001 = '",  g_dzga_m.dzga001,"'", " AND dzgc002 ='",gs_ver,"'",
                    #"    AND dzgc009 ='",g_code_ide,"'",                    
                    #"   ORDER BY dzgc003 " 
         #PREPARE dzgc_pre FROM g_sql
         #DECLARE dzgc_cs CURSOR FOR dzgc_pre
         #LET li_cnt = 1
         #FOREACH dzgc_cs INTO l_dzgc.*
            #DISPLAY li_cnt
            #DISPLAY l_dzgc.*
            #LET li_cnt = li_cnt + 1
         #END FOREACH

         ##141020 add -(e)
   
   #161215-00029#1   add -(s)
   LET l_dzga001 = ""
   IF g_stus = "old_save" THEN   #儲存新一個報表元件的代號
      LET l_dzga001 = g_dzga_m.dzga001
      LET g_dzga_m.dzga001 = g_dzga001_t
   END IF    
   #161215-00029#1   add -(e)
   SELECT COUNT(*) INTO li_cnt FROM dzga_t WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = g_dzga_m.dzga002
                                             #AND dzga005 = g_cust AND dzga006 = g_code_ide #140613 add
                                             AND dzga006 = g_code_ide   ##141013 add                                               
                                            
   IF li_cnt > 0 THEN
      LET g_dzga_m.dzgamodid = g_user
      LET g_dzga_m.dzgamoddt = cl_get_current()
      UPDATE dzga_t SET dzga003 = g_dzga_m.dzga003, dzga004 = g_dzga_m.dzga004,                        
                        dzgamodid = g_dzga_m.dzgamodid, dzgamoddt = g_dzga_m.dzgamoddt
       WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = g_dzga_m.dzga002
         #AND dzga005 = g_cust AND dzga006 = g_code_ide #140613 add   ##141013 mark 
         AND dzga006 = g_code_ide                                     ##141013 add  
      #160921-00012#1 add -(s)
      #更新gzde_t
      UPDATE gzde_t 
         SET gzde006 = g_dzga_m.gzde006
       WHERE gzde001 = g_dzga_m.dzga001 AND gzde008 = g_code_ide

      #160921-00012#1 add -(e)
   ELSE
      LET g_dzga_m.dzgaownid = g_user
      LET g_dzga_m.dzgaowndp = g_dept
      LET g_dzga_m.dzgacrtid = g_user
      LET g_dzga_m.dzgacrtdp = g_dept
      LET g_dzga_m.dzgacrtdt = cl_get_current()
      LET g_dzga_m.dzgastus = "Y"
      INSERT INTO dzga_t(dzgastus, dzga001, dzga002, dzga003, dzga004, dzgaownid, dzgaowndp, dzgacrtid, dzgacrtdp, dzgacrtdt,dzga005,dzga006)#140626 add ,dzga005,dzga006  
                  VALUES(g_dzga_m.dzgastus, g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzga_m.dzga003, g_dzga_m.dzga004,
                         g_dzga_m.dzgaownid, g_dzga_m.dzgaowndp, g_dzga_m.dzgacrtid, g_dzga_m.dzgacrtdp, g_dzga_m.dzgacrtdt,
                         g_cust,g_code_ide)#140613 add        
                         
                     
   END IF
   IF SQLCA.sqlcode THEN
   ELSE
      ##141013 mark -(s)
      #DELETE FROM dzgb_t WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                           #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add
      #DELETE FROM dzgc_t WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                           #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add
      #DELETE FROM dzgd_t WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                           #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add
      #DELETE FROM dzgf_t WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                           #AND dzgf011 = g_cust AND dzgf012 = g_code_ide #140613 add
      #DELETE FROM dzgj_t WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
                           #AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add    
      #DELETE FROM dzgi_t WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                           #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add
      #INSERT INTO dzgb_t
         #SELECT * FROM adzp188_dzgb_tmp WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                                          #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add                                
      #INSERT INTO dzgc_t
         #SELECT * FROM adzp188_dzgc_tmp WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                                          #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add                                          
      #INSERT INTO dzgd_t
         #SELECT * FROM adzp188_dzgd_tmp WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                                          #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add
      #INSERT INTO dzgf_t
         #SELECT * FROM adzp188_dzgf_tmp WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                                          #AND dzgf011 = g_cust AND dzgf012 = g_code_ide #140613 add
      #INSERT INTO dzgi_t
         #SELECT * FROM adzp188_dzgi_tmp WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                                          #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add    
      #INSERT INTO dzgj_t
         #SELECT * FROM adzp188_dzgj_tmp WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002 
                                          #AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add                            
      ##141013 mark -(e)
      ##141013 add -(s)
      DELETE FROM dzgb_t WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                           AND dzgb019 = g_code_ide #140613 add
      DELETE FROM dzgc_t WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                           AND dzgc009 = g_code_ide #140613 add
      DELETE FROM dzgd_t WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                           AND dzgd008 = g_code_ide #140613 add
      DELETE FROM dzgf_t WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                           AND dzgf012 = g_code_ide #140613 add
      DELETE FROM dzgj_t WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
                           AND dzgj008 = g_code_ide #140613 add    
      DELETE FROM dzgi_t WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                           AND dzgi006 = g_code_ide #140613 add


      INSERT INTO dzgb_t
         SELECT * FROM adzp188_dzgb_tmp WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                                          AND  dzgb019 = g_code_ide   
      #160921-00012#1 add -(s)
      #只要是走x02樣板，select 與print欄位要一致
      IF g_dzga_m.dzga003 ='2' AND g_dzga_m.gzde006='2' THEN
         UPDATE adzp188_dzgc_tmp
            SET dzgc005 = '1'
          WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                AND dzgc009 = g_code_ide          
      END IF 
      #160921-00012#1 add -(e)
             
      INSERT INTO dzgc_t
         SELECT * FROM adzp188_dzgc_tmp WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                                          AND dzgc009 = g_code_ide                                          
      INSERT INTO dzgd_t
         SELECT * FROM adzp188_dzgd_tmp WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                                          AND  dzgd008 = g_code_ide 
      INSERT INTO dzgf_t
         SELECT * FROM adzp188_dzgf_tmp WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                                          AND dzgf012 = g_code_ide 
      INSERT INTO dzgi_t
         SELECT * FROM adzp188_dzgi_tmp WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                                          AND dzgi006 = g_code_ide  
      INSERT INTO dzgj_t
         SELECT * FROM adzp188_dzgj_tmp WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002 
                                          AND dzgj008 = g_code_ide       
      ##141013 add -(e)
      IF g_dzga_m.dzga003 ='1' THEN  #只有gr才會存入dzge  #140114

             DELETE FROM dzge_t WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002   #140114
                                  #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add  #141013 mark
                                  AND dzge009 = g_code_ide                                     #141013 add
             
             INSERT INTO dzge_t
                    SELECT * FROM adzp188_dzge_tmp WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 #140114
                                                     #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add   #141013 mark
                                                     AND dzge009 = g_code_ide  #140613 add    #141013 add 
                
         ##GR樣板設定明細
         ##150617-00018  add -(s)
         DELETE FROM dzgh_t WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002 AND dzgh003 = g_dzga_m.dzga001
                        AND  dzgh011 = g_code_ide    
         ##150617-00018  add -(e)               
         LET l_seq = 1
         CALL lc_type2.clear()
         LET g_sql = " SELECT * FROM adzp188_type2_tmp ",
                     #"  WHERE dzgh001 ='",g_dzga_m.dzga001,"' AND dzgh002 ='", g_dzga_m.dzga002,"'",  #140923 elena mark
                     "  WHERE dzgh001 ='",g_dzga_m.dzga001,"' AND dzgh002 ='", gs_ver,"'",             #140923 elena add
                     "    AND dzgh003 ='",g_dzga_m.dzga001,"' AND pid2 IS NOT NULL",
                     #"    AND dzgh011 ='",g_cust,"' AND dzgh012 ='",g_code_ide,"'",   #140613 add  #141017 mark
                     "    AND dzgh012 ='",g_code_ide,"'",   #141017 add
                     "  ORDER BY pidtype2,pidseq2,idseq2 "
         PREPARE adzp188_insert_dzgh_pre FROM g_sql
         DECLARE adzp188_insert_dzgh_cs CURSOR FOR adzp188_insert_dzgh_pre
         FOREACH adzp188_insert_dzgh_cs INTO lc_type2[l_seq].*
             IF NOT cl_null(lc_type2[l_seq].pid2) THEN
                INSERT INTO dzgh_t 
                       VALUES ( g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzga_m.dzga001,l_seq,
                                lc_type2[l_seq].pidtype2,lc_type2[l_seq].pidseq2,lc_type2[l_seq].id2,
                                lc_type2[l_seq].idseq2,lc_type2[l_seq].alias2,'', #140327 add lc_type2[l_seq].alias2,'' 
                                g_cust,g_code_ide)  #140613 add
             END IF 
             LET l_seq = l_seq + 1 
         END FOREACH 

         ##存dzgg_t樣板單頭單(GR才存)
         DELETE FROM dzgg_t WHERE dzgg001 = g_dzga_m.dzga001 AND dzgg002 = g_dzga_m.dzga002 AND dzgg003 = g_dzga_m.dzga001
                              #AND dzgg016 = g_cust AND dzgg017 = g_code_ide #140613 add    ##141013 mark
                              AND dzgg017 = g_code_ide #141013 add     
         LET g_dzgg_d.dzgg004 = g_gr_temp_set.c_masterzone
         LET g_dzgg_d.dzgg005 = g_gr_temp_set.c_detailrow
         LET g_dzgg_d.dzgg006 = g_gr_temp_set.c_signoff
         LET g_dzgg_d.dzgg007 = g_gr_temp_set.c_memosubrep
         IF g_paper_set.r_format ="1" THEN  #標準
            CASE g_paper_set.c_std  ##以後若有報表紙張檔，要置換
              WHEN "1" 
                   LET g_dzgg_d.dzgg008 = "A4"
              WHEN "2" 
                   LET g_dzgg_d.dzgg008 = "A3"                   
            END CASE 
         ELSE ##自定義紙張
              LET g_dzgg_d.dzgg008 = g_paper_set.custom
         END IF 
         ##紙張方向
         IF g_paper_set.r_direction ="1" THEN 
            LET g_dzgg_d.dzgg009 = "P"
         ELSE 
            LET g_dzgg_d.dzgg009 = "L"
         END IF 
         ##邊界
         LET g_dzgg_d.dzgg010 = g_paper_set.top
         LET g_dzgg_d.dzgg011 = g_paper_set.botton
         LET g_dzgg_d.dzgg012 = g_paper_set.left
         LET g_dzgg_d.dzgg013 = g_paper_set.right
         LET g_dzgg_d.dzgg014 = g_paper_set.r_direction         
         LET g_dzgg_d.dzgg015 = g_gr_temp_set.c_detailtable   ##單身格化
         INSERT INTO dzgg_t
                VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,g_dzgg_d.dzgg004,g_dzgg_d.dzgg005,
                        g_dzgg_d.dzgg006,g_dzgg_d.dzgg007,g_dzgg_d.dzgg008,g_dzgg_d.dzgg009,g_dzgg_d.dzgg010,
                        g_dzgg_d.dzgg011,g_dzgg_d.dzgg012,g_dzgg_d.dzgg013,g_dzgg_d.dzgg014,g_dzgg_d.dzgg015, ##單身格化dzgg015
                        g_cust,g_code_ide)  #140613 add
         
         
      ELSE   #XG
        IF g_stus ="comp_save" THEN  #161215-00029#1 add 產生報長元件時，才存至gzgf、gzgg
          ##XtraGrid報表樣板主檔    
          LET g_dzga_m.dzgastus = "Y"
 
          ##140523 -(s)  寫判斷存XG的gzgf006類型(未完成)
          #IF g_temp_set.r_detail = "1" THEN   ##150226 mark
          IF g_dzga_m.dzga004 = "2" THEN       ##150226 add
             ##140521 add -(s) 
             #LET g_dzga_m.dzga004 ="2"        ##150226 mark
             IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="Y" THEN 
                LET l_gzgf006 ="4" 
             ELSE 
                IF g_temp_set.c_subrep ="Y" AND g_temp_set.c_master ="N" THEN
                   LET l_gzgf006 ="3" 
                ELSE 
                   IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="Y" THEN
                      LET l_gzgf006 = "2"
                   ELSE 
                      IF g_temp_set.c_subrep ="N" AND g_temp_set.c_master ="N" THEN
                         LET l_gzgf006 = "1"
                      ##150330 add -(s)
                      ELSE
                         IF g_temp_set.c_chart ="Y" THEN
                            LET l_gzgf006 = "7"
                         END IF
                      ##150330 add -(e)
                      END IF 
                   END IF 
                END IF 
             END IF 

             
          END IF 
          ###150226 mark -(s)
          #IF g_temp_set.r_povit = "1" THEN    
              #LET g_dzga_m.dzga004 ="3"
          ###150226 mark -(e)
          IF g_dzga_m.dzga004 ="3"   THEN     #150226 add            
             LET l_gzgf006 ="5"
          END IF
          ##150226 mark -(s)
          #IF g_temp_set.r_tree = "1" THEN   
             #LET g_dzga_m.dzga004 ="6"
          ##150226 mark -(e)
          ##150330 mark -(s)
          #IF g_dzga_m.dzga004 ="6" THEN   
             #LET l_gzgf006 ="6"
          #END IF 
          ##150330 mark -(e)
          ##140523 -(s)
          #第一次存是存user:default，權限:default
        
          SELECT COUNT (*) INTO l_gzgf_cnt FROM gzgf_t 
          WHERE gzgfstus = g_dzga_m.dzgastus  
            #AND gzgfent = g_enterprise  #140612 mark ent
            AND gzgf001 = g_dzga_m.dzga001
            AND gzgf004 = 'default'
            AND gzgf005 = 'default'
            #AND gzgf003 = g_code_ide           #140612 add ##140617mark
            AND gzgf003 = g_gzgf003             #140617 add 
          IF l_gzgf_cnt = 0 THEN 
             #SELECT MAX(gzgf000)+1 INTO ls_gzgf_max FROM gzgf_t    ##140512mark
              ##140512add -(s)
              CALL security.RandomGenerator.CreateUUIDString() RETURNING ls_gzgf_max
              LET g_gzgf000 = ls_gzgf_max
              #LET l_gzgf003 = "N"   #140630 add  #141002 cynthia mark
              LET l_gzgf003 = "s"   #140630 add   #141002 cynthia add
              #IF g_code_ide ="c" THEN LET l_gzgf003="Y" END IF    #140630 add  #141002 cynthia mark
              IF g_code_ide ="c" THEN LET l_gzgf003="c" END IF    #140630 add    #141002 cynthia add
              ##140512add -(e)                                                                                          預設樣板  簽核
             ##150812-00006#1  add  -(s)
             LET l_gzgf020 ='N'
             LET l_gzgf021 ='N'
             LET l_gzgf022 ='N'
             LET l_gzgf023 ='N'             
             IF l_gzgf006 ="5" THEN 
                LET l_gzgf020 ='Y'
                LET l_gzgf021 ='Y'
                LET l_gzgf022 ='Y'
                LET l_gzgf023 ='Y'
             END IF
             ##150812-00006#1  add  -(s)
             INSERT INTO gzgf_t(gzgfstus, gzgf000, gzgf001, gzgf002, gzgf003, gzgf004, gzgf005,gzgf006,gzgf007,gzgf008,gzgf009,  ##140612 mark , gzgfent
                         gzgf010,gzgf011,gzgf012,                                                    ##140522逾期時間，中越樣板
                         gzgf020,gzgf021,gzgf022,gzgf023,                                             ##150812-00006#1  add
                         gzgfownid, gzgfowndp, gzgfcrtid, gzgfcrtdp, gzgfcrtdt)
                    #VALUES(g_dzga_m.dzgastus, ls_gzgf_max , g_dzga_m.dzga001, g_dzga_m.dzga001, 'N', 'default','default',l_gzgf006,'1','Y','N',##140522   #140612 mark , g_enterprise #140613 mark
                    #VALUES(g_dzga_m.dzgastus, ls_gzgf_max , g_dzga_m.dzga001, g_dzga_m.dzga001, g_code_ide, 'default','default',l_gzgf006,'1','Y','N',##140613 g_code_ide  #140630 mark
                    VALUES(g_dzga_m.dzgastus, ls_gzgf_max , g_dzga_m.dzga001, g_dzga_m.dzga001, l_gzgf003, 'default','default',l_gzgf006,'3','Y','N',##140630 add
                          '',20,'N',
                          l_gzgf020,l_gzgf021,l_gzgf022,l_gzgf023,                                   ##150812-00006#1  add
                          g_dzga_m.dzgaownid, g_dzga_m.dzgaowndp, g_dzga_m.dzgacrtid, g_dzga_m.dzgacrtdp, g_dzga_m.dzgacrtdt)
          ELSE 
             ##140521 -(s) 抓已存在gzgf000
              SELECT gzgf000 INTO ls_gzgf_max FROM gzgf_t 
              WHERE gzgfstus = g_dzga_m.dzgastus  
                #AND gzgfent = g_enterprise   #140612 mark ent
                AND gzgf001 = g_dzga_m.dzga001
                AND gzgf004 = 'default'
                AND gzgf005 = 'default'
                #AND gzgf003 = g_code_ide          #140612 add       #140617 mark 
                AND gzgf003 = g_gzgf003            #140617 add               
              ##140521 -(s) 抓已存在gzgf000 
               LET g_gzgf000 = ls_gzgf_max
             ##150112 mark-(s)  
             ##140521 修改 -(s)
              ##SELECT gzgf000 INTO ls_gzgf_max FROM gzgf_t 
              #UPDATE gzgf_t SET gzgf006 = l_gzgf006
              #WHERE gzgfstus = g_dzga_m.dzgastus  
                ##AND gzgfent = g_enterprise  #140612 mark ent
                #AND gzgf001 = g_dzga_m.dzga001
                #AND gzgf004 = 'default'
                #AND gzgf005 = 'default'
                ##AND gzgf003 = g_code_ide          #140612 add   #140617 mark
                #AND gzgf003 = g_gzgf003           #140617 add  
             ##140521 修改 -(e)
             ##150115 mark -(e)
          END IF  

  
          
          ##XtraGrid報表樣板明細檔
          CALL sadzp188_ins_gzgg_pre(g_dzga_m.dzga001,g_dzga_m.dzga002,ls_gzgf_max,g_cust,g_code_ide)
          #存入群組、彙總資訊
          #CALL adzp188_maintain_gzgggzgf(ls_gzgf_max,g_xg_groupsel)  #140606 mark
        END IF  #161215-00029#1 add 產生報長元件時，才存至gzgf、gzgg 
      END IF 
   
   END IF
   #161215-00029#1   add -(s)
   IF g_stus = "old_save" THEN   #儲存新一個報表元件的袋號
      LET g_dzga_m.dzga001 = l_dzga001
   END IF    
   #161215-00029#1   add -(e)
END FUNCTION

################################################################################
# Descriptions...: 以目前已開立的資料表, 動態產生資料表下拉選單
# Memo...........: 
# Usage..........: CALL adzp188_set_table_comboitems("formonly.dzgd004_1", TRUE) RETURNING li_str
# Input parameter: ps_fieldname   下拉選單欄位
# ...............: pi_showtext    是否顯示多語言名稱
# Return code....: ls_default     第一個選項(用來讓畫面上直接可顯示值)
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_table_comboitems(ps_fieldname, pi_showtext)
   DEFINE ps_fieldname   STRING
   DEFINE pi_showtext    LIKE type_t.num5
   DEFINE lc_dzea001     LIKE dzea_t.dzea001
   DEFINE lc_dzeal003    LIKE dzeal_t.dzeal003
   DEFINE ls_values      STRING
   DEFINE ls_descs       STRING
   DEFINE ls_default     STRING

   #全部出來數量可觀
   LET g_sql = "SELECT dzea001, dzeal003 FROM dzea_t",
               "  LEFT OUTER JOIN dzeal_t ON dzeal001 = dzea001 AND dzeal002 = '",g_lang,"'",
               " ORDER BY dzea001"
   PREPARE table_comboitems_pre FROM g_sql
   DECLARE table_comboitems_curs CURSOR FOR table_comboitems_pre
    
   FOREACH table_comboitems_curs INTO lc_dzea001, lc_dzeal003
      LET ls_values = ls_values, lc_dzea001, ","
      IF pi_showtext THEN
         LET ls_descs = ls_descs, lc_dzea001, " : ", lc_dzeal003, ","
      ELSE
         LET ls_descs = ls_descs, lc_dzea001, ","
      END IF
      IF cl_null(ls_default) THEN
         LET ls_default = lc_dzea001
      END IF
   END FOREACH
     
   LET ls_values = ls_values.subString(1,ls_values.getLength()-1)
   LET ls_descs = ls_descs.subString(1,ls_descs.getLength()-1)

   CALL cl_set_combo_items(ps_fieldname, ls_values, ls_descs)

   RETURN ls_default

END FUNCTION

################################################################################
# Descriptions...: 以傳入的資料表, 動態產生欄位下拉選單
# Memo...........: 
# Usage..........: CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, TRUE)
# Input parameter: ps_fieldname   下拉選單欄位
# ...............: pc_tabname     指定資料表
# ...............: pi_showtext    是否顯示多語言名稱
# Return code....: ls_default     第一個選項(用來讓畫面上直接可顯示值)
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_field_comboitems(ps_fieldname, pc_tabname, pi_showtext)
   DEFINE ps_fieldname   STRING
   DEFINE pc_tabname     LIKE dzea_t.dzea001
   DEFINE pi_showtext    LIKE type_t.num5
   DEFINE lc_dzeb002     LIKE dzeb_t.dzeb002
   DEFINE lc_dzebl003    LIKE dzebl_t.dzebl003
   DEFINE ls_values      STRING
   DEFINE ls_descs       STRING
   DEFINE ls_default     STRING

   LET g_sql = "SELECT dzeb002, dzebl003 FROM dzeb_t",
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzeb002 AND dzebl002 = '",g_lang,"'",
               " WHERE dzeb001 = '",pc_tabname,"'",
               " ORDER BY dzeb002"
   PREPARE field_comboitems_pre FROM g_sql
   DECLARE field_comboitems_curs CURSOR FOR field_comboitems_pre

   FOREACH field_comboitems_curs INTO lc_dzeb002, lc_dzebl003
      LET ls_values = ls_values, lc_dzeb002, ","
      IF pi_showtext THEN
         LET ls_descs = ls_descs, lc_dzeb002, " : ", lc_dzebl003, ","
      ELSE
         LET ls_descs = ls_descs, lc_dzeb002, ","
      END IF
      IF cl_null(ls_default) THEN
         LET ls_default = lc_dzeb002
      END IF
   END FOREACH
   LET ls_values = ls_values.subString(1,ls_values.getLength()-1)
   LET ls_descs = ls_descs.subString(1,ls_descs.getLength()-1)

   CALL cl_set_combo_items(ps_fieldname, ls_values, ls_descs)

   RETURN ls_default

END FUNCTION

################################################################################
# Descriptions...: 以資料表頁簽所選的資料表, 動態產生資料表下拉選單
# Memo...........: 
# Usage..........: CALL adzp188_set_tablesel_comboitems("dzgb_t.dzgb005", TRUE)
# Input parameter: ps_fieldname   下拉選單欄位
# ...............: pi_showtext    是否顯示多語言名稱
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_tablesel_comboitems(ps_fieldname, pi_showtext)
   DEFINE ps_fieldname   STRING
   DEFINE pi_showtext    LIKE type_t.num5
   DEFINE ls_value       STRING
   DEFINE ls_descs       STRING
   DEFINE li_i           LIKE type_t.num5

   FOR li_i = 1 TO g_tablesel.getLength()
       LET ls_value = ls_value, g_tablesel[li_i].id,","
       IF pi_showtext THEN
         ##140520 先不顯示TABLE名-(S)
          #LET ls_descs = ls_descs, g_tablesel[li_i].id," : ",g_tablesel[li_i].name,","
       #ELSE
       ##140520 先不顯示TABLE名-(E)
          LET ls_descs = ls_descs, g_tablesel[li_i].id,","
       END IF
   END FOR
   LET ls_value = ls_value.subString(1,ls_value.getLength()-1)
   LET ls_descs = ls_descs.subString(1,ls_descs.getLength()-1)

   CALL cl_set_combo_items(ps_fieldname, ls_value, ls_descs)

END FUNCTION

################################################################################
# Descriptions...: 動態切換調整順序功能鍵
# Memo...........: 
# Usage..........: CALL adzp188_set_seqaction_active("s_join", "up_joinseq", "down_joinseq")
# Input parameter: ps_array        要檢測的array名稱
# ...............: ps_upaction     往上功能鍵id
# ...............: ps_downaction   往下功能鍵id
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_seqaction_active(ps_array, ps_upaction, ps_downaction)
   DEFINE ps_array        STRING
   DEFINE ps_upaction     STRING
   DEFINE ps_downaction   STRING
   DEFINE li_idx          LIKE type_t.num5
   DEFINE l_max_idx       LIKE type_t.num5

   IF gdig_curr.getArrayLength(ps_array) = 0 THEN
      CALL gdig_curr.setActionActive(ps_upaction, FALSE)
      CALL gdig_curr.setActionActive(ps_downaction, FALSE)
   ELSE
      CALL gdig_curr.setActionActive(ps_upaction, TRUE)
      CALL gdig_curr.setActionActive(ps_downaction, TRUE)

      IF gdig_curr.getCurrentRow(ps_array) = 1 THEN
         CALL gdig_curr.setActionActive(ps_upaction, FALSE)
      END IF
      IF gdig_curr.getCurrentRow(ps_array) = gdig_curr.getArrayLength(ps_array) THEN
         CALL gdig_curr.setActionActive(ps_downaction, FALSE)
      END IF
      LET li_idx = gdig_curr.getCurrentRow(ps_array)      
      CASE ps_array
        WHEN "s_typelist2" 
             IF g_typelist2[li_idx].typeseq2 = 1 THEN 
                CALL gdig_curr.setActionActive(ps_upaction, FALSE)
             END IF 
             SELECT MAX(idseq2) INTO l_max_idx FROM adzp188_type2_tmp
              WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
                AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 = g_typelist2[li_idx].typepidtype2
                AND pidseq2 = g_typelist2[li_idx].typepidseq2 
             IF g_typelist2[li_idx].typeseq2 = l_max_idx THEN   ##140314 janet
                CALL gdig_curr.setActionActive(ps_downaction, FALSE)
             END IF   
        WHEN "s_filter"
             IF g_filter[li_idx].dzgf003 = 99 THEN
                CALL gdig_curr.setActionActive(ps_upaction, FALSE) 
                CALL gdig_curr.setActionActive(ps_downaction, FALSE)
             END IF 
      END CASE 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 依照有無資料動態切換指定功能鍵
# Memo...........: 
# Usage..........: CALL adzp188_set_baseaction_active("s_join")
# Input parameter: ps_array        要檢測的array名稱
# ...............: ps_action       要開關的功能鍵
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_action_active_by_datasize(ps_array, ps_action)
   DEFINE ps_array        STRING
   DEFINE ps_action       STRING

   IF gdig_curr.getArrayLength(ps_array) <= 0 THEN
      CALL gdig_curr.setActionActive(ps_action, FALSE)
   ELSE
      CALL gdig_curr.setActionActive(ps_action, TRUE)
   END IF

END FUNCTION



################################################################################
# Descriptions...: 開啟/關閉欄位輸入
# Memo...........: 
# Usage..........: CALL adzp188_set_field_noentry("dzgf007")
# Input parameter: ps_fieldname   被控管的欄位
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_set_field_noentry(ps_fieldname)
   DEFINE ps_fieldname   STRING
   DEFINE li_noentry     LIKE type_t.num5

   
   CALL cl_set_comp_entry(ps_fieldname, TRUE)

   CASE ps_fieldname
      WHEN "dzgf008"
         IF g_dzgf_d.dzgf007 = "13" OR g_dzgf_d.dzgf007 = "14" THEN
            LET li_noentry = TRUE
         END IF
   END CASE

   IF li_noentry THEN
      CALL cl_set_comp_entry(ps_fieldname, FALSE)
   END IF

END FUNCTION


################################################################################
# Descriptions...: 開啟/關閉欄位顯示輸入
# Memo...........: 
# Usage..........: CALL adzp188_set_field_hide("formonly.len")
# Input parameter: 
# Return code....: None
# Date & Author..: 2014/02/13
# Modify.........:
################################################################################
FUNCTION adzp188_set_field_hide()
   
   IF g_paper_set.r_format ="1" THEN 
      CALL gfrm_curr.setElementHidden("formonly.c_std",0)
      CALL gfrm_curr.setElementHidden("formonly.custom",1)
   ELSE 
      CALL gfrm_curr.setElementHidden("formonly.c_std",1)
      CALL gfrm_curr.setElementHidden("formonly.custom",0)      
   END IF   
   

END FUNCTION

################################################################################
# Descriptions...: 產生報表元件
# Memo...........: 
# Usage..........: CALL adzp188_gen_comp()
# Input parameter: 
# Return code....: None
# Date & Author..: 2013/12/20
# Modify.........:
################################################################################
FUNCTION adzp188_comp_gen(p_dzga001,p_dzga002,p_dzga003,p_cmd)
   DEFINE p_dzga001    LIKE dzga_t.dzga001
   DEFINE p_dzga002    LIKE dzga_t.dzga002
   DEFINE p_dzga003    LIKE dzga_t.dzga003
   DEFINE p_type       STRING 
   DEFINE p_cmd        STRING 
   DEFINE lc_sucess    LIKE type_t.num5
   DEFINE ls_mod       STRING
   DEFINE ls_cmd       STRING  
   DEFINE l_chk        LIKE type_t.num5
   DEFINE l_msg        STRING 
   DEFINE l_path       STRING    
   DEFINE lb_result    BOOLEAN             ##160330-00019#3 add


   ##140312 不傳p_type，因為要在gen tab裡面自己判斷
   #CALL sadzp188_tab_gen(p_dzga001,p_dzga002,p_type) RETURNING ls_sucess
   CALL sadzp188_tab_gen(p_dzga001,p_dzga002,g_code_ide) RETURNING lc_sucess  #140613 add g_code_ide客製標示

    #140612 mark -(s)
   #LET ls_mod = p_dzga001    
   #LET ls_mod = ls_mod.subString(1,3)
   #140612 mark -(e)
   ##r.c3 程式元件代號 是否覆蓋add-point(y/n) 版次 編譯否(0:Y/1:N), 不編譯因為rdd會編譯,#區域 (識別標示)
                     ##140718能覆蓋add-point，因為需要在設計器存資料，所以修改都是要由設計器當入口，而不是在code_editor修改
   IF p_dzga003 ='1' THEN 
      #LET ls_cmd = "r.c3 ",p_dzga001," 'Y' 1 1 "  ##140530 第一區還未加s  #140616 mark
      #LET ls_cmd = "r.c3 ",p_dzga001, ' ','Y',' ',g_ver,' ','1',' ', g_code_ide    ##140616   #140617 mark     
      #LET ls_cmd = "r.c3 ",p_dzga001," 'Y' 1 1 ",FGL_GETENV("DGENV") 
      LET ls_cmd = "r.c3 ",p_dzga001, ' ','n',' ',g_ver,' ','1',' ', g_code_ide    ##140617 add 
   ELSE  ##XG要編譯
      #LET ls_cmd = "r.c3 ",p_dzga001," 'Y' 1 0 "  ##140530 第一區還未加s
      #LET ls_cmd = "r.c3 ",p_dzga001," 'Y' 1 0 ",FGL_GETENV("DGENV")
      #LET ls_cmd = "r.c3 ",p_dzga001,' ', 'Y',' ',g_ver,' ','0',' ', g_code_ide    ##140616 #140617 mark
      LET ls_cmd = "r.c3 ",p_dzga001,' ', 'n',' ',g_ver,' ','0',' ', g_code_ide    ##140617 add 
   END IF 
   DISPLAY "adzp188 ls_cmd:",ls_cmd
   CALL cl_cmdrun_openpipe("r.c3",ls_cmd, FALSE) RETURNING l_chk,l_msg
   
   ##產生rdd
   ##先切換到該模組目錄
   IF p_dzga003 ='1' THEN  ##GR才產生rdd
       LET ls_mod = g_module
       LET ls_mod = ls_mod.toUpperCase()
       LET l_path = os.Path.join(FGL_GETENV(ls_mod), "4gl")
       LET ls_cmd = "r.c ",p_dzga001," rdd"   
       LET ls_cmd = "cd ", l_path, "; ", ls_cmd
       CALL cl_cmdrun_openpipe("r.c",ls_cmd, FALSE) RETURNING l_chk,l_msg
   ELSE 
      #存入群組、彙總資訊 140606 -(s)
      CALL adzp188_maintain_gzgggzgf(g_gzgf000,g_xg_groupsel) 
      CALL adzp188_insert_gzgg_data(g_gzgf000)  ##140612 在此存入gzgg_t資料
       #存入群組、彙總資訊 140606 -(e)
      ##160330-00019#3 查詢報表若有多樣板還要呼叫sadzp188_1做merge -(s)
      CALL sadzp188_1(p_dzga001) RETURNING lb_result,l_msg
      LET l_msg = "ERROR:程式",p_dzga001,"呼叫sadzp188_1過程出現錯誤:",l_msg,ASCII 10
      ##160330-00019#3  -(e)
   END IF 

   ##gen 4rp
   #IF p_dzga003 ='1' THEN 
      #LET p_type ="g01"
      ##IF p_cmd <>"u" THEN    ##第一次或重新參考程式才gen4rp  #140318 先開放給月華測
         #
         #CALL sadzp188_gen4rp(p_dzga001, p_dzga002,g_gzza001)
         ##CALL sadzp188_gen4rp(p_dzga001, p_dzga002)
      ##END IF 
   #ELSE 
      #LET p_type= "x01"
   #END IF  
   
   

   
END FUNCTION


################################################################################
# Descriptions...: 撈出參考程式的相關table
# Memo...........: 
# Usage..........: CALL adzp188_ref_prog_data(p_gzza001)
# Input parameter: p_gzza001 參考程式
# Return code....: li_cmd   修改
# Date & Author..: 2013/12/25
# Modify.........:
################################################################################
FUNCTION adzp188_ref_prog_data(p_gzza001)
   DEFINE p_gzza001    LIKE gzza_t.gzza001
   DEFINE l_dzaf003    LIKE dzaa_t.dzaa002    #規格版次
   DEFINE l_dzaa004    LIKE dzaa_t.dzaa004
   DEFINE l_dzaa006    LIKE dzaa_t.dzaa006
   DEFINE l_dzaa003    LIKE dzaa_t.dzaa003
   DEFINE ls_i         LIKE type_t.num5
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE ls_table   DYNAMIC ARRAY OF RECORD 
          dzag002      LIKE dzag_t.dzag002,
          dzag004      LIKE dzag_t.dzag004,
          dzag005      LIKE dzag_t.dzag005           
          END RECORD
   DEFINE ls_dzac002 DYNAMIC ARRAY OF VARCHAR(20) 
   DEFINE ls_dzaa    DYNAMIC ARRAY OF RECORD 
          dzaa003      LIKE dzaa_t.dzaa003,
          dzaa004      LIKE dzaa_t.dzaa004,
          dzaa006      LIKE dzaa_t.dzaa006
          END RECORD 
   DEFINE ls_dzed004   STRING 
   DEFINE ls_dzed006   STRING 
   DEFINE ls_err_msg   STRING 
   DEFINE li_cmd       STRING
   DEFINE ls_wc        LIKE dzgb_t.dzgb011
   DEFINE l_ent_str    STRING 
   DEFINE l_site_str   STRING 
   DEFINE l_table_str  STRING 
   DEFINE ls_dzgb_seq  LIKE dzgb_t.dzgb003
   DEFINE ls_dzgc_seq  LIKE dzgc_t.dzgc003
   DEFINE ls_dzai    DYNAMIC ARRAY OF RECORD 
          dzai005      LIKE dzai_t.dzai005,
          dzai007      LIKE dzai_t.dzai007,
          dzai008      LIKE dzai_t.dzai008,
          dzai009      LIKE dzai_t.dzai009,
          dzai011      LIKE dzai_t.dzai011
          END RECORD 
   DEFINE ls_table_tmp LIKE dzgb_t.dzgb005
   DEFINE ls_table_str STRING 
   DEFINE l_gzdc_cnt   LIKE type_t.num5
   DEFINE ls_dzgc_s    LIKE type_t.num5
   DEFINE ls_dzgb      DYNAMIC ARRAY OF type_g_dzgb_d
   DEFINE ls_dzgb_t    type_g_dzgb_d
   DEFINE l_wc_str     STRING 
   DEFINE ls_space_str STRING 
   DEFINE ls_tmp       STRING 
   DEFINE l_dzgb_cnt   LIKE type_t.num5 
   DEFINE ls_table_cnt LIKE type_t.num5
   DEFINE l_yes,l_i    LIKE type_t.num5
   ##140118 先判斷inba inbb imaal-(s)  
   DEFINE l_gztz001    LIKE gztz_t.gztz001
   ##140118 先判斷inba inbb imaal-(s)
   DEFINE ls_exist     LIKE type_t.num5
   DEFINE ls_tableseq  LIKE type_t.num5
   DEFINE l_dzgc004    DYNAMIC ARRAY OF VARCHAR(15)   ##20140211 暫擋欄位用
   DEFINE lc_prefix    STRING                   ##20140211 暫擋欄位用
   DEFINE li_k         LIKE type_t.num5         ##20140211 暫擋欄位用
   DEFINE l_table_cnt  LIKE type_t.num5         ##20140211 暫擋欄位用
   DEFINE lc_dzgi004   LIKE dzgi_t.dzgi004      ##20140211 暫擋欄位用
   DEFINE li_j         LIKE type_t.num5         ##20140211 暫擋欄位用
   DEFINE ls_dzgb017   LIKE dzgb_t.dzgb017
   DEFINE l_dzgb_n     DYNAMIC ARRAY OF RECORD 
          l_dzgb015    LIKE dzgb_t.dzgb015,
          l_dzgb016    LIKE dzgb_t.dzgb016,
          l_dzgb017    LIKE dzgb_t.dzgb017
          END RECORD 
   DEFINE l_alias      LIKE dzgc_t.dzgc007
   DEFINE lc_tmp       DYNAMIC ARRAY OF RECORD  #dzgc存入別名用
          lc_dzgc003   LIKE dzgc_t.dzgc003,
          lc_dzgc004   LIKE dzgc_t.dzgc004
          END RECORD 
   DEFINE lc_dzgi_cnt  LIKE type_t.num5
   DEFINE l_detail_table  LIKE type_t.chr1      ##單身table只抓一次
   DEFINE lc_ent_cnt   LIKE type_t.num5
   DEFINE lc_site_cnt  LIKE type_t.num5
   DEFINE l_dzgi004    DYNAMIC ARRAY OF VARCHAR(15)
   DEFINE l_dzgi004_str STRING 
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_i_cnt     LIKE type_t.num10
   DEFINE l_dzgb012    LIKE dzgb_t.dzgb012
   DEFINE l_m_field    LIKE dzgc_t.dzgc004     ##主欄位
   DEFINE l_com_field  LIKE dzgd_t.dzgd004     ##組合欄位變數
   DEFINE l_formula    LIKE dzgd_t.dzgd006     ##組合欄位公式
   DEFINE l_prog_type  LIKE gzde_t.gzde005     #程式類型   #140626 add
   DEFINE l_module     LIKE gzde_t.gzde002     #模組       #140626 add
   DEFINE l_spec_ver   LIKE dzga_t.dzga002     #客製版次    #140626 add
   DEFINE l_spec_ide   LIKE dzga_t.dzga005     #規格標示    ##140626 add
   DEFINE ls_gzza001   STRING                  # 140626 add
   DEFINE l_dzaa004_ver STRING                 #141017 add
   DEFINE l_dzaf003_ver STRING                 #141017 add
   DEFINE l_ver        LIKE dzga_t.dzga002     ##150506  NO.150507-00002#1 add 
   DEFINE l_code_ide   LIKE type_t.chr1        ##150506  NO.150507-00002#1 add
   DEFINE ls_ver       STRING                  ##150506  NO.150507-00002#1 add
   DEFINE l_cnt        LIKE type_t.num10       ##150506  NO.150507-00002#1 add    
   DEFINE lb_flag      BOOLEAN                 ##150506  NO.150507-00002#1 add 
   DEFINE i            LIKE type_t.num5        ##160328 add

   

   CALL g_tablesel.clear()
   CALL g_tablejoin1.clear()
   CALL g_tablejoin2.clear()
   CALL g_join.clear()
   CALL g_filter.clear()
   CALL g_fieldsel.clear()
   CALL ls_table.clear()  #暫存table的關連資訊
   CALL ls_dzaa.clear()
   CALL ls_dzac002.clear()
   CALL g_join1.clear()
   CALL ls_dzai.clear()
   CALL ls_dzgb.clear()
   CALL g_xg_groupsel.clear()
   CALL g_summarylist1.clear()
   CALL g_summarylist2.clear()
   CALL l_dzgc004.clear()   ##20140211 暫擋欄位用
   CALL l_dzgb_n.clear()
   CALL lc_tmp.clear()
   CALL g_typelist1.clear()
   CALL g_typelist2.clear()
   CALL l_dzgi004.clear()

   LET g_alias_seq = 1
   LET l_detail_table ="N"
 
   
   #先將暫存檔清空
   CALL adzp188_delete_temptable()

   ##140612 mark -(s)
   ##先取出最新的規格版次
   #SELECT dzaf003 INTO l_dzaf003 FROM dzaf_t af WHERE af.dzaf001= p_gzza001 AND dzaf002 = (SELECT MAX(dzaf002) FROM dzaf_t af1 WHERE af1.dzaf001 = p_gzza001 AND af1.dzaf005 = af.dzaf005 AND af1.dzaf006 = af.dzaf006) #AND dzafstus='Y'
   ##若沒有版次就先1 
   #IF cl_null(l_dzaf003) THEN LET l_dzaf003 ="1" END IF    
   ##140612 mark -(e)
   #140612 add 取得最新規格版次g_spec_ver、客製標示g_spec_ide -(s)
   
   #SELECT gzde003,gzde002 INTO l_prog_type,l_module FROM gzde_t 
    #WHERE gzde001 = p_gzza001  ##140523原抓dzge005改抓dzge003  #140612 g_module
   ##140626 add 若是報表元件再呼叫一下，若不是呼叫gzaa_t -(S)
   #IF l_prog_type IS NULL AND l_module IS NULL THEN 
      #SELECT gzza002,gzza003 INTO l_prog_type,l_module FROM gzza_t 
       #WHERE gzza001 = p_gzza001 
       ##取出若是T類，在規格中是歸在M
       #IF l_prog_type="T" OR l_prog_type="Q" THEN LET l_prog_type="M" END IF    
   #END IF 

  ##150506  NO.150507-00002#1 add -(s)
  ##判斷是輸入報表元件
  LET l_cnt = 0
  SELECT COUNT(*) INTO l_cnt 
    FROM gzde_t
   WHERE gzde001 = p_gzza001
  IF l_cnt > 0 THEN 

        #報表元件名稱
        INITIALIZE g_ref_fields TO NULL
        LET g_dzga001 = p_gzza001
        LET g_ref_fields[1] = g_dzga001
        CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
        DISPLAY g_rtn_fields[1] TO formonly.gzza001_desc 
        
        SELECT gzde003,gzde002 INTO l_prog_type,l_module FROM gzde_t 
         WHERE gzde001 = p_gzza001     
        CALL cl_adz_get_code_curr_revision(p_gzza001,NULL, l_prog_type) RETURNING l_ver,l_code_ide,ls_err_msg   #140730 add
        LET ls_ver = l_ver CLIPPED  
        LET ls_ver = ls_ver.trim()             
        IF l_code_ide = "s" THEN 
           LET g_gzgf003 = "s"    
        ELSE 
           LET g_gzgf003 = "c"    
        END IF

        IF NOT cl_null(ls_err_msg) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = ls_err_msg
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          
        END IF  


         IF g_signout = 1 THEN                               ##有簽出才能複製
                     
             CALL adzp188_default(p_gzza001,l_ver,l_code_ide,'r') RETURNING li_cmd  ##呼叫參考報表元件的預設資料
             LET g_stus = "draft_save"      #161215-00029#1 add          
             CALL adzp188_draft_save()

            
             #160615-00007 add -(s)
             CALL sadzp188_copy_azzi300301(g_dzga_m.dzga001,g_dzga_m.dzga006,g_prog_type,p_gzza001,l_code_ide) 
             #160615-00007 add -(e)
             ## CALL add-point的複製   
             LET subPara.ms_dgenv = FGL_GETENV("DGENV") CLIPPED   
             LET subPara.ms_erpid = FGL_GETENV("ERPID") CLIPPED    
             LET subPara.ms_erpver = FGL_GETENV("ERPVER") CLIPPED
             LET subPara.ms_cust = FGL_GETENV("CUST") CLIPPED      
             LET subPara.g_gen_prog = g_dzga_m.dzga001
             LET subPara.g_copy_source = p_gzza001
             LET subPara.g_source_ver = ''               
             LET subPara.g_source_spec_ver = ''                   
             LET subPara.g_source_code_ver = l_ver
             LET subPara.g_source_identity = l_code_ide
             LET subPara.g_use_table_replace = 'N' 
             LET subPara.g_not_copy_appoint = 'N'  
             LET subPara.g_source_type = l_prog_type
             ##複製設計器上的資料ex：add-point、section資訊
             CALL sadzp270_copy_database_data_ALL(subPara.*, sub_dzag, sub_dzeb_stored, g_prog) RETURNING lb_flag
           
        
             CALL adzp188_comp_gen(g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga003,'')     ##150508 產生報表元件4GL 
             CALL sadzp188_gen4rp_copy(p_gzza001,g_dzga_m.dzga001,g_gzgf003,g_code_ide)       ##150508 ##複製報表元件樣板
             ##彈窗提示產生完成
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00270"
             LET g_errparam.extend = NULL 
             LET g_errparam.popup = TRUE
             CALL cl_err()  
        ELSE 
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00600"  ##未簽出不做複制功能
             LET g_errparam.extend = NULL 
             LET g_errparam.popup = FALSE
             CALL cl_err()            
        END IF  
        LET li_cmd = ""
        RETURN li_cmd
  ELSE 
  ##輸入是t作業
  ##150506  NO.150507-00002#1 add -(e)
   
       ##140808 add -(s)
       ##找azzi900裡的模組
       SELECT gzde002 INTO l_module FROM gzde_t 
        WHERE gzde001 = p_gzza001  
       IF l_module IS NULL THEN 
          SELECT gzza003 INTO l_module FROM gzza_t 
           WHERE gzza001 = p_gzza001  
       END IF 

       ##確認是否已經註冊
       LET l_prog_type = sadzp060_2_chk_spec_type(p_gzza001)
        IF l_prog_type = "N" THEN      
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'adz-00378'
          LET g_errparam.extend = NULL
          LET g_errparam.popup = TRUE
          LET g_errparam.replace[1] = p_gzza001
          CALL cl_err()
          RETURN NULL
        END IF
       ##140808 add -(e)

       
       #140626 add 若是報表元件再呼叫一下，若不是呼叫gzaa_t -(e)
        
       #CALL sadzp060_2_get_spec_curr_revision(p_gzza001, l_prog_type, l_module) RETURNING l_spec_ver,l_spec_ide,ls_err_msg#140730 mark
       CALL cl_adz_get_spec_curr_revision(p_gzza001, NULL,l_prog_type) RETURNING l_spec_ver,l_spec_ide,ls_err_msg #140730 add
       IF NOT cl_null(ls_err_msg) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'adz-00303'
          LET g_errparam.extend = NULL
          LET g_errparam.popup = TRUE
          LET g_errparam.replace[1] = p_gzza001
          CALL cl_err()
          #140710 add -(s)
          DISPLAY '' TO formonly.gzza001
          DISPLAY '' TO formonly.gzza001_desc
          LET g_gzza001 =''
          LET g_gzza001_desc=''
          #140710 add -(e)  
          RETURN NULL 
       END IF 
       LET l_dzaf003 = l_spec_ver
       LET l_dzaf003_ver = l_dzaf003   #141017 add
       LET l_dzaf003_ver = l_dzaf003_ver.trim()  #141017 add
       #140612 add 取得最新規格版次、客製標示 -(e)
       
       #取得Table的識別碼版次
       #151012-00003#1 mark -(s)
       #SELECT dzaa004 INTO l_dzaa004 FROM dzaa_t WHERE dzaa001 = p_gzza001 AND dzaa002 = l_dzaf003 AND dzaa003 = 'TABLE' AND dzaa005='4' 
          ##AND dzaa009 = l_spec_ide AND dzaa010 = g_cust##140613 add   #140626 mark
          #AND dzaa009 = l_spec_ide ##140626 add 
       #151012-00003#1 mark -(e)

       #取得table list 


       ##140505  舊版 -(s) 
       #LET g_sql =" SELECT dzag002,dzag004,dzag005 FROM dzag_t",
                  #" WHERE dzag001 ='", p_gzza001,"'"," AND dzag003 ='", l_dzaa004,"'" ," AND dzagstus='Y'"
       #PREPARE adzp188_dzag_pre FROM g_sql
       #DECLARE adzp188_dzag_cs CURSOR FOR adzp188_dzag_pre
    #
       #LET ls_i = 1
       #LET li_cnt = 1
       #FOREACH adzp188_dzag_cs INTO ls_table[ls_i].*
         #IF SQLCA.sqlcode THEN
           #EXIT FOREACH
         #END IF  
         #LET li_cmd = ""   #修改
        #
             #LET g_tablesel[ls_i].id = ls_table[ls_i].dzag002   
             #IF ls_table[ls_i].dzag005 = "Y" THEN    #140505 add
                 ##140206存入資料表暫存檔
                 #LET ls_exist = 0         
                 #SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
                 #IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
                 #SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
                  #WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                    #AND dzgi004 = ls_table[ls_i].dzag002
                 #IF ls_exist = 0 THEN 
                    #IF l_detail_table = "N" THEN  #140505 mark
                         #INSERT INTO adzp188_dzgi_tmp
                                #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq, ls_table[ls_i].dzag002)
                    #END IF                        #140505 mark
                 #END IF 
             #ELSE 
              ##非主table才抓
             #IF ls_table[ls_i].dzag005 ="N" THEN   #140505 mark
                #IF l_detail_table="N" THEN 
                    #抓出tableFK值
                    #CALL adzp188_tab_get_relation(ls_table[ls_i].dzag002,"FK",ls_table[ls_i].dzag004) RETURNING ls_dzed004,ls_dzed006,ls_err_msg
                    #未找到fk的table
                    #LET g_nFind_table = g_nFind_table,ls_err_msg,","   
             #
                    #組參考來源join wc
                    ##組FK的SQL，預設用=(01),EX:inba_t OUTER LEFT JOIN inbb_t ON inbb_t.inbb001 = inba_t.inba001              
                    #LET ls_wc = adzp188_combine_ref_join_wc("", ls_table[ls_i].dzag002, ls_dzed004, "01", "Y", ls_table[ls_i].dzag004, ls_dzed006)
                    #
                    #報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入  
                    #IF NOT ((ls_table[ls_i].dzag002 = "inbd_t" OR ls_table[ls_i].dzag004 ="inbd_t" ) AND g_dzga_m.dzga001='aint302_x01') THEN
                       ##擋掉保留字的wc
                       #IF adzp188_chk_dzgc_suffix(ls_dzed004) AND adzp188_chk_dzgc_suffix(ls_dzed006) THEN  
    #
                          ##20140211 先擋重覆的refence的wc   -(s)
                          ##LET l_dzgb_cnt = 0
                          ##SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
                          ##WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
                            ##AND dzgb005 = ls_table[ls_i].dzag002
                          ##IF l_dzgb_cnt = 0 THEN   
                           ##20140211 先擋重覆的refence的wc   -(e)      
                            #INSERT INTO adzp188_dzgb_tmp1
                                    #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,li_cnt,'',ls_table[ls_i].dzag002,'','','',ls_table[ls_i].dzag004,'',ls_wc,'','','','','','')          
                            #LET li_cnt = li_cnt + 1  
                          ##END IF ##20140211 先擋重覆的refence的wc
                       #ELSE ##沒存的table也不能存入
                         #
                       #END IF 
                    #END IF
                   #LET l_detail_table ="Y" 
               #END IF 
             #END IF       
             #LET ls_i = ls_i + 1      
       #END FOREACH 
       ##140505 -(e)舊版

       ##140505- (s)新版
       ##單頭
       ##141013 add -(s)
       ##各個insert的prepare
       #dzgi
       LET g_sql = " INSERT INTO adzp188_dzgi_tmp ",                    
                   "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?)" 
       PREPARE adzp188_dzgi_tmp_ins_pre FROM g_sql
       #dzgb1
       LET g_sql = " INSERT INTO adzp188_dzgb_tmp1 ",                    
                   "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" 
       PREPARE adzp188_dzgb_tmp1_ins_pre FROM g_sql   
       #dzgc
       LET g_sql = " INSERT INTO adzp188_dzgc_tmp ",                    
                   "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
       PREPARE adzp188_dzgc_tmp_prog_ins_pre FROM g_sql   

       #dzgb
       LET g_sql = " INSERT INTO adzp188_dzgb_tmp ",                    
                   "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" 
       PREPARE adzp188_dzgb_tmp_ins_pre FROM g_sql      
       ##141013 add -(e)
        LET l_dzaa004_ver = l_dzaa004
        LET l_dzaa004_ver = l_dzaa004_ver.trim()
        #151012-00003#1 mark -(s)
        #LET g_sql =" SELECT dzag002,dzag004,dzag005 FROM dzag_t",
                   #" WHERE dzag001 ='", p_gzza001,"'"," AND dzag003 ='", l_dzaa004_ver,"'" ," AND dzagstus='Y' AND dzag005 ='Y'",   #141017 add
                  ## " WHERE dzag001 ='", p_gzza001,"'"," AND dzag003 ='", l_dzaa004,"'" ," AND dzagstus='Y' AND dzag005 ='Y'",  #141017 mark 
                  ## "   AND dzag005 ='",g_cust,"' AND dzag006 ='",g_spec_ide,"'"  #140613 add  #140626 mark
                   #"    AND dzag006 ='",l_spec_ide,"'"  #140626 add  
        #151012-00003#1 mark -(e)           
        #151012-00003#1 add -(s)
        ##調整加入inner join dzaa_t
        LET g_sql =" SELECT dzag002,dzag004,dzag005 FROM dzag_t",
                   " INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa003='TABLE' AND dzaa004=dzag003 AND dzaa006=dzag006 ",
                   " WHERE dzaa001 ='", p_gzza001,"'"," AND dzaa002 ='", l_spec_ver,"' AND dzaa005='4'" ," AND dzagstus='Y' AND dzaa009 ='", l_spec_ide,"'",  
                   "   AND dzag005='Y'",
                   "  ORDER BY dzag002 "          
        #151012-00003#1 add -(e)
       PREPARE adzp188_dzag_pre FROM g_sql
       DECLARE adzp188_dzag_cs CURSOR FOR adzp188_dzag_pre
       LET ls_i = 1
       LET li_cnt = 1
       FOREACH adzp188_dzag_cs INTO ls_table[ls_i].*
         IF SQLCA.sqlcode THEN
           EXIT FOREACH
         END IF  
         LET li_cmd = ""   #修改
         LET g_tablesel[ls_i].id = ls_table[ls_i].dzag002   

             ##140206存入資料表暫存檔
             LET ls_exist = 0         
             SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
             IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
             SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
              WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                AND dzgi004 = ls_table[ls_i].dzag002 AND dzgi006 = g_code_ide   ##140613 add AND dzgi006 = g_code_ide 
                
             IF ls_exist = 0 THEN
                ##141013 mark -(s) 
                #INSERT INTO adzp188_dzgi_tmp
                       #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq, ls_table[ls_i].dzag002,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                ##141013 mark -(e)        
                EXECUTE adzp188_dzgi_tmp_ins_pre USING ls_tableseq, ls_table[ls_i].dzag002,g_cust,g_code_ide  ##141013 add      
             END IF 
         
         LET ls_i = ls_i + 1      
       END FOREACH 

       

       ##單身
       #151012-00003#1 mark -(s)
       #LET g_sql =" SELECT dzag002,dzag004,dzag005 FROM dzag_t",
                  #" WHERE dzag001 ='", p_gzza001,"'"," AND dzag003 ='", l_dzaa004_ver,"'" ," AND dzagstus='Y' AND dzag005 ='N'",   #141017 add
                  ##" WHERE dzag001 ='", p_gzza001,"'"," AND dzag003 ='", l_dzaa004,"'" ," AND dzagstus='Y' AND dzag005 ='N'",  #141017 mark
                  ##"   AND dzag006 ='",g_code_ide,"'"    #140613 add  #140626 mark
                  ##"   AND dzag006 ='",l_spec_ide,"'"    #140626 add  #151012-00003#1 mark
                  #"   AND dzag006 ='c'"    #151012-00003#1  add  先抓客製
       #151012-00003#1 mark -(e)

        #151012-00003#1 add -(s)
        ##調整加入inner join dzaa_t
        LET g_sql =" SELECT dzag002,dzag004,dzag005 FROM dzag_t",
                   " INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa003='TABLE' AND dzaa004=dzag003 AND dzaa006=dzag006 ",
                   " WHERE dzaa001 ='", p_gzza001,"'"," AND dzaa002 ='", l_spec_ver,"' AND dzaa005='4'" ," AND dzagstus='Y' AND dzaa009 ='", l_spec_ide,"'",  
                   "   AND dzag005 ='N'",
                   "  ORDER BY dzag002 "          
        #151012-00003#1 add -(e)


                  
       PREPARE adzp188_dzag_pre1 FROM g_sql
       DECLARE adzp188_dzag_cs1 CURSOR FOR adzp188_dzag_pre1
       FOREACH adzp188_dzag_cs1 INTO ls_table[ls_i].*
         IF SQLCA.sqlcode THEN
           EXIT FOREACH
         END IF  
         LET g_tablesel[ls_i].id = ls_table[ls_i].dzag002   
          ##非主table才抓
           LET ls_exist = 0         
           SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
           IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
           SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
            WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002             
              AND dzgi004 = ls_table[ls_i].dzag002
              AND dzgi006 = g_code_ide  #140613 add
           IF ls_exist = 0 THEN 
             ##141013 mark -(s)
              #INSERT INTO adzp188_dzgi_tmp
                     #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq, ls_table[ls_i].dzag002,g_cust,g_code_ide)  #140613 add ,g_cust,g_code_ide
             ##141013 mark -(e) 
             ##141013 add -(s) 
             EXECUTE adzp188_dzgi_tmp_ins_pre USING ls_tableseq, ls_table[ls_i].dzag002,g_cust,g_code_ide
             ##141013 add -(e)                 
           END IF 
          
          #抓出tableFK值
          CALL adzp188_tab_get_relation(ls_table[ls_i].dzag002,"FK",ls_table[ls_i].dzag004) RETURNING ls_dzed004,ls_dzed006,ls_err_msg
          #未找到fk的table
          LET g_nFind_table = g_nFind_table,ls_err_msg,","   
         
          #組參考來源join wc
          ##組FK的SQL，預設用=(01),EX:inba_t OUTER LEFT JOIN inbb_t ON inbb_t.inbb001 = inba_t.inba001              
          LET ls_wc = adzp188_combine_ref_join_wc("", ls_table[ls_i].dzag002, ls_dzed004, "01", "Y", ls_table[ls_i].dzag004, ls_dzed006)
          
          #報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入  

             ##擋掉保留字的wc
          IF adzp188_chk_dzgc_suffix(ls_dzed004) AND adzp188_chk_dzgc_suffix(ls_dzed006) THEN  

             ##20140211 先擋重覆的refence的wc   -(s)
             ##LET l_dzgb_cnt = 0
             ##SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
             ##WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
               ##AND dzgb005 = ls_table[ls_i].dzag002
             ##IF l_dzgb_cnt = 0 THEN   
              ##20140211 先擋重覆的refence的wc   -(e)      
               #INSERT INTO adzp188_dzgb_tmp1
                       #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,li_cnt,'',ls_table[ls_i].dzag002,'','','',
                              #ls_table[ls_i].dzag004,'',ls_wc,'','','','','','',g_cust,g_code_ide)  #140613 add,g_cust,g_code_ide

             ##141013 add -(s)   

             EXECUTE adzp188_dzgb_tmp1_ins_pre USING li_cnt,'',ls_table[ls_i].dzag002,'','','',
                              ls_table[ls_i].dzag004,'',ls_wc,'','','','','','',g_cust,g_code_ide
             ##141013 add -(e)                
               LET li_cnt = li_cnt + 1  
             ##END IF ##20140211 先擋重覆的refence的wc
          ELSE ##沒存的table也不能存入
            
          END IF 
          EXIT FOREACH 
         LET ls_i = ls_i + 1      
       END FOREACH    

       ##140505 -(e)新版

       
       #報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入
       ##先判斷是否存在，不存在則存入
       IF ls_wc IS NOT NULL THEN   ##150122 add
           LET l_dzgb_cnt = 0
           SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
           WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 AND dzgb011 = ls_wc  
             AND dzgb019 = g_code_ide   #140613 add
           IF l_dzgb_cnt = 0 THEN  
               ##20140211 先擋重覆的refence的wc   -(s)
               #LET l_dzgb_cnt = 0
               #SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
               #WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
                 #AND dzgb005 = ls_table[ls_i].dzag002
               #IF l_dzgb_cnt = 0 THEN   
               ##20140211 先擋重覆的refence的wc   -(e)  
                   ##141013 mark -(s)
                   #INSERT INTO adzp188_dzgb_tmp1
                          #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,li_cnt,'',ls_table[ls_i].dzag002,'','','',
                                 #ls_table[ls_i].dzag004,'',ls_wc,'','','','','','',g_cust,g_code_ide) # 140613 add ,g_cust,g_code_ide
                   ##141013 mark -(e)
                   ##141013 add -(s)
                   EXECUTE adzp188_dzgb_tmp1_ins_pre USING li_cnt,'',ls_table[ls_i].dzag002,'','','',
                                 ls_table[ls_i].dzag004,'',ls_wc,'','','','','','',g_cust,g_code_ide
                   ##141013 add -(e)
               #END IF ##20140211 先擋重覆的refence的wc
           END IF 
       END IF  ##150122 add
       #取得欄位的識別碼版次
       #151012-00003#1  mark -(s)
       #LET g_sql = " SELECT DISTINCT dzac002 from dzaa_t,dzac_t ",
                   ##" WHERE dzaa001 = dzac001 and dzaa003 = dzac003 and dzaa004 =dzac004 and dzaa006 = dzac012  AND dzaa001 = '",p_gzza001, "'"," AND dzaastus ='Y' and dzaa005 ='1'", "AND dzaa002='",l_dzaf003,"'",  #141017 mark
                   #" WHERE dzaa001 = dzac001 and dzaa003 = dzac003 and dzaa004 =dzac004 and dzaa006 = dzac012  AND dzaa001 = '",p_gzza001, "'"," AND dzaastus ='Y' and dzaa005 ='1'", "AND dzaa002='",l_dzaf003_ver,"'",   #141017 add
                   #" AND dzac002 IS NOT NULL "
       #151012-00003#1  mark -(e)
       
       #151012-00003#1  add -(s)
       LET g_sql = " SELECT DISTINCT dzac002 FROM dzac_t ",
                   " INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012 ",
                   " WHERE dzaa001 = '",p_gzza001, "'"," AND dzaastus ='Y' and dzaa005 ='1'", "AND dzaa002='",l_spec_ver,"'", 
                   " AND dzaa009 ='",l_spec_ide,"'",
                   " AND dzac002 IS NOT NULL "
       #151012-00003#1  add -(s)
                   
       PREPARE adzp188_dzac_pre FROM g_sql
       DECLARE adzp188_dzac_cs CURSOR FOR adzp188_dzac_pre
       LET ls_i = 1
       LET ls_dzgc_s = 1
       FOREACH adzp188_dzac_cs INTO ls_dzac002[ls_i]     
          #報表元件設計-資料模型欄位明細檔 
          IF NOT cl_null(ls_dzac002[ls_i]) THEN  

             ##140301只抓主，第一單身table欄位
             LET l_gztz001=''
             SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 =ls_dzac002[ls_i]
                AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
                ##161227-00056#1 add -(s)
                AND gztz001 NOT LIKE 'erp%'   
                AND gztz001 NOT LIKE 'all%'
                AND gztz001 NOT LIKE 'b2b%'
                AND gztz001 NOT LIKE 'pos%'
                AND gztz001 NOT LIKE 'dsm%'
                ##161227-00056#1 add -(e)                
             IF NOT cl_null(l_gztz001) AND adzp188_chk_table_needinsert(l_gztz001) THEN 
                 IF adzp188_chk_dzgc_suffix(ls_dzac002[ls_i]) THEN 
                    LET l_gztz001 =''
                    SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = ls_dzac002[ls_i]  
                       AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add 
                       ##161227-00056#1 add -(s)
                       AND gztz001 NOT LIKE 'erp%'   
                       AND gztz001 NOT LIKE 'all%'
                       AND gztz001 NOT LIKE 'b2b%'
                       AND gztz001 NOT LIKE 'pos%'
                       AND gztz001 NOT LIKE 'dsm%'
                       ##161227-00056#1 add -(e)                       
                    ##141013 mark -(s)    
                    #INSERT INTO adzp188_dzgc_tmp
                           #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgc_s,ls_dzac002[ls_i],
                                  #'1','N',l_gztz001,g_cust,g_code_ide)#140613 add,g_cust,g_code_ide
                    ##141013 mark -(e)
                    ##141013 add -(s)
                    EXECUTE adzp188_dzgc_tmp_prog_ins_pre USING ls_dzgc_s,ls_dzac002[ls_i],
                                  '1','N',l_gztz001,g_cust,g_code_ide
                    ##141013 add -(s)              
                                  
                    LET ls_dzgc_s = ls_dzgc_s +1  #順序      
                 END IF 
              END IF 

              LET ls_i = ls_i +1
          END IF 
       END FOREACH       

       SELECT MAX(dzgb003)+1 INTO ls_dzgb_seq FROM adzp188_dzgb_tmp1
       SELECT MAX(dzgc003)+1 INTO ls_dzgc_seq FROM adzp188_dzgc_tmp
       
       CALL g_tablesel.clear()

       
       ##取得參考TABLE、欄位資訊
       #取得參考Table的識別碼版次   
       SELECT dzaa003, dzaa004, dzaa006 INTO l_dzaa003,l_dzaa004,l_dzaa006 FROM dzaa_t WHERE dzaa001 = p_gzza001 AND dzaa002 = l_dzaf003 AND dzaa005='6' #AND dzaastus='Y'
       #AND dzaa009 = g_spec_ide  AND dzaa010 = g_cust ##140613 add   #141017 mark
       AND dzaa009 = g_spec_ide   ##141017 add 
       
       #取得參考table list 
       ###151012-00003#1 mark -(s)
       #LET g_sql = " SELECT dzai005,dzai007,dzai008,dzai009, dzai011 FROM dzaa_t,dzai_t ",
                   #" WHERE dzaa001 = dzai001 AND dzaa003 = dzai002 AND dzaa004 = dzai003 AND dzaa006 = dzai004",
                   ##" AND dzaa001='",p_gzza001,"'"," AND dzaa002 ='", l_dzaf003 ,"'"," AND dzaa005='6' AND dzaastus='Y'"  #141017 mark
                   #" AND dzaa001='",p_gzza001,"'"," AND dzaa002 ='", l_dzaf003_ver ,"'"," AND dzaa005='6' AND dzaastus='Y'"    #141017 add
       ###151012-00003#1 mark -(e)
      ##160328 add   -(s) 
      FOR i = 1 TO ls_table.getLength()  
          LET ls_table_str = ls_table[i].dzag002
          LET ls_table_str = ls_table_str.subString(1, ls_table_str.getIndexOf('_',1)-1)          
       ##160328 add   -(e) 
           ###151012-00003#1 add -(s)
          LET g_sql = " SELECT dzai005,dzai007,dzai008,dzai009, dzai011 FROM dzai_t ",
                      " INNER JOIN dzaa_t ON dzaa001=dzai001 AND dzaa003=dzai002 AND dzaa004=dzai003 AND dzaa006=dzai004 ",
                      " WHERE dzaa001='",p_gzza001,"'"," AND dzaa002 ='", l_spec_ver ,"'"," AND dzaa005='6' AND dzaastus='Y'",
                      "   AND dzaa009='",l_spec_ide,"'",
                      "   AND dzai002 like '%",ls_table_str,"%'",    ##160328 add  
                      " ORDER BY dzai002 "                  
           ###151012-00003#1 add -(e)
           PREPARE adzp188_dzai_pre FROM g_sql
           DECLARE adzp188_dzai_cs CURSOR FOR adzp188_dzai_pre
           LET ls_i = 1
           LET ls_table_cnt =1
           FOREACH adzp188_dzai_cs INTO ls_dzai[ls_i].*
             IF SQLCA.sqlcode THEN
               EXIT FOREACH
             END IF  
             ##140211 先擋dzai005=inbc_t.inba009 -(S)
             #IF ls_dzai[ls_i].dzai005='inbc_t.inbc009' THEN 
                #CONTINUE FOREACH 
             #END IF 
             ##140416 join的key值若為空值則不做join -(s)
             IF cl_null(ls_dzai[ls_i].dzai007) OR cl_null(ls_dzai[ls_i].dzai008) OR 
                cl_null(ls_dzai[ls_i].dzai009) OR cl_null(ls_dzai[ls_i].dzai011) THEN 
                CONTINUE FOREACH 
             END IF 
             ##140416 join的key值若為空值則不做join -(e)

             ##140301 dzai005是要跟主表與第一個單身表有關才繼續做
             ##組FK的SQL，預設用=(01),EX:inbb_t.inbb001 = inba_t.inba001  
             LET ls_table_str = ls_dzai[ls_i].dzai005  
             ##判斷撈出來的table，若是b_inbb004->inbb_t，inbb_t.inbb004->inbb_t      
             IF ls_table_str.getIndexOf("b_",1)>0 AND ls_table_str.getIndexOf(".",1) = 0  THEN
                LET ls_table_str = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength()-3),"_t"
                ##140429 抓主欄位 
                #LET l_m_field = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength())
             ELSE 
                IF ls_table_str.getIndexOf(".",1)>0 THEN 
                   LET ls_table_str = ls_table_str.subString(1,ls_table_str.getIndexOf(".",1)-1)
                   ##140429 抓主欄位
                   #LET l_m_field = ls_table_str.subString(ls_table_str.getIndexOf(".",1)+1,ls_table_str.getLength())
                END IF
             END IF
             LET ls_table_tmp = ls_table_str      
             IF NOT adzp188_chk_table_needinsert(ls_table_tmp) THEN 
              CONTINUE FOREACH 
             END IF
           

             
             ##重取關連資料表的KEY值
　　　　　　　　CALL sadzp188_get_jointable_key(ls_table_str,ls_dzai[ls_i].dzai007, ls_dzai[ls_i].dzai008, ls_dzai[ls_i].dzai009) RETURNING ls_dzai[ls_i].dzai007, ls_dzai[ls_i].dzai009 ##160615-00007 add
             #組參考來源join wc
             LET ls_wc =""
             LET ls_wc = adzp188_combine_ref_join_wc("", ls_table_str, ls_dzai[ls_i].dzai007, "01", "Y", ls_dzai[ls_i].dzai008, ls_dzai[ls_i].dzai009)

             #報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入
             #IF ls_table_tmp ="inbd_t" THEN LET ls_table_tmp ="" END IF       #131231先擋inbd_t
             ##先判斷是否存在，不存在則存入
             LET l_dzgb_cnt = 0
             SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
             WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 AND dzgb011 = ls_wc  
             #  AND dzgb018 = g_cust AND dzgb019 = g_code_ide  #140613 add                         #141013 mark
               AND dzgb019 = g_code_ide                                                            #141013 add 
             IF l_dzgb_cnt = 0 THEN    
                #IF NOT (ls_table_tmp = "inbd_t" OR  ls_table_tmp = "inbc_t" OR ls_dzai[ls_i].dzai008 ="inbd_t") THEN
                 IF adzp188_chk_table_needinsert(ls_table_tmp) THEN 
                   IF adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai007) AND adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai009) THEN
                          ##141013 mark -(s)
                          #INSERT INTO adzp188_dzgb_tmp1
                                 #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_table_tmp,'','','',ls_dzai[ls_i].dzai008,'',ls_wc,ls_dzai[ls_i].dzai005,
                                        #ls_dzai[ls_i].dzai007,ls_dzai[ls_i].dzai008,ls_dzai[ls_i].dzai009,ls_dzai[ls_i].dzai011,'',g_cust,g_code_ide)   #140613 add,g_cust,g_code_ide
                          ##141013 mark -(e)
                          ##141013 add -(s)
                          EXECUTE adzp188_dzgb_tmp1_ins_pre USING ls_dzgb_seq,'',ls_table_tmp,'','','',ls_dzai[ls_i].dzai008,'',ls_wc,ls_dzai[ls_i].dzai005,
                                        ls_dzai[ls_i].dzai007,ls_dzai[ls_i].dzai008,ls_dzai[ls_i].dzai009,ls_dzai[ls_i].dzai011,'',g_cust,g_code_ide
                          ##141013 add -(e)
                        
                          LET ls_dzgb_seq = ls_dzgb_seq + 1  

                            ##判斷字尾不是保留字才存
                            IF adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai011) AND adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai007) AND adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai009) THEN
                               IF NOT cl_null(ls_dzai[ls_i].dzai011) THEN 
                                 ##141013 mark -(s)
                                 #INSERT INTO adzp188_dzgc_tmp
                                        #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgc_seq,ls_dzai[ls_i].dzai011,'1','N','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                                 ##141013 mark -(e)
                                 EXECUTE adzp188_dzgc_tmp_prog_ins_pre USING ls_dzgc_seq,ls_dzai[ls_i].dzai011,'1','N','',g_cust,g_code_ide  ###141013 add
                               END IF 
                                ##140313存入資料表暫存檔--(s)      
                                LET ls_exist = 0         

                                SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
                                 WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                                   AND dzgi004 = ls_dzai[ls_i].dzai008
                                   #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add  #141017 mark
                                   AND dzgi006 = g_code_ide #141017 add
                                IF ls_exist = 0 THEN 
                                   IF NOT cl_null(ls_dzai[ls_i].dzai008) THEN 
                                       SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
                                       IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
                                       ##141013 mark -(s)
                                       #INSERT INTO adzp188_dzgi_tmp
                                           #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq, ls_dzai[ls_i].dzai008,g_cust,g_code_ide) #140613 add,g_cust,g_code_ide
                                       ##141013 mark -(e)                                   
                                       EXECUTE adzp188_dzgi_tmp_ins_pre USING ls_tableseq, ls_dzai[ls_i].dzai008,g_cust,g_code_ide  ##141013 add                                   
                                   END IF 
                                END IF     
                                ##140313存入資料表暫存檔--(e)                               
                                LET ls_dzgc_seq = ls_dzgc_seq +1
                            END IF            

                   END IF 
                END IF 
             END IF 
             LET ls_i = ls_i + 1
             LET ls_table_cnt =ls_table_cnt +1
             END FOREACH 
           END FOR ##160328 add 
     
            
               #依table 組enterprise與 site ex:inba_t  =>inbaent = '" ||g_enterprise|| "' AND inbasite = '" ||g_site||
               ##140118為了DEMO 先MARK掉 --(S)
               #FOR ls_i = 1 TO g_tablesel.getLength()  
                   #IF NOT cl_null(g_tablesel[ls_i].id) THEN 
                       #LET l_table_str = g_tablesel[ls_i].id
                       #LET ls_table_tmp = g_tablesel[ls_i].id
                       #LET l_ent_str = l_table_str.subString(1,l_table_str.getIndexOf("_",1)-1),"ent"
                       #LET l_site_str = l_table_str.subString(1,l_table_str.getIndexOf("_",1)-1),"site"
                       #IF ls_i = 1 THEN
                          #IF l_table_str.subString(5,5) = "l" THEN 
                              #LET ls_wc = l_ent_str ," = g_enterprise "            
                          #ELSE
                             #LET ls_wc = l_ent_str ," = g_enterprise AND ", l_site_str, " = g_site "
                          #END IF 
                       #ELSE  
                          #IF l_table_str.subString(5,5) = "l" THEN   
                             #LET ls_wc = ls_wc, " AND ",l_ent_str ," = g_enterprise "             
                          #ELSE 
                             #LET ls_wc = ls_wc, " AND ",l_ent_str ," = g_enterprise AND ", l_site_str, " = g_site "
                          #END IF 
                       #END IF    
                   #END IF                   
               #END FOR
               ##140118為了DEMO 先MARK掉 --(S)
                ##140214-(s)   
               
               ##報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入
               ##IF ls_table_tmp ="inbd_t" THEN LET ls_table_tmp ="" END IF       #131231先擋inbd_t  
               #SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
               #WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 AND dzgb011 = ls_wc 
               #IF l_dzgb_cnt = 0 THEN 
                   #IF NOT (ls_table_tmp='inbd_t') AND g_dzga_m.dzga001='aint302_x01' THEN 
                     ##20140211 先擋重覆的refence的wc   -(s)
                     #LET l_dzgb_cnt = 0
                     #SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
                     #WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
                       #AND dzgb005 = ls_table_tmp
                     #IF l_dzgb_cnt = 0 THEN   
                     ##20140211 先擋重覆的refence的wc   -(e)        
                       #INSERT INTO adzp188_dzgb_tmp1
                               #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_table_tmp,'','','',ls_table_tmp,'',ls_wc)
                     #END IF ##20140211 先擋重覆的refence的wc  
                   #END IF 
               #END IF 
       
              ##140214-(e) 
       CALL ls_dzac002.clear()

       ##將left join的wc再處理排序過  ---(S)
       ##ex :inaa LEFT OUTER JOIN inab ON~~
       ##         LEFT OUTER JOIN inac ON~~ ,
       ##    inad LEFT OUTER JOIN inae ON~~   

       LET ls_dzgb_seq = 1
       LET g_sql =" SELECT dzgb003, dzgb004, dzgb005, dzgb006, dzgb007, dzgb008, dzgb009, dzgb010,dzgb011,",
                  "        dzgb012, dzgb013, dzgb014, dzgb015, dzgb016,dzgb017 ",
                  "   FROM adzp188_dzgb_tmp1 ",
                  #"  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'",  #140923 elena mark
                  "  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",             #140923 elena add
                  #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'",  #140613 add  #141017 mark
                  "    AND dzgb019 ='",g_code_ide,"'",  #141017 add 
                  "  ORDER BY dzgb005 "
       PREPARE adzp188_dzgb_sort_pre FROM g_sql
       DECLARE adzp188_dzgb_sort_cs CURSOR FOR adzp188_dzgb_sort_pre
       LET ls_i = 1
       FOREACH adzp188_dzgb_sort_cs INTO ls_dzgb[ls_i].*
         IF SQLCA.sqlcode THEN
           EXIT FOREACH
         END IF   
         IF ls_i = 1 THEN
            IF cl_null(ls_dzgb[ls_i].dzgb017) THEN LET ls_dzgb[ls_i].dzgb017 = ls_dzgb[ls_i].dzgb014 END IF
            ##141013 mark -(s) 
            #INSERT INTO adzp188_dzgb_tmp
            #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',ls_dzgb[ls_i].dzgb009,'',
                   #ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,
                   #ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,g_cust,g_code_ide)  #140613 add ,g_cust,g_code_ide
            ##141013 mark -(e)
            ##141013 add -(s)
            EXECUTE adzp188_dzgb_tmp_ins_pre USING ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',ls_dzgb[ls_i].dzgb009,'',
                   ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,
                   ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,g_cust,g_code_ide   
            ##141013 add -(e)
         ELSE    
             LET l_wc_str = ls_dzgb[ls_i].dzgb011
             ##table相同，則left join前換成空白
             IF l_wc_str.getIndexOf("JOIN",1)>0 THEN 
                 IF ls_dzgb[ls_i].dzgb005 = ls_dzgb_t.dzgb005 THEN
                    LET ls_tmp = ls_dzgb[ls_i].dzgb005
                    LET ls_space_str = ls_tmp.getLength()+ 5 SPACE 
                    LET l_wc_str =ls_space_str, l_wc_str.subString(l_wc_str.getindexof(ls_dzgb[ls_i].dzgb005,1)+ls_tmp.getLength() ,l_wc_str.getLength())              
                    LET ls_dzgb[ls_i].dzgb011 = l_wc_str
                 END IF 
             END IF 
             ##加上別名##   
             IF NOT cl_null(ls_dzgb[ls_i].dzgb012) THEN   ##140325排除foreign key組成的不置換別名         
                 CALL adzp188_ref_wc_addalias(l_wc_str,ls_dzgb[ls_i].dzgb009) RETURNING ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb017  
                 IF cl_null(ls_dzgb[ls_i].dzgb017) THEN  LET ls_dzgb[ls_i].dzgb017 = ls_dzgb[ls_i].dzgb009 END IF   
                 #LET ls_dzgb[ls_i].dzgb011 = adzp188_ref_wc_addalias(l_wc_str,ls_dzgb[ls_i].dzgb009) # l_wc_str
             END IF 
             ##141013 mark -(s)   
             #INSERT INTO adzp188_dzgb_tmp
                  #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',
                         #ls_dzgb[ls_i].dzgb009,'',ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,
                         #ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
            ##141013 mark -(e)
            ##141013 add -(s)
            EXECUTE adzp188_dzgb_tmp_ins_pre USING ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',
                         ls_dzgb[ls_i].dzgb009,'',ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,
                         ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,g_cust,g_code_ide
            ##141013 add -(e)                     
     
         END IF         
             LET ls_dzgb_seq = ls_dzgb_seq + 1   
             LET ls_dzgb_t.* =ls_dzgb[ls_i].*     

         ##140206存入資料表暫存檔--(s)
         LET ls_exist = 0         

         SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp       
          WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
            AND dzgi004 = ls_dzgb[ls_i].dzgb005
            #AND dzgi005 = g_cust AND dzgi006 = g_code_ide   ##141013 mark
            AND dzgi006 = g_code_ide                         ##141013 add

         IF ls_exist = 0 THEN 

                IF NOT cl_null(ls_dzgb[ls_i].dzgb005) THEN 
                   SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
                   IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF
                   ##141013 mark -(s)
                   #INSERT INTO adzp188_dzgi_tmp
                        #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq , ls_dzgb[ls_i].dzgb005,
                               #g_cust,g_code_ide)  #140613 add 
                    ##141013 mark -(e)            
                   ##141013 add -(s)
                   EXECUTE adzp188_dzgi_tmp_ins_pre USING ls_tableseq , ls_dzgb[ls_i].dzgb005,
                               g_cust,g_code_ide
                   ##141013 add -(e)
                END IF 

         END IF   
         LET ls_exist = 0         

         SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
          WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
            AND dzgi004 = ls_dzgb[ls_i].dzgb009
            #AND dzgi005 = g_cust AND dzgi006 = g_code_ide  #140613 add  #141017 mark
            AND dzgi006 = g_code_ide  #141017 add
         IF ls_exist = 0 THEN 
            IF NOT cl_null(ls_dzgb[ls_i].dzgb009) THEN 
              SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
              IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
                ##141013 mark -(s) 
                #INSERT INTO adzp188_dzgi_tmp
                     #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq , ls_dzgb[ls_i].dzgb009,
                            #g_cust,g_code_ide)  #140613 add g_cust,g_code_ide
                ##141013 mark -(e)            
                ##141013 add -(s)
                EXECUTE adzp188_dzgi_tmp_ins_pre USING  ls_tableseq , ls_dzgb[ls_i].dzgb009,
                            g_cust,g_code_ide
                ##141013 add -(e)                        
            END IF 
         END IF      
         ##140206存入資料表暫存檔--(e)      
         LET ls_i = ls_i + 1    
       END FOREACH 
       #CALL  adzp188_ref_wc_addalias(ls_dzgb_t.dzgb011,ls_dzgb_t.dzgb009) RETURNING ls_dzgb_t.dzgb011,ls_dzgb_t.dzgb017
       #LET ls_dzgb_t.dzgb011 = adzp188_ref_wc_addalias(ls_dzgb_t.dzgb011,ls_dzgb_t.dzgb009) # l_wc_str
       #INSERT INTO adzp188_dzgb_tmp
              #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_dzgb_t.dzgb005,'','','',ls_dzgb_t.dzgb009,'',ls_dzgb_t.dzgb011,ls_dzgb_t.dzgb012,ls_dzgb_t.dzgb013,ls_dzgb_t.dzgb014,ls_dzgb_t.dzgb015,ls_dzgb_t.dzgb016,ls_dzgb_t.dzgb017)
       ##將left join的wc再處理排序過  ---(E)
       
    #20140211-not


      ##140317新的~(s)

      CALL l_dzgi004.clear()
      LET li_k = 1
      LET li_j = 1
      CALL lc_tmp.clear()
      LET g_sql = "SELECT dzgi004 FROM adzp188_dzgi_tmp ",
                  #" WHERE dzgi001 = '", g_dzga_m.dzga001,"' AND dzgi002 = '", g_dzga_m.dzga002,"'",   #140923 elena mark
                   " WHERE dzgi001 = '", g_dzga_m.dzga001,"' AND dzgi002 = '", gs_ver,"'",             #140923 elena add
                  #"   AND dzgi006 ='",g_cust ,"' AND dzgi006 ='",g_code_ide,"'",   #140613 add  #141017 mark
                  "   AND dzgi006 ='",g_code_ide,"'",   #141017 add
                  " ORDER BY dzgi003 "  
      PREPARE xg_dzgi_pre FROM g_sql
      DECLARE xg_dzgi_curs CURSOR FOR xg_dzgi_pre     
      FOREACH xg_dzgi_curs INTO l_dzgi004[li_k]     
         LET li_k = li_k +1
      END FOREACH 
      CALL l_dzgi004.deleteElement(li_k)

      ##140324 -(S)增加單頭table
      ##140324 -(E)
      LET li_i = 1
      FOR li_k = 1 TO l_dzgi004.getLength()

            ##140318 mark -(S)
           ##140317 判斷主table要加enterprise  140318因為考慮到應用的場景會換enterprise，若寫在報表元件裡會無法置換，所以先由r、q、t那邊傳入
           #IF li_k = 1 THEN
              #CALL adzp188_create_maintable_dzgf(l_dzgi004[li_k]) 
           #END IF 
           ##140318 mark -(e)

           ##140331 增加主表7個保留字尾欄位至dzgc -(s)
           IF li_k = 1 THEN
              CALL adzp188_add_main_table_suffix(l_dzgi004[li_k]) 
           END IF  
           ##140331 增加主表7個保留字尾欄位至dzgc -(e)

           LET l_dzgi004_str = l_dzgi004[li_k]
           LET l_dzgi004_str = l_dzgi004_str.subString(1,l_dzgi004_str.getIndexOf("_",1)-1),"%"

           LET g_sql = " SELECT dzgc003,dzgc004 FROM adzp188_dzgc_tmp ",
                      " WHERE dzgc006 ='N'",
                      #"   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",  #140923 elena mark
                      "   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",             #140923 elena add
                      "   AND dzgc004 LIKE '",l_dzgi004_str,"'",
                      #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",  #140613 add  #141017 mark
                      "   AND dzgc009 ='",g_code_ide,"'",  #141017 add
                      " ORDER BY dzgc004 "
          PREPARE xg_dzgc_pre FROM g_sql
          DECLARE xg_dzgc_curs CURSOR FOR xg_dzgc_pre     
          FOREACH xg_dzgc_curs INTO lc_tmp[li_i].*    
             LET li_i = li_i +1
          END FOREACH       
      END FOR 
      CALL lc_tmp.deleteElement(li_i)
      ##先把順序搬到很遠去
      FOR li_i = 1 TO lc_tmp.getLength()
          LET li_i_cnt = li_i * 10000
          UPDATE adzp188_dzgc_tmp SET dzgc003 = li_i_cnt
           WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
             AND dzgc004 = lc_tmp[li_i].lc_dzgc004 AND dzgc003 = lc_tmp[li_i].lc_dzgc003  
             #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  #141013 mark
             AND dzgc009 = g_code_ide                       ##141013 add  
               
           LET lc_tmp[li_i].lc_dzgc003 = li_i_cnt 
      END FOR 
      ##再依序把順序搬對
      FOR li_i = 1 TO lc_tmp.getLength()
          UPDATE adzp188_dzgc_tmp SET dzgc003 = li_i
           WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
             AND dzgc004 = lc_tmp[li_i].lc_dzgc004 AND dzgc003 = lc_tmp[li_i].lc_dzgc003 
             #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add
             AND dzgc009 = g_code_ide      #141013 add 
      END FOR   

      
      ##140317新的~(e)
      ##欄位照table順序重排--(e)
      
      ##將別名補入dzgc--(s)
      CALL lc_tmp.clear()
      LET li_j = 1
      LET g_sql = " SELECT DISTINCT dzgc004 FROM adzp188_dzgc_tmp " ,
                  #"  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",g_dzga_m.dzga002,"'",   #140923 elena mark
                  "  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",gs_ver,"'",              #140923 elena add
                  "    AND dzgc008 ='", g_cust,"' AND dzgc009 ='",g_code_ide,"'",  #140613 add
                  "  ORDER BY dzgc004 "
      PREPARE dzgc004_get_pre FROM g_sql
      DECLARE dzgc004_get_cs CURSOR FOR dzgc004_get_pre
      FOREACH dzgc004_get_cs INTO l_dzgc004[li_j]
              LET li_j = li_j + 1
      END FOREACH 
      CALL l_dzgc004.deleteElement(li_j)

      FOR li_k = 1 TO l_dzgc004.getLength()
          
          ##抓出reference的別名
          CALL l_dzgb_n.clear()
          LET l_i = 1
          LET g_sql = " SELECT dzgb015,dzgb016,dzgb017 FROM adzp188_dzgb_tmp ",
                      #"  WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",g_dzga_m.dzga002,"'",    #140923 elena mark
                      "  WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",gs_ver,"'",              #140923 elena add
                      "    AND dzgb016 ='", l_dzgc004[li_k] ,"'",
                      #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'"  #140613 add #141017mark
                      "    AND dzgb019 ='",g_code_ide,"'"  #141017 add
          PREPARE adzp188_get_dzgb017n_pre FROM g_sql
          DECLARE adzp188_get_dzgb017n_cs1 CURSOR FOR adzp188_get_dzgb017n_pre
          FOREACH adzp188_get_dzgb017n_cs1 INTO l_dzgb_n[l_i].*
             LET l_i = l_i + 1
          END FOREACH 
          CALL l_dzgb_n.deleteElement(l_i)
          ##抓dzgc欄位
          LET l_i = 1
          CALL lc_tmp.clear()
          LET g_sql = " SELECT dzgc003,dzgc004 FROM adzp188_dzgc_tmp " ,
                      #"  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",g_dzga_m.dzga002,"'",   #140923 elena mark
                      "  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",gs_ver,"'",              #140923 elena add
                      "    AND dzgc004 ='",l_dzgc004[li_k],"'",
                      #"    AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'", # 140613 add #141013 mark
                      "    AND dzgc009 ='",g_code_ide,"'", # 141013 add
                      "  ORDER BY dzgc003 "      
          PREPARE dzgc004_get_pre1 FROM g_sql
          DECLARE dzgc004_get_cs1 CURSOR FOR dzgc004_get_pre1
          FOREACH dzgc004_get_cs1 INTO lc_tmp[l_i].*
              LET l_alias =''
              IF NOT cl_null(l_dzgb_n[l_i].l_dzgb017) THEN
                 LET l_alias = l_dzgb_n[l_i].l_dzgb017
              ELSE 
                 SELECT gztz001 INTO l_alias FROM gztz_t WHERE gztz002 = lc_tmp[l_i].lc_dzgc004   
                    AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add    
                    ##161227-00056#1 add -(s)
                    AND gztz001 NOT LIKE 'erp%'   
                    AND gztz001 NOT LIKE 'all%'
                    AND gztz001 NOT LIKE 'b2b%'
                    AND gztz001 NOT LIKE 'pos%'
                    AND gztz001 NOT LIKE 'dsm%'
                    ##161227-00056#1 add -(e)                    
              END IF 
              UPDATE adzp188_dzgc_tmp SET dzgc007 = l_alias          
               WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                 AND dzgc003 = lc_tmp[l_i].lc_dzgc003
                 #AND dzgc008 = g_cust AND dzgc009 = g_code_ide   #140613 mark
                 AND dzgc009 = g_code_ide                         #140613 add           
              LET l_i = l_i + 1
          END FOREACH 
      END FOR 


      ###140430-(s)  判斷主欄位的屬性符合需要存組合欄位的屬性
       CALL ls_dzgb.clear()   
       LET g_sql =" SELECT dzgb003, dzgb004, dzgb005, dzgb006, dzgb007, dzgb008, dzgb009, dzgb010,dzgb011,",
                  "        dzgb012, dzgb013, dzgb014, dzgb015, dzgb016,dzgb017 ",
                  "   FROM adzp188_dzgb_tmp ",
                  #"  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'",   #140923 elena mark
                  "  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",              #140923 elena add
                  #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'",  #140613 add  #141013 mark
                  "    AND dzgb019 ='",g_code_ide,"'",  #140613 add   #141013 add
                  "  ORDER BY dzgb005 "
       PREPARE adzp188_dzgb_pre FROM g_sql
       DECLARE adzp188_dzgb_cs CURSOR FOR adzp188_dzgb_pre
       LET ls_i = 1
       FOREACH adzp188_dzgb_cs INTO ls_dzgb[ls_i].*

         LET ls_table_str = ls_dzgb[ls_i].dzgb012 
         ##判斷撈出來的table，若是b_inbb004->inbb_t，inbb_t.inbb004->inbb_t      
         IF ls_table_str.getIndexOf("b_",1)>0 AND ls_table_str.getIndexOf(".",1) = 0  THEN
            ##140429 抓主欄位
            LET l_m_field = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength())

            LET ls_table_str = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength()-3),"_t"
         ELSE 
            IF ls_table_str.getIndexOf(".",1)>0 THEN 
               ##140429 抓主欄位
               LET l_m_field = ls_table_str.subString(ls_table_str.getIndexOf(".",1)+1,ls_table_str.getLength())
               
               LET ls_table_str = ls_table_str.subString(1,ls_table_str.getIndexOf(".",1)-1)
            END IF
         END IF     
        ##判斷主欄位的屬性符合需要存組合欄位的屬性
         IF sadzp188_tab_chk_field_property(l_m_field,"C") THEN 
            IF NOT cl_null(ls_dzgb[ls_i].dzgb016) THEN 
               CALL adzp188_handle_combine_field(l_m_field,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017)
            END IF 
         END IF 
         LET ls_i = ls_i + 1
       END FOREACH 
      ###140430-(e)              
      
      
      ##將別名補入dzgc--(e) 
              
    ##樣板設定的數值 140118
    ##GR從4RP讀取
    ##XG從gzgf017讀出   

       CALL adzp188_tablesel_b_fill()           #資料表
       CALL adzp188_tablejoin_wclist_b_fill()   #連結
       CALL adzp188_filter_b_fill()             #篩選
                       
       RETURN li_cmd    
  END IF     ##150506  NO.150507-00002#1 add   
END FUNCTION



################################################################################
# Descriptions...: 取出table的FK資訊
# Memo...........: 
# Usage..........: CALL adzp188_tab_get_relation(ps_tableid,ps_type,ps_uptable)
# Input parameter: ps_tableid :要取的主要關注表編號
# Input parameter: ps_type 型態:FK
# Input parameter: ps_uptable :FK關注的上階表
# Return code....: li_cmd   修改
# Date & Author..: 2013/12/25
# Modify.........:
################################################################################
PUBLIC FUNCTION adzp188_tab_get_relation(ps_tableid,ps_type,ps_uptable)

   DEFINE ps_tableid  STRING    #要取的主要關注表編號(PK,FK)
   DEFINE ps_type     STRING    #型態 PK OR FK
   DEFINE ps_uptable  STRING    #FK關注的上階表
   DEFINE ls_str      STRING
   DEFINE ls_sql      STRING
   DEFINE lc_dzed004  LIKE dzed_t.dzed004   #FK欄位
   DEFINE lc_dzed006  LIKE dzed_t.dzed006   #對應主表的PK欄位
   DEFINE ls_site     STRING
   DEFINE ls_next     STRING
   DEFINE l_line      base.StringTokenizer
   DEFINE l_token     base.StringTokenizer
   DEFINE ls_temp     STRING
   DEFINE ls_err_msg  STRING 
   DEFINE lc_dzed004_r  STRING   #FK欄位
   DEFINE lc_dzed006_r  STRING    #對應主表的PK欄位

   LET ls_str = NULL

   #取得各資料表的FK
   #借用ls_next變數來擷取tableid去除_t的部分
   LET ls_next = ps_tableid
   LET ls_next = ls_next.subString(1,ls_next.getIndexOf("_t",1)-1)

   LET ls_sql = "SELECT dzed004,dzed006 FROM dzed_t",
                " WHERE dzed001='",ps_tableid CLIPPED,"' ",
                  #" AND dzed002 like '",ls_next.trim(),"_fk%' ",  #只抓取名稱為 _fk 的部分  #160328 test mark
                  " AND (dzed002 like '",ls_next.trim(),"_fk%' OR dzed002 like '",ls_next.trim(),"_fd%')",  #只抓取名稱為 _fk 的部分   #160328 test add
                  " AND dzed003='F' ",          #型式為 F
                  " AND dzed005='",ps_uptable CLIPPED,"'"
   PREPARE dzed_prep FROM ls_sql
   EXECUTE dzed_prep INTO lc_dzed004,lc_dzed006
   IF SQLCA.SQLCODE THEN
      #LET ls_err_msg = "ERROR: 需要的fk無法取得:",ps_tableid,"表與",ps_uptable,"表的fk不存在"
      LET ls_err_msg = ps_tableid
   END IF
   FREE dzed_prep
   LET lc_dzed004_r = lc_dzed004
   LET lc_dzed006_r = lc_dzed006
   
   RETURN lc_dzed004_r CLIPPED ,lc_dzed006_r CLIPPED ,ls_err_msg CLIPPED 
END FUNCTION 


################################################################################
# Descriptions...: 清除畫面、暫存檔、陣列相關資訊
# Memo...........: 
# Usage..........: CALL adzp188_clear_view()
# Input parameter: ps_tableid :要取的主要關注表編號
# Date & Author..: 2013/12/31
# Modify.........:
################################################################################
PUBLIC FUNCTION adzp188_clear_view()

   

   
   
   CALL g_tablesel.clear()
   CALL g_tablejoin1.clear()
   CALL g_tablejoin2.clear()
   CALL g_join.clear()
   CALL g_filter.clear()
   CALL g_fieldsel.clear()
   CALL g_join1.clear()
   CALL g_xg_grouplist.clear()
   CALL g_xg_groupsel.clear()
   CALL g_summarylist1.clear()
   CALL g_summarylist2.clear()
   CALL g_gr_grouplist1.clear()
   CALL g_gr_groupsel1.clear()   
   #CALL g_gr_grouplist2.clear()  ##150324 mark
   CALL g_gr_groupsel2.clear()   
   CALL g_typelist1.clear() 
   CALL g_typelist2.clear()
   CALL g_argsel.clear()
   
   #先將暫存檔清空
   CALL adzp188_delete_temptable()

   CALL adzp188_tablesel_b_fill()           #資料表
   CALL adzp188_tablejoin_wclist_b_fill()   #連結
   CALL adzp188_filter_b_fill()             #篩選
   CALL adzp188_xg_groupsel_b_fill()        #xg群組
   CALL adzp188_argsel_b_fill()             #參數
   CALL adzp188_fieldlist_b_fill()          #欄位list
   CALL adzp188_fieldsel_b_fill()           #已選欄位list
   CALL adzp188_gr_grouplist_b_fill()       #GR群組list
   CALL adzp188_gr_groupsel_b_fill()        #已選GR群組
   CALL adzp188_summary2_b_fill()           #彙總
   CALL adzp188_typelist1_b_fill()          #GR排版清單
   CALL adzp188_typelist2_b_fill()          #GR排版已選欄位清單
   CALL adzp188_xgtypelist1_b_fill()        #XG排版清單   140521
   CALL adzp188_xgtype_b_fill()             #XG排版交叉表 140521 

   LET g_dzga001 =""  
   LET g_gzza001 ="" 
   LET g_gzzo001 =""     
   LET g_dzga001_t =""
   LET g_signout_t = 0    #161215-00029#1 add 

   LET g_dzga_m.dzga001 = ""
   LET g_gzza001 = ""
   LET g_dzga_m.dzga003 = ""
   LET g_dzga_m.dzga004 = ""
   DISPLAY '' TO formonly.dzga001_desc
   DISPLAY '' TO formonly.gzza001_desc
   DISPLAY '' TO formonly.gzzo001_desc
   DISPLAY '0' TO formonly.arg
   LET g_alias_seq = 1
   DISPLAY '' TO formonly.dzga004_desc

   ##141127 add -(s)
   LET g_dzgd_d.dzgd003 = ""
   LET g_dzgd_d.dzgd005 = ""
   
  # CALL adzp188_set_table_comboitems("formonly.dzgd004_1", FALSE) RETURNING g_dzgd004_1  ##150212 mark
   #LET g_dzgd004_1 = "type_t"   #重設預設值  #160921-00012#1 mark
   #CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, FALSE) RETURNING g_dzgd004_2 ##150212 mark
   #LET g_dzgd004_2 = "chr30"     #重設預設值   #160921-00012#1 mark
   LET g_dzgd006_1 = "1"

   LET g_dzgf_d.dzgf004 = ""
   #LET g_dzgf_d.dzgf005 = ""
   LET g_dzgf_d.dzgf006 = ""
   LET g_dzgf_d.dzgf007 = ""
   LET g_dzgf_d.dzgf008 = ""   
   DISPLAY 'N' TO formonly.c_dzga009     #150525-00029#1 add
   #CALL adzp188_set_tablesel_comboitems("dzgf_t.dzgf005", TRUE)                                                  ##150212 mark
   #CALL adzp188_set_field_comboitems("dzgf_t.dzgf006", g_dzgf_d.dzgf005, TRUE) RETURNING g_dzgf_d.dzgf006        ##150212 mark 

   ##141127 add -(s)
   
   ##140527帶入畫面預設值
   CALL adzp188_set_init_data()
END FUNCTION 

## 140110 add -(s)------------------------



################################################################################
# Descriptions...: xg群組頁簽-樹狀欄位列表
# Memo...........: 
# Usage..........: CALL adzp188_xg_grouplist_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/01/10
# Modify.........:
################################################################################
FUNCTION adzp188_xg_grouplist_b_fill()
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lc_table DYNAMIC ARRAY OF RECORD 
          id           LIKE dzea_t.dzea001,
          name         LIKE dzeal_t.dzeal003,
          def          LIKE dzgc_t.dzgc006
          END RECORD
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004
   DEFINE lc_dzgc006   LIKE dzgc_t.dzgc006
   DEFINE lc_table_t   LIKE dzea_t.dzea001
   DEFINE lc_table_tmp LIKE dzea_t.dzea001
   DEFINE lc_tablename LIKE dzeal_t.dzeal003
   DEFINE l_def_cnt    LIKE type_t.num5
          
   CALL lc_table.clear()
   CALL g_xg_grouplist.clear()
   CALL g_summarylist1.clear()  #140113

   ##140206 舊版 mark -(s)
   LET li_cnt = 1
   LET lc_table_t = ' '   
   ##140113.........想嘸，先寫，先抓已選的欄位來倒找table，若自訂欄位則table以"自定欄位"
   #LET g_sql = " SELECT dzgc004,dzgc006 FROM adzp188_dzgc_tmp ", 
               #" WHERE dzgc001 = '",g_dzga_m.dzga001,"'",
               #" AND dzgc002 = '",g_dzga_m.dzga002,"'",
               #" ORDER BY dzgc006,dzgc004"
   #PREPARE xg_grouptable_pre FROM g_sql
   #DECLARE xg_grouptable_curs CURSOR FOR xg_grouptable_pre     
   #FOREACH xg_grouptable_curs INTO lc_dzgc004,lc_dzgc006
      #IF lc_dzgc006 = "N" THEN  #非自定義
      #
         #SELECT gztz001,dzeal003 INTO lc_table_tmp,lc_tablename FROM gztz_t 
         #LEFT OUTER JOIN dzeal_t ON dzeal001 = gztz001 AND dzeal002 = g_lang
         #WHERE gztz002 = lc_dzgc004 
         #
         #IF lc_table_tmp <> lc_table_t THEN 
             #LET lc_table[li_cnt].id = lc_table_tmp    
             #LET lc_table[li_cnt].NAME = lc_tablename
             #LET lc_table[li_cnt].def = lc_dzgc006
             #LET lc_table_t = lc_table_tmp
             #LET li_cnt = li_cnt + 1   
         #END IF 
      #ELSE 
        #IF lc_table_tmp <> lc_table_t THEN 
            #LET lc_table[li_cnt].id = "自定義"    
            #LET lc_table[li_cnt].NAME = "自定義欄位"    
            #LET lc_table[li_cnt].def = lc_dzgc006
            #LET lc_table_t = "自定義"
            #LET li_cnt = li_cnt + 1    
        #END IF        
      #END IF       
   #END FOREACH  
#
#
   ##用被選的資料表產生父節點, 子節點為各自所屬欄位
   #LET li_cnt = 1
    #FOR li_i = 1 TO lc_table.getLength()   
       #LET g_xg_grouplist[li_cnt].groupname = lc_table[li_i].id,":", lc_table[li_i].name
       #LET g_xg_grouplist[li_cnt].groupid = lc_table[li_i].id
       #LET g_xg_grouplist[li_cnt].groupexp = TRUE   #預設全開
       #LET g_xg_grouplist[li_cnt].groupisnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
#
       ##彙總畫面左邊的樹也是相同來源
       #LET g_summarylist1[li_cnt].summaryname1 = lc_table[li_i].id,":", lc_table[li_i].name
       #LET g_summarylist1[li_cnt].summaryid1 = lc_table[li_i].id
       #LET g_summarylist1[li_cnt].summaryexp1 = TRUE   #預設全開
       #LET g_summarylist1[li_cnt].summaryisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
       #
       #CALL adzp188_xg_grouplist_b_fill_child(lc_table[li_i].id, li_cnt,lc_table[li_i].def) RETURNING li_cnt
   #END FOR
   ##140206 舊版 mark -(e)


   ##140206 改新版 mark -(s)
   LET li_cnt = 1
    FOR li_i = 1 TO g_tablesel.getLength() 

       SELECT dzeal003 INTO lc_tablename FROM dzeal_t 
        WHERE dzeal001 = g_tablesel[li_i].id AND dzeal002 = g_lang 
    
       LET g_xg_grouplist[li_cnt].groupname = g_tablesel[li_i].id,":", lc_tablename
       LET g_xg_grouplist[li_cnt].groupid = g_tablesel[li_i].id
       LET g_xg_grouplist[li_cnt].groupexp = TRUE   #預設全開
       LET g_xg_grouplist[li_cnt].groupisnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線

       ##彙總畫面左邊的樹也是相同來源
       LET g_summarylist1[li_cnt].summaryname1 = g_tablesel[li_i].id,":", lc_tablename
       LET g_summarylist1[li_cnt].summaryid1 = g_tablesel[li_i].id
       LET g_summarylist1[li_cnt].summaryexp1 = TRUE   #預設全開
       LET g_summarylist1[li_cnt].summaryisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
        
       
       CALL adzp188_xg_grouplist_b_fill_child(g_tablesel[li_i].id, li_cnt,'N') RETURNING li_cnt
   END FOR 

   #判斷是否有自定義欄位
   SELECT COUNT(*) INTO l_def_cnt FROM adzp188_dzgc_tmp  
    WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
      AND dzgc006 ='Y'  
      #AND dzgc008 = g_cust AND dzgc009 = g_code_ide   #140613 add #141017 mark
      AND dzgc009 = g_code_ide   #141017 add
   IF l_def_cnt > 0 THEN
       LET g_xg_grouplist[li_cnt].groupname = "自定義" ,":", "自定義欄位" 
       LET g_xg_grouplist[li_cnt].groupid = "自定義"
       LET g_xg_grouplist[li_cnt].groupexp = TRUE   #預設全開
       LET g_xg_grouplist[li_cnt].groupisnode = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線

       #彙總畫面左邊的樹也是相同來源
       LET g_summarylist1[li_cnt].summaryname1 = "自定義" ,":", "自定義欄位" 
       LET g_summarylist1[li_cnt].summaryid1 = "自定義"
       LET g_summarylist1[li_cnt].summaryexp1 = TRUE   #預設全開
       LET g_summarylist1[li_cnt].summaryisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線
  
       
       CALL adzp188_xg_grouplist_b_fill_child("自定義", li_cnt,'Y') RETURNING li_cnt       
   END IF 
      
   ##140206 改新版 mark -(s)
END FUNCTION


################################################################################
# Descriptions...: XG群組頁簽-樹狀欄位列表(子節點)
# Memo...........: 
# Usage..........: CALL adzp188_xg_grouplist_b_fill_child(table_id, sn) RETURNING li_idx
# Input parameter: pc_dzea001   資料表
# ...............: pi_idx       最後節點位置
# ...............: p_def        自定義否
# Return code....: pi_idx       接下來的節點位置
# Date & Author..: 2014/01/10
# Modify.........:
################################################################################
FUNCTION adzp188_xg_grouplist_b_fill_child(pc_dzea001, pi_idx,p_def)
   DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE p_def        LIKE dzgc_t.dzgc006
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_prefix    STRING
   DEFINE lc_dzgc007   LIKE dzgc_t.dzgc007      #140606 add


   
   IF p_def = "N" THEN ##非自定義欄位 
       LET lc_prefix = pc_dzea001
       LET lc_prefix = lc_prefix.subString(1,lc_prefix.getIndexOf("_",1)-1) 

       LET g_sql = " SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp ",  ##140606 add dzgc007
                   "        LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                   " WHERE dzgc004 LIKE '",lc_prefix.trim(),"%'", " AND dzgc006 ='",p_def,"'",
                   #"   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",  #140923 elena mark
                   "   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",             #140923 elena add
                   #"   AND dzgc008 = '",g_cust,"' AND dzgc009 = '",g_code_ide,"'",         #140613 add  #141013 mark
                   "   AND dzgc009 = '",g_code_ide,"'",                                     #141013 add
                   " ORDER BY dzgc003 "
                   
       PREPARE xg_grouplist_b_fill_pre FROM g_sql
       DECLARE xg_grouplist_b_fill_curs CURSOR FOR xg_grouplist_b_fill_pre       
       LET pi_idx = pi_idx + 1
       FOREACH xg_grouplist_b_fill_curs INTO lc_dzgc004, lc_dzebl003,lc_dzgc007
      
          LET g_xg_grouplist[pi_idx].groupname = lc_dzgc004,":", lc_dzebl003
          LET g_xg_grouplist[pi_idx].groupid = lc_dzgc004
          LET g_xg_grouplist[pi_idx].grouppid = pc_dzea001
          LET g_xg_grouplist[pi_idx].groupexp = FALSE
          LET g_xg_grouplist[pi_idx].groupisnode = FALSE
          LET g_xg_grouplist[pi_idx].groupalias = lc_dzgc007

          ##彙總畫面左邊樹也是相同來源
          LET g_summarylist1[pi_idx].summaryname1 = lc_dzgc004,":", lc_dzebl003
          LET g_summarylist1[pi_idx].summaryid1 = lc_dzgc004
          LET g_summarylist1[pi_idx].summarypid1 = pc_dzea001
          LET g_summarylist1[pi_idx].summaryexp1 = FALSE
          LET g_summarylist1[pi_idx].summaryisnode1 = FALSE 
          LET g_summarylist1[pi_idx].summaryalias = lc_dzgc007          

          LET pi_idx = pi_idx + 1
       END FOREACH
   ELSE 

       LET g_sql = "SELECT dzgc004, dzebl003 FROM adzp188_dzgc_tmp",
                   " LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                   " WHERE dzgc006 ='",p_def,"'",
                   #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",   #140613 add #141013 mark
                   "   AND dzgc009 ='",g_code_ide,"'",   #140613 add
                   " ORDER BY dzgc004"
       PREPARE xg_grouplist_b_fill_pre1 FROM g_sql
       DECLARE xg_grouplist_b_fill_curs1 CURSOR FOR xg_grouplist_b_fill_pre1  
        LET pi_idx = pi_idx + 1 
        FOREACH xg_grouplist_b_fill_curs1 INTO lc_dzgc004, lc_dzebl003
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) THEN 
             SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
              WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                AND dzgd003 = lc_dzgc004
                #AND dzgd007 = g_cust AND dzgd008 = g_code_ide    #140613 add  #141013 mark
                AND dzgd008 = g_code_ide    #141013 add
          END IF         
          LET g_xg_grouplist[pi_idx].groupname = lc_dzgc004,":", lc_dzebl003
          LET g_xg_grouplist[pi_idx].groupid = lc_dzgc004
          LET g_xg_grouplist[pi_idx].grouppid = pc_dzea001
          LET g_xg_grouplist[pi_idx].groupexp = FALSE
          LET g_xg_grouplist[pi_idx].groupisnode = FALSE

          ##彙總畫面左邊樹也是相同來源
          LET g_summarylist1[pi_idx].summaryname1 = lc_dzgc004,":", lc_dzebl003
          LET g_summarylist1[pi_idx].summaryid1 = lc_dzgc004
          LET g_summarylist1[pi_idx].summarypid1 = pc_dzea001
          LET g_summarylist1[pi_idx].summaryexp1 = FALSE
          LET g_summarylist1[pi_idx].summaryisnode1 = FALSE          
          
          LET pi_idx = pi_idx + 1
       END FOREACH  
       
   END IF 
   RETURN pi_idx
END FUNCTION

################################################################################
# Descriptions...: XG群組頁簽-已挑選欄位列表
# Memo...........: 
# Usage..........: CALL adzp188_xg_groupsel_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/01/10
# Modify.........:
################################################################################
FUNCTION adzp188_xg_groupsel_b_fill()
   DEFINE lc_cnt       LIKE type_t.num5   
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_group     LIKE type_t.chr1
   DEFINE lc_sort      LIKE type_t.chr1
   DEFINE lc_paging    LIKE type_t.chr1
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE lc_dzge004   LIKE type_t.num5 
   DEFINE lc_dzge007   LIKE dzge_t.dzge007
   DEFINE li_cnt       LIKE type_t.num5  

   CALL g_xg_groupsel.clear()

   SELECT COUNT(*) INTO li_cnt FROM adzp188_gexg_tmp     #151012-00003#1 調整tmp名稱縮為17字元
   LET li_cnt = 1
   LET g_sql = "SELECT dzge006, dzebl003, group1, sort, paging,dzge004 FROM adzp188_gexg_tmp  ",     #151012-00003#1 調整tmp名稱縮為17字元 
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzge006 AND dzebl002 = '",g_lang,"'",  
               #" WHERE dzge001 ='",g_dzga_m.dzga001,"'", " AND dzge002 ='",g_dzga_m.dzga002,"'",   #140923 elena mark
               " WHERE dzge001 ='",g_dzga_m.dzga001,"'", " AND dzge002 ='",gs_ver,"'",              #140923 elena add
              # "   AND dzge008 ='",g_cust,"' AND dzge009 ='",g_code_ide,"'",      #140613 add      #141013 mark
               "   AND dzge009 ='",g_code_ide,"'",                                                  #141013 add            
               " ORDER BY dzge004"
   PREPARE xg_groupsel_b_fill_pre FROM g_sql 
   DECLARE xg_groupsel_b_fill_curs CURSOR FOR xg_groupsel_b_fill_pre
   FOREACH xg_groupsel_b_fill_curs INTO lc_dzge006, lc_dzebl003, lc_group, lc_sort, lc_paging,lc_dzge004
      ##若欄位說明null，代表是自定義欄位
      IF cl_null(lc_dzebl003) THEN 
         SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
          WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
            AND dzgd003 = lc_dzge006
            #AND dzgd007 = g_cust AND dzgd008 = g_code_ide        #140613 add  #141013 mark
            AND dzgd008 = g_code_ide        #141013 add
      END IF  
      LET g_xg_groupsel[li_cnt].dzge004 = lc_dzge004
      LET g_xg_groupsel[li_cnt].dzge006 = lc_dzge006 
      LET g_xg_groupsel[li_cnt].name = lc_dzebl003
      IF cl_null(lc_group) THEN 
         LET lc_group = 'N'
      END IF 
      LET g_xg_groupsel[li_cnt].group = lc_group
      LET g_xg_groupsel[li_cnt].sort = lc_sort
      IF cl_null(lc_paging) THEN 
         LET lc_paging = 'N'
      END IF 
      LET g_xg_groupsel[li_cnt].paging = lc_paging
      LET li_cnt = li_cnt + 1
   END FOREACH

END FUNCTION


##140122 -(s)
################################################################################
# Descriptions...: 彙總頁簽-已挑選欄位樹狀
# Memo...........: 
# Usage..........: CALL adzp188_summary2_default()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/01/22
# Modify.........:
################################################################################
FUNCTION adzp188_summary2_default()
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_gzgg_cnt   LIKE type_t.num5
   DEFINE lc_type      LIKE type_t.chr1 
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004 
   DEFINE lc_dzeb007   LIKE dzeb_t.dzeb007
   DEFINE lc_dzge006_t LIKE dzge_t.dzge006
   DEFINE lc_dzgc007   LIKE dzgc_t.dzgc007   ##140606 add
   DEFINE l_k          LIKE type_t.num5      #141013 add

   

   CALL g_summarylist2.clear()
   DELETE FROM adzp188_sum2_tmp

   LET g_sql = " INSERT INTO adzp188_sum2_tmp ",                    
               "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
   PREPARE adzp188_sum2_tmp_ins_pre1 FROM g_sql

   
   LET li_cnt = 1
   LET g_sql = " SELECT dzge006 FROM adzp188_gexg_tmp  ",      #151012-00003#1 調整tmp名稱縮為17字元
               #" WHERE dzge001 ='",g_dzga_m.dzga001,"'", " AND dzge002 ='",g_dzga_m.dzga002,"'",    #140923 elena mark
               " WHERE dzge001 ='",g_dzga_m.dzga001,"'", " AND dzge002 ='",gs_ver,"'",               #140923 elena add
               #"   AND dzge008 ='",g_cust,"' AND dzge009 ='",g_code_ide,"'",                        ##140613 add  #141013 mark
               "   AND dzge009 ='",g_code_ide,"'",                                                   ##141013 add
               "   AND group1 ='Y'",           
               " ORDER BY dzge004"
   PREPARE summarylist2_pre FROM g_sql 
   DECLARE summarylist2_curs CURSOR FOR summarylist2_pre
   FOREACH summarylist2_curs INTO lc_dzge006
      IF li_cnt = 1 THEN 
          ##141013 mark -(s)
          #INSERT INTO adzp188_sum2_tmp
             #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, lc_dzge006, '0', '6', 1,'',g_cust,g_code_ide)  ##140606 add''  #140613 add ,g_cust,g_code_ide  
          ##141013 mark -(e)
          ##141013 add -(s)
          LET l_k = 1   
          EXECUTE adzp188_sum2_tmp_ins_pre1 USING lc_dzge006, '0', '6', l_k,'',g_cust,g_code_ide  
          ##141013 add -(e)    
      ELSE 
          ##141013 mark -(s)
          #INSERT INTO adzp188_sum2_tmp
             #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, lc_dzge006, lc_dzge006_t, '6',1,'',g_cust,g_code_ide)  ##140606 add''  #140613 add ,g_cust,g_code_ide  
          #141013 mark -(e)  
          ##141013 add -(s)  
          LET l_k = 1 
          EXECUTE adzp188_sum2_tmp_ins_pre1 USING lc_dzge006, lc_dzge006_t, '6',l_k ,'',g_cust,g_code_ide   
          ##141013 add -(e)  
      END IF 
      LET li_cnt = li_cnt + 1  
      LET l_gzgg_cnt = 0    
      ##140606 mark -(s)
      #SELECT count(*) INTO l_gzgg_cnt FROM gzgg_t 
      #WHERE gzggent = g_enterprise AND gzgg000 = g_gzgf000
        #AND gzgg002 = g_lang AND gzgg009 <> '6'  
      ##140606 mark -(e)
      ##140606 add -(s)
      SELECT COUNT(*) INTO l_gzgg_cnt FROM dzgl_t 
      WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002  
        AND dzgl003 = g_dzga_m.dzga001 AND dzgl011 <> '6' 
        #AND dzgl029 = g_cust AND dzgl030 = g_code_ide                      #140613 add  #141013 mark
        AND dzgl030 = g_code_ide                                           #141013 add  
      ##140606 add -(e)
     
      IF l_gzgg_cnt > 0 THEN    #已有存彙總    
         ##140605 mark -(s)            
         #LET g_sql =" SELECT gzgg001,gzgg009 FROM gzgg_t ",
                    #" WHERE gzggent ='", g_enterprise,"'"," AND gzgg000 = '",g_gzgf000,"'",
                    #" AND gzgg002 = '",g_lang,"' AND gzgg009 <> '6'",
                    #" ORDER BY gzgg004 "
          ##140605 mark -(e)
          ##140605 add -(s)
         LET g_sql =" SELECT dzgl005,dzgl011,dzgl027 FROM dzgl_t ",  ##140606 add dzgl027
                   # " WHERE dzgl001 = '",g_dzga_m.dzga001,"' AND dzgl002 ='",g_dzga_m.dzga002,"'",  #141013 mark
                    " WHERE dzgl001 = '",g_dzga_m.dzga001,"' AND dzgl002 ='",gs_ver,"'",             #141013 add
                    " AND dzgl003 = '",g_dzga_m.dzga001,"' AND dzgl011 <> '6'", 
                   # " AND dzgl029 ='",g_cust,"' AND dzgl030 ='",g_code_ide ,"'",          #140613 add  #141013 mark
                    " AND dzgl030 ='",g_code_ide ,"'",                    #141013 add
                   " ORDER BY dzgl004 "
          ##140605 add -(e)
                    
      ELSE    
         ##先將選出的欄位是數值的全放入彙總樹狀2   ##140122
         ##'0'是指總和，先預設都給總和
         LET g_sql = " SELECT dzgc004,'0',dzgc007 FROM adzp188_dzgc_tmp",   ##140606 add dzgc007
                     # " WHERE dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",  #140923 elena mark
                      " WHERE dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",             #140923 elena add
                      #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",                       #140613 add  #141013 mark
                      "    AND dzgc009 ='",g_code_ide,"'",                                                    #141013 add
                      " ORDER BY dzgc003"
      END IF 
      PREPARE summarysel_b_fill_pre FROM g_sql
      DECLARE summarysel_b_fill_curs CURSOR FOR summarysel_b_fill_pre                   
      FOREACH summarysel_b_fill_curs INTO lc_dzgc004,lc_type,lc_dzgc007   ##140606 add lc_dzgc007
          SELECT dzeb007 INTO lc_dzeb007 FROM dzeb_t WHERE dzeb002 = lc_dzgc004
          IF lc_dzeb007 = "number" AND lc_dzgc004 <> lc_dzge006 THEN  #140112 先只做數字型態，搭配(總和) , 也不能於父節點     
            ##141013 mark -(s)
            #INSERT INTO adzp188_sum2_tmp
              #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, lc_dzgc004, lc_dzge006, lc_type,0,lc_dzgc007,g_cust,g_code_ide) ##140606 add lc_dzgc007  #140613 add,g_cust,g_code_ide
            ##141013 mark -(e) 
            ##141013 add -(s) 
            LET l_k = 0  
            EXECUTE adzp188_sum2_tmp_ins_pre1 USING lc_dzgc004, lc_dzge006, lc_type,l_k,lc_dzgc007,g_cust,g_code_ide
            ##141013 add -(e) 
            LET li_cnt = li_cnt + 1
          END IF 
      END FOREACH  
      ##存前一父層
      LET lc_dzge006_t = lc_dzge006       
   END FOREACH

    #summary2畫面樣版資料
   LET g_sql = " SELECT id2,dzebl003,type2,pidseq2,alias FROM adzp188_sum2_tmp ",   #140606 add alias   
               "   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_lang,"'",              
               " WHERE dzgb001 =? AND dzgb002=? AND pid2 = ? ",
               #"   AND cust =? AND ide = ?",                                         #140613 add  #141013 mark
               "   AND ide = ?",                                                      #141013 add   
               " ORDER BY pidseq2,id2 "

   PREPARE adzp188_summary_getid_pre FROM g_sql
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       EXIT PROGRAM
   END IF
   DECLARE adzp188_summary_getid_cs1 CURSOR FOR adzp188_summary_getid_pre



     #typelist2畫面樣版資料
   #LET g_sql = " SELECT id2,dzebl003,pidseq2,idseq2 FROM adzp188_type2_tmp ",
               #"   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_lang,"'", 
               #" WHERE dzgb001 =? AND dzgb002=? AND pid2 = ?",
               #" ORDER BY pidseq2, seq2 "
#
   #PREPARE adzp188_typelist2_getid_pre FROM g_sql
   #IF SQLCA.sqlcode THEN
       #CALL cl_err('PREPARE:',SQLCA.sqlcode,1)
       #EXIT PROGRAM
   #END IF
   #DECLARE adzp188_typelist2_getid_cs1 CURSOR FOR adzp188_typelist2_getid_pre 
   
END FUNCTION




################################################################################
# Descriptions...: XG彙總頁簽-已挑選欄位樹狀
# Memo...........: 
# Usage..........: CALL adzp188_xg_summarylist2_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/01/22
# Modify.........:
################################################################################
FUNCTION adzp188_summary2_b_fill()
   DEFINE lc_cnt       LIKE type_t.num5   
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_id2       LIKE type_t.chr20
   DEFINE lc_pid2      LIKE type_t.chr20
   DEFINE lc_exp2      LIKE type_t.chr10
   DEFINE lc_isnode2   LIKE type_t.chr10
   DEFINE lc_type2     LIKE type_t.chr1 
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_type_str   STRING 
   DEFINE lc_alias     LIKE dzgc_t.dzgc007   ##140606 add
  

   CALL g_summarylist2.clear()
   LET g_sum_idx = 1
   LET li_cnt = 1
   LET lc_dzebl003 =''                       #150212 add
   LET g_sql = " SELECT id2, dzebl003, type2,alias FROM adzp188_sum2_tmp ",                  
               "   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_lang,"'",        
               #" WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",g_dzga_m.dzga002,"'",       #140923 elena mark
               " WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",gs_ver,"'",                  #140923 elena add
               " AND pid2 ='0'",
               #" AND cust ='",g_cust,"' AND ide ='",g_code_ide,"'"    #140613 add   #141017 mark
               " AND ide ='",g_code_ide,"'"    #141017 add 
   PREPARE summarylist2_b_fill_pre FROM g_sql 
   DECLARE summarylist2_b_fill_curs CURSOR FOR summarylist2_b_fill_pre
   FOREACH summarylist2_b_fill_curs INTO lc_id2, lc_dzebl003, lc_type2,lc_alias
         
           LET l_type_str = ""
           CASE lc_type2
              WHEN '0'
                LET l_type_str = "總和"
              WHEN '1'
                LET l_type_str = "最小值" 
              WHEN '2'
                LET l_type_str = "最大值"
              WHEN '3'
                LET l_type_str = "數量"    
              WHEN '4'
                LET l_type_str = "平均"                
           END CASE 
         
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) OR lc_dzebl003 IS NULL THEN  #150212 add OR  lc_dzebl003 IS NULL
             SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
              WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                AND dzgd003 = lc_id2
                #AND dzgd007 = g_cust AND dzgd008 = g_code_ide   #140613 add  #150212 mark
                AND dzgd008 = g_code_ide                                      #150212 add
          END IF 
           
           LET g_summarylist2[g_sum_idx].summaryname2 = lc_id2,":",lc_dzebl003
           LET g_summarylist2[g_sum_idx].summaryid2 = lc_id2 
           LET g_summarylist2[g_sum_idx].summaryexp2 = TRUE  #開
           LET g_summarylist2[g_sum_idx].summaryisnode2 = TRUE  #沒有欄位了  
           LET g_summarylist2[g_sum_idx].summarytype2 = lc_type2
           LET g_summarylist2[g_sum_idx].summaryalias2 = lc_alias    
           
           CALL adzp188_summary2_b_fill_child(g_summarylist2[g_sum_idx].summaryid2,g_sum_idx) 

   END FOREACH
 
END FUNCTION



################################################################################
# Descriptions...: XG彙總頁簽-已挑選欄位樹狀下一層
# Memo...........: 
# Usage..........: CALL adzp188_summary2_b_fill_child(g_summarylist2[li_cnt].id,li_cnt)
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/01/22
# Modify.........:
################################################################################
FUNCTION adzp188_summary2_b_fill_child(ps_pid,ps_cnt)
   DEFINE ps_pid       LIKE type_t.chr20 
   DEFINE ps_cnt       LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_id2       LIKE type_t.chr20
   DEFINE lc_type2     LIKE type_t.chr1 
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_type_str   STRING 
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_summary_data DYNAMIC ARRAY OF RECORD 
            id2        VARCHAR(20),
            dzebl003   LIKE dzebl_t.dzebl003,
            type2      VARCHAR(1),
            pidseq2    INTEGER,
            alias      VARCHAR(15)  #140606 add 
            END RECORD 
                

   #在FOREACH中直接使用recursive,資料會錯亂,所以先將資料放到陣列後處理
   LET li_cnt = 1
   CALL l_summary_data.clear()
   #FOREACH adzp188_summary_getid_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,ps_pid INTO l_summary_data[li_cnt].*  #140613mark
   #FOREACH adzp188_summary_getid_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,ps_pid,g_cust,g_code_ide INTO l_summary_data[li_cnt].*  #140613add  #141013 mark
   FOREACH adzp188_summary_getid_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,ps_pid,g_code_ide INTO l_summary_data[li_cnt].*  #141013add
      ##150212 add -(s)  
        ##若欄位說明null，代表是自定義欄位
      IF cl_null(l_summary_data[li_cnt].dzebl003) OR l_summary_data[li_cnt].dzebl003 IS NULL THEN  
         SELECT dzgd005 INTO l_summary_data[li_cnt].dzebl003 FROM adzp188_dzgd_tmp
          WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
            AND dzgd003 = l_summary_data[li_cnt].id2
            AND dzgd008 = g_code_ide                                      
      END IF 
      ##150212 add -(e) 
      ##150818-00025 #1 mark -(s)
      #IF SQLCA.sqlcode THEN
          #INITIALIZE g_errparam TO NULL
          #LET g_errparam.code = SQLCA.sqlcode
          #LET g_errparam.extend = 'FOREACH:'
          #LET g_errparam.popup = TRUE
          #CALL cl_err()
          #EXIT FOREACH
      #END IF
      ##150818-00025 # mark -(e)
      LET li_cnt = li_cnt + 1
   END FOREACH

   CALL l_summary_data.deleteElement(li_cnt)
   LET li_cnt = li_cnt - 1

   FOR l_i = 1 TO li_cnt
           LET l_type_str = ""
           CASE l_summary_data[l_i].type2
              WHEN '0'
                LET l_type_str = "總和"
              WHEN '1'
                LET l_type_str = "最小值" 
              WHEN '2'
                LET l_type_str = "最大值"
              WHEN '3'
                LET l_type_str = "數量"    
              WHEN '4'
                LET l_type_str = "平均"                
           END CASE 
           LET g_sum_idx = g_sum_idx + 1
           IF l_summary_data[l_i].pidseq2 < 1 THEN  #不需細展
              LET g_summarylist2[g_sum_idx].summaryexp2 = FALSE  #不開
              LET g_summarylist2[g_sum_idx].summaryisnode2 = FALSE #沒有欄位了
              LET g_summarylist2[g_sum_idx].summaryname2 = l_summary_data[l_i].id2,":",l_summary_data[l_i].dzebl003,"(",l_type_str,")"
           ELSE 
              LET g_summarylist2[g_sum_idx].summaryname2 = l_summary_data[l_i].id2,":",l_summary_data[l_i].dzebl003
              LET g_summarylist2[g_sum_idx].summaryexp2 = TRUE   #開
              LET g_summarylist2[g_sum_idx].summaryisnode2 = TRUE #有欄位了
           END IF 
           LET g_summarylist2[g_sum_idx].summaryid2 = l_summary_data[l_i].id2 
           LET g_summarylist2[g_sum_idx].summarypid2 = ps_pid          
           LET g_summarylist2[g_sum_idx].summarytype2 = l_summary_data[l_i].type2
           LET g_summarylist2[g_sum_idx].summarypidseq2 = l_summary_data[l_i].pidseq2
           LET g_summarylist2[g_sum_idx].summaryalias2 = l_summary_data[l_i].alias
           IF l_summary_data[l_i].pidseq2 > 0 THEN
              CALL adzp188_summary2_b_fill_child(g_summarylist2[g_sum_idx].summaryid2,g_sum_idx) 
              
           END IF       
   END FOR 

END FUNCTION

##140122 -(e)


################################################################################
# Descriptions...: XG群組頁簽-已挑選欄位預設資料
# Memo...........: 
# Usage..........: CALL adzp188_xg_groupsel_default()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/01/14
# Modify.........:
################################################################################
FUNCTION adzp188_xg_groupsel_default()
   DEFINE lc_gzgf014     LIKE gzgf_t.gzgf014
   DEFINE lc_gzgf015     LIKE gzgf_t.gzgf015
   DEFINE lc_gzgf016     LIKE gzgf_t.gzgf016
   DEFINE l_group_tmp    STRING 
   DEFINE l_sort_tmp     STRING
   DEFINE l_paging_tmp   STRING  
   DEFINE ls_group_token  base.StringTokenizer
   DEFINE ls_sort_token   base.StringTokenizer
   DEFINE ls_paging_token base.StringTokenizer
   DEFINE l_group        STRING 
   DEFINE l_sort         STRING
   DEFINE l_paging       STRING
   DEFINE lc_cnt         LIKE type_t.num5   
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_group     LIKE type_t.chr1
   DEFINE lc_sort      LIKE type_t.chr1
   DEFINE lc_paging    LIKE type_t.chr1
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE lc_dzge004   LIKE type_t.num5 
   DEFINE lc_dzge007   LIKE dzge_t.dzge007
   DEFINE li_cnt       LIKE type_t.num5 
 

   ##141013 add -(s)   
   LET g_sql = " INSERT INTO adzp188_gexg_tmp   ",       #151012-00003#1 調整tmp名稱縮為17字元               
               " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
   PREPARE adzp188_gexg_tmp_ins1_pre FROM g_sql  #151012-00003#1 調整tmp名稱縮為17字元
   #141013 add -(e)
   CALL g_xg_groupsel.clear()  

   SELECT gzgf014,gzgf015,gzgf016 INTO lc_gzgf014, lc_gzgf015, lc_gzgf016 FROM gzgf_t
   WHERE gzgfstus ='Y' and gzgf000 = g_gzgf000 AND gzgf003 = g_gzgf003  #140613 add AND g_dzgf003 = g_gzgf003

   LET l_group_tmp =  lc_gzgf014
   LET l_sort_tmp  =  lc_gzgf015
   LET l_paging_tmp = lc_gzgf016
   LET li_cnt = 1     
   LET lc_cnt = 0  
   #先做sort應該一定會設sort，sort個數最多
   LET ls_sort_token = base.StringTokenizer.create(l_sort_tmp.trim(), ',')
   WHILE ls_sort_token.hasMoreTokens()  
         LET l_sort = ls_sort_token.nextToken() 
         LET lc_dzge006 = l_sort
         SELECT COUNT(*) INTO lc_cnt FROM adzp188_gexg_tmp   WHERE dzge006 = lc_dzge006   #151012-00003#1 調整tmp名稱縮為17字元
            AND dzge001 = g_dzga_m.dzga001 AND dzge002 =g_dzga_m.dzga002 
            #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add
            AND dzge009 = g_code_ide  #141013 add
         
         IF lc_cnt = 0 THEN 
           ##141013 mark -(s)
           #INSERT INTO adzp188_gexg_tmp  ( dzge001,dzge002,dzge006, group1, sort, paging, dzge004,dzge008,dzge009) #140613 add
                  #VALUES(g_dzga_m.dzga001,g_dzga_m.dzga002, lc_dzge006, '', '1', '', li_cnt,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
           ##141013 mark -(e)       
           EXECUTE adzp188_gexg_tmp_ins1_pre USING  lc_dzge006, '', '1', '', li_cnt,g_cust,g_code_ide ##141013 add      #151012-00003#1 調整tmp名稱縮為17字元  
           LET li_cnt = li_cnt + 1      
         ELSE 
           UPDATE adzp188_gexg_tmp   SET sort = '1'   #151012-00003#1 調整tmp名稱縮為17字元
                  WHERE dzge006 = lc_dzge006 
                    AND dzge001 = g_dzga_m.dzga001 AND dzge002 =g_dzga_m.dzga002 
                    #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add  ##141013 mark
                    AND dzge009 = g_code_ide                        ##141013 add
                                       
         END IF          
   END WHILE

   
   LET ls_group_token = base.StringTokenizer.create(l_group_tmp.trim(), ',')
   LET lc_cnt = 0  
   WHILE ls_group_token.hasMoreTokens()  
         LET l_group = ls_group_token.nextToken() 
         LET lc_dzge006 = l_group
         SELECT COUNT(*) INTO lc_cnt FROM adzp188_gexg_tmp   WHERE dzge006 = lc_dzge006   #151012-00003#1 調整tmp名稱縮為17字元
            AND dzge001 = g_dzga_m.dzga001 AND dzge002 =g_dzga_m.dzga002 
            #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add   #141013 mark
            AND dzge009 = g_code_ide  #141013 add
         IF lc_cnt = 0 THEN 
           ##141013 mark -(s)
           #INSERT INTO adzp188_gexg_tmp  (dzge001,dzge002,dzge006, group1, sort, paging, dzge004,dzge008,dzge009) #140613 add cust,ide
                  #VALUES(g_dzga_m.dzga001,g_dzga_m.dzga002,lc_dzge006, 'Y', '', '', li_cnt,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
           ##141013 mark -(e)       
           EXECUTE adzp188_gexg_tmp_ins1_pre USING lc_dzge006, 'Y', '', '', li_cnt,g_cust,g_code_ide     #141013 add   #151012-00003#1 調整tmp名稱縮為17字元  
           LET li_cnt = li_cnt + 1      
         ELSE 
           UPDATE adzp188_gexg_tmp   SET group1 = 'Y'  #151012-00003#1 調整tmp名稱縮為17字元
                  WHERE dzge006 = lc_dzge006
                    AND dzge001 = g_dzga_m.dzga001 AND dzge002 =g_dzga_m.dzga002 
                    #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add  #141013 mark
                    AND dzge009 = g_code_ide                                     ##141013 add 
                                     
         END IF          
   END WHILE 
   
   LET ls_paging_token = base.StringTokenizer.create(l_paging_tmp.trim(), ',')
   LET lc_cnt = 0  
   WHILE ls_paging_token.hasMoreTokens()  
         LET l_paging = ls_paging_token.nextToken()
         LET lc_dzge006 = l_paging
         SELECT count(*) INTO lc_cnt FROM adzp188_gexg_tmp   WHERE dzge006 = lc_dzge006  #151012-00003#1 調整tmp名稱縮為17字元
           AND dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 
           #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add    #141013 mark
           AND dzge009 = g_code_ide                                       ##141013 add  
                     
         IF lc_cnt = 0 THEN 
           ##141013 mark -(s)
           #INSERT INTO adzp188_gexg_tmp  (dzge001,dzge002,dzge006, group1, sort, paging, dzge004,dzge008,dzge009)  #140613 add cust,ide
                  #VALUES(g_dzga_m.dzga001,g_dzga_m.dzga002,lc_dzge006, '', '', 'Y', li_cnt,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
           ##141013 mark -(e)
           EXECUTE adzp188_gexg_tmp_ins1_pre USING lc_dzge006, '', '', 'Y', li_cnt,g_cust,g_code_ide  ##141013 add     #151012-00003#1 調整tmp名稱縮為17字元   
           LET li_cnt = li_cnt + 1      
         ELSE 
           UPDATE adzp188_gexg_tmp   SET paging = 'Y'    #151012-00003#1 調整tmp名稱縮為17字元
                  WHERE dzge006 = lc_dzge006
                    AND dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 
                    #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add  ##141013 mark
                    AND dzge009 = g_code_ide                        ##141013 add -(e)      
                                       
         END IF          
   END WHILE  

   
END FUNCTION


################################################################################
# Descriptions...: GR群組頁簽-萃取已挑選欄位列表
# Memo...........: 
# Usage..........: CALL adzp188_groupsel_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24
# Modify.........:
################################################################################
FUNCTION adzp188_gr_groupsel_b_fill()
   DEFINE lc_dzge003   LIKE dzge_t.dzge003
   DEFINE lc_dzge004   LIKE dzge_t.dzge004
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_dzge005   LIKE dzge_t.dzge005
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE lc_dzge007   LIKE dzge_t.dzge007
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_dzge_cnt   LIKE type_t.num5
   DEFINE lc_dzeb002_str STRING 
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002


   LET lc_dzge006 = ''
   LET lc_dzebl003 = ''
   LET lc_dzge005 = '' 
   LET lc_dzge007 = ''
   LET lc_dzge003 = '' 
   LET lc_dzge004 = 0    
   CALL g_gr_groupsel1.clear()
   CALL g_gr_groupsel2.clear()
   
   LET g_sql = "SELECT dzge003,dzge004,dzge006, dzebl003, dzge005,dzge007 FROM adzp188_dzge_tmp",
               "  LEFT OUTER JOIN dzebl_t ON dzebl001 = dzge006 AND dzebl002 = '",g_lang,"'",
               #" WHERE dzge001 = '", g_dzga_m.dzga001,"' AND dzge002 = '", g_dzga_m.dzga002,"'",                #140923 elena mark
               " WHERE dzge001 = '", g_dzga_m.dzga001,"' AND dzge002 = '", gs_ver,"'",                           #140923 elena add
               "   AND dzge003 = ?",
               #"   AND dzge008 = ? AND dzge009 = ?", #140613 add  #141013 mark
               "   AND dzge009 = ?", #141013 add
               " ORDER BY dzge004"
   PREPARE gr_groupsel_b_fill_pre FROM g_sql
   DECLARE gr_groupsel1_b_fill_curs CURSOR FOR gr_groupsel_b_fill_pre
   ##g_gr_groupsel1 萃取
   LET li_cnt = 1
  # FOREACH gr_groupsel1_b_fill_curs USING '1' INTO lc_dzge003,lc_dzge004,lc_dzge006, lc_dzebl003, lc_dzge005, lc_dzge007  #140613 mark
   #FOREACH gr_groupsel1_b_fill_curs USING '1',g_cust,g_code_ide INTO lc_dzge003,lc_dzge004,lc_dzge006, lc_dzebl003, lc_dzge005, lc_dzge007 #140613 add #141013 mark
   FOREACH gr_groupsel1_b_fill_curs USING '1',g_code_ide INTO lc_dzge003,lc_dzge004,lc_dzge006, lc_dzebl003, lc_dzge005, lc_dzge007 #141013 add
        #140714 add -(s)
        ##若欄位說明null，代表是自定義欄位
        IF cl_null(lc_dzebl003) THEN 
           SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
            WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002   
              AND dzgd003 = lc_dzge006 AND dzgd008 = g_code_ide
        END IF
       #140714 add -(e) 
        LET g_gr_groupsel1[li_cnt].dzge006 = lc_dzge006 
        LET g_gr_groupsel1[li_cnt].dzge006_desc = lc_dzebl003
        LET g_gr_groupsel1[li_cnt].dzge007 = lc_dzge007
        LET g_gr_groupsel1[li_cnt].dzge003 = lc_dzge003
        LET g_gr_groupsel1[li_cnt].dzge004 = lc_dzge004
      LET li_cnt = li_cnt + 1
   END FOREACH
   LET lc_dzge006 = ''
   LET lc_dzebl003 = ''
   LET lc_dzge005 = '' 
   LET lc_dzge007 = ''
   LET lc_dzge003 = '' 
   LET lc_dzge004 = 0 
   ##g_gr_groupsel2 印出
   LET li_cnt = 1
   #FOREACH gr_groupsel1_b_fill_curs USING '2' INTO  lc_dzge003,lc_dzge004,lc_dzge006, lc_dzebl003, lc_dzge005, lc_dzge007  #140613 mark
   #FOREACH gr_groupsel1_b_fill_curs USING '2',g_cust,g_code_ide INTO lc_dzge003,lc_dzge004,lc_dzge006, lc_dzebl003, lc_dzge005, lc_dzge007 #140613 add  #141013 mark
   FOREACH gr_groupsel1_b_fill_curs USING '2',g_code_ide INTO lc_dzge003,lc_dzge004,lc_dzge006, lc_dzebl003, lc_dzge005, lc_dzge007 #141013 add 
        #140714 add -(s)
        ##若欄位說明null，代表是自定義欄位
        IF cl_null(lc_dzebl003) THEN 
           SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
            WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002            
              AND dzgd003 = lc_dzge006 AND dzgd008 = g_code_ide
        END IF
       #140714 add -(e)    
        LET g_gr_groupsel2[li_cnt].dzge006 = lc_dzge006 
        LET g_gr_groupsel2[li_cnt].dzge006_desc = lc_dzebl003
        LET g_gr_groupsel2[li_cnt].dzge007 = lc_dzge007
        LET g_gr_groupsel2[li_cnt].dzge003 = lc_dzge003
        LET g_gr_groupsel2[li_cnt].dzge004 = lc_dzge004
      LET li_cnt = li_cnt + 1
   END FOREACH
   IF NOT cl_null(lc_dzge005) THEN  
      LET g_dzge005 =lc_dzge005
   END IF 
   DISPLAY g_dzge005 TO formonly.r_dzge005

 

END FUNCTION


################################################################################
# Descriptions...: 群組頁簽-維護群細明細及設定值
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzge_xg(g_detaillist_idx, "add")
# Input parameter: pi_idx       s_grouplist/s_groupsel上focus的行數
# ...............: ps_type      add新增/upd修改/del刪除
# Return code....: None
# Date & Author..: 2014/01/14
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzge_xg(pi_idx, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE lc_dzge006_t LIKE dzge_t.dzge006            ##140512 add
   DEFINE ls_temp      LIKE type_t.num5               ##140512 add
   DEFINE l_k          LIKE type_t.num5               ##141013 add 
   DEFINE l_pid2       LIKE dzge_t.dzge006            ##141211 add


   CASE ps_type
      WHEN "add"
         #檢查單頭是否存入, 若還未存入必須先INSERT單頭
         #dzga_t count IS NULL, INSERT INTO dzga_t

         
             #找出最大序號
             SELECT MAX(dzge004) + 1 INTO g_dzge_xg_d.dzge004 FROM adzp188_gexg_tmp   #151012-00003#1 調整tmp名稱縮為17字元
              WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613 add   ##141013 mark
                AND dzge009 = g_code_ide                        ##141013 add  
                           
             IF cl_null(g_dzge_xg_d.dzge004)  THEN
                LET g_dzge_xg_d.dzge004 = 1
             END IF
             ##141013 add -(s) 
             LET g_sql = "INSERT INTO adzp188_sum2_tmp ",
                         "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)"  #140613 add ?,?
             PREPARE adzp188_sum2_tmp_ins_pre FROM g_sql
            ##141013 add -(s)
             
             LET g_sql = "INSERT INTO adzp188_gexg_tmp   ",  #151012-00003#1 調整tmp名稱縮為17字元
                         "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)"  #140613 add ?,?
             PREPARE adzp188_gexg_tmp_ins_pre FROM g_sql

             #由s_xg_grouplist新增進入, 可能為多選新增
             FOR pi_idx = 1 TO g_xg_grouplist.getLength()
                 IF gdig_curr.isRowSelected("s_xg_grouplist", pi_idx) THEN
                    #如果是點在table節點上, 批次新增所有欄位
                    IF g_xg_grouplist[pi_idx].groupisnode THEN
                       #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = pi_idx + 1 TO g_xg_grouplist.getLength()
                           IF NOT g_xg_grouplist[li_i].groupisnode THEN
                             IF adzp188_chk_field_exist("s_xg_groupsel",g_xg_grouplist[li_i].groupid,'') THEN 
                                  LET g_dzge_xg_d.dzge006 = g_xg_grouplist[li_i].groupid
                                  LET g_dzge_xg_d.group = 'Y' #group
                                  LET g_dzge_xg_d.sort = 1 #sort 
                                  LET g_dzge_xg_d.paging = 'N' #paging      
                                  
                                  EXECUTE adzp188_gexg_tmp_ins_pre USING g_dzge_xg_d.dzge006, g_dzge_xg_d.group,g_dzge_xg_d.sort,   #151012-00003#1 調整tmp名稱縮為17字元
                                                                            g_dzge_xg_d.paging,g_dzge_xg_d.dzge004, g_cust,g_code_ide #140613 add ,g_cust,g_code_ide 

                                  ##140326 增加彙總 -(s) 
                                  ##140512舊版 -(s)
                                  ##INSERT INTO adzp188_sum2_tmp
                                         ##VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzge_xg_d.dzge006, '0', '6', 1)   
                                  ##140512舊版 -(e)

                                  ##141211 mark -調整存入sum2_tmp的方式(s)
                                  ##140512新版 -(s)                                  
                                  #IF ls_temp = 0 THEN 
                                    ##父節點
                                    ##141013 mark -(s)
                                    ##INSERT INTO adzp188_sum2_tmp
                                         ##VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzge_xg_d.dzge006, '0', '6', 1,g_xg_grouplist[li_i].groupalias,g_cust,g_code_ide) #140613 add g_cust,g_code_ide
                                    ##141013 mark -(e)
                                    ##141013 add -(s)
                                    #LET l_k = 1      
                                    #EXECUTE adzp188_sum2_tmp_ins_pre USING g_dzge_xg_d.dzge006, '0', '6', l_k,g_xg_grouplist[li_i].groupalias,g_cust,g_code_ide            ##141013 add
                                    ##1401013 add -(e)
                                    #LET ls_temp = 1
                                  #ELSE 
                                      ##子節點需再存父節點
                                      ##141013 mark -(s)
                                      ##INSERT INTO adzp188_sum2_tmp
                                         ##VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzge_xg_d.dzge006, lc_dzge006_t, '6',1,g_xg_grouplist[li_i].groupalias,g_cust,g_code_ide) #140613 add g_cust,g_code_ide
                                      ##141013 mark -(e) 
                                      ##141013 add -(s)   
                                      #LET l_k = 1   
                                      #EXECUTE adzp188_sum2_tmp_ins_pre USING g_dzge_xg_d.dzge006, lc_dzge006_t, '6',l_k,g_xg_grouplist[li_i].groupalias,g_cust,g_code_ide  ##141013 add
                                      ##141013 add -(e)   
                                  #END IF                                           
                                  #LET lc_dzge006_t = g_dzge_xg_d.dzge006   
                                  ##140512新版 -(e)      
                                  ##140326 增加彙總 -(e) 
                                  #LET g_dzge_xg_d.dzge004 = g_dzge_xg_d.dzge004 + 1
                                  ##141211 mark -調整存入sum2_tmp的方式(e)
                                  
                                  ## 141211 add -調整存入sum2_tmp的方式(s)
                                  LET lc_dzge006_t =''
                                  IF g_dzge_xg_d.dzge004 = 1 THEN
                                     ##指第一個
                                     LET lc_dzge006_t = "0"
                                  ELSE
                                     
                                     SELECT dzge006 INTO lc_dzge006_t FROM adzp188_gexg_tmp     #151012-00003#1 調整tmp名稱縮為17字元
                                      WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                                        AND dzge009 = g_code_ide AND dzge004 = g_dzge_xg_d.dzge004 - 1 
                                      
                                  END IF
                                  LET l_k = 1   
                                  EXECUTE adzp188_sum2_tmp_ins_pre USING g_dzge_xg_d.dzge006, lc_dzge006_t, '6',l_k,g_xg_grouplist[li_i].groupalias,g_cust,g_code_ide  
                                  ## 141211 add -調整存入sum2_tmp的方式(e)

                             END IF 
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                       IF adzp188_chk_field_exist("s_xg_groupsel",g_xg_grouplist[pi_idx].groupid,'') THEN                      
                           LET g_dzge_xg_d.dzge006 = g_xg_grouplist[pi_idx].groupid
                           LET g_dzge_xg_d.group  = 'Y'  #group
                           LET g_dzge_xg_d.sort   = 1  #sort 
                           LET g_dzge_xg_d.paging = 'N'  #paging
                           EXECUTE adzp188_gexg_tmp_ins_pre USING g_dzge_xg_d.dzge006, g_dzge_xg_d.group,g_dzge_xg_d.sort,    #151012-00003#1 調整tmp名稱縮為17字元
                                                                     g_dzge_xg_d.paging,g_dzge_xg_d.dzge004,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide 
                           ##140326 增加彙總 -(s) 
                           ##140512 舊版(s)
                             ##INSERT INTO adzp188_sum2_tmp
                                  ##VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzge_xg_d.dzge006, '0', '6', 1)
                           ##140512 舊版(e)
                           ## 141211 mark -調整存入sum2_tmp的方式(s)
                           ##140512新版 -(s)
                           #IF ls_temp = 0 THEN 
                             ##141013 mark -(s)
                             ##INSERT INTO adzp188_sum2_tmp
                                  ##VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzge_xg_d.dzge006, '0', '6', 1, g_xg_grouplist[pi_idx].groupalias, g_cust,g_code_ide) #140613 add g_cust,g_code_ide
                             ##141013 mark -(e)
                             ##141013 add -(s)   
                             #LET l_k = 1      
                             #EXECUTE adzp188_sum2_tmp_ins_pre USING g_dzge_xg_d.dzge006, '0', '6', l_k, g_xg_grouplist[pi_idx].groupalias, g_cust,g_code_ide  
                             ##141013 add -(e)
                             #LET ls_temp = 1
                           #ELSE 
                               ##141013 mark -(s)
                               ##INSERT INTO adzp188_sum2_tmp
                                  ##VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzge_xg_d.dzge006, lc_dzge006_t, '6',1,g_xg_grouplist[pi_idx].groupalias,g_cust,g_code_ide) #140613 add g_cust,g_code_ide
                               ##141013 mark -(e)
                               ##141013 add -(s)   
                               #LET l_k = 1                                 
                               #EXECUTE adzp188_sum2_tmp_ins_pre USING g_dzge_xg_d.dzge006, lc_dzge006_t, '6',l_k,g_xg_grouplist[pi_idx].groupalias,g_cust,g_code_ide   
                               ##141013 add -(e)
                           #END IF                                           
                           #LET lc_dzge006_t = g_dzge_xg_d.dzge006   
                           ##140512新版 -(e)                                   
                           ##140326 增加彙總 -(e)                           
                           #LET g_dzge_xg_d.dzge004 = g_dzge_xg_d.dzge004 + 1
                           ## 141211 mark -調整存入sum2_tmp的方式(e)

                           ## 141211 add -調整存入sum2_tmp的方式(s)
                           LET lc_dzge006_t =''
                           IF g_dzge_xg_d.dzge004 = 1 THEN
                              ##指第一個
                              LET lc_dzge006_t = "0"
                           ELSE                              
                              SELECT dzge006 INTO lc_dzge006_t FROM adzp188_gexg_tmp     #151012-00003#1 調整tmp名稱縮為17字元
                               WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                                 AND dzge009 = g_code_ide AND dzge004 = g_dzge_xg_d.dzge004 - 1                                
                           END IF
                           LET l_k = 1   
                           EXECUTE adzp188_sum2_tmp_ins_pre USING g_dzge_xg_d.dzge006, lc_dzge006_t, '6',l_k,g_xg_grouplist[pi_idx].groupalias,g_cust,g_code_ide  
                           ## 141211 add -調整存入sum2_tmp的方式(e)
                           
                       END IF 
                    END IF
                 END IF
             END FOR
             
      WHEN "upd"
         #時機點: s_xg_groupsel的AFTER ROW, 是否要進入修改可以用舊值比對新值
         #先處理dzge005的值
         ##140113群組與跳頁還未處理好
         IF g_xg_groupsel[pi_idx].group = "N" THEN 
            IF g_xg_groupsel[pi_idx].paging = "Y" THEN 
               LET g_dzge_xg_d.paging  = 'N'
            END IF 
            LET g_dzge_xg_d.group  = 'N'
            #LET g_dzge_xg_d.sort  = '1'   #141204 mark
            LET g_dzge_xg_d.sort  = g_xg_groupsel[pi_idx].sort      #141204 add
         ELSE 
            LET g_dzge_xg_d.group  = 'Y'
            LET g_dzge_xg_d.paging  = g_xg_groupsel[pi_idx].paging
            #LET g_dzge_xg_d.sort  = '1'    #141204 mark    
            LET g_dzge_xg_d.sort  = g_xg_groupsel[pi_idx].sort     #141204 add 
         END IF 


     
         UPDATE adzp188_gexg_tmp   SET group1 = g_dzge_xg_d.group      #151012-00003#1 調整tmp名稱縮為17字元     
                ,sort = g_dzge_xg_d.sort, paging = g_dzge_xg_d.paging  
          WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
            AND dzge004 = g_xg_groupsel[pi_idx].dzge004
            #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add  ##141013  mark
            AND dzge009 = g_code_ide                       ##141013 add 
            
            
      WHEN "del"
         #由s_xg_grouplist新增進入, pi_idx為s_xg_groupsel的focus行數, 砍不到也沒關係
         DELETE FROM adzp188_gexg_tmp      #151012-00003#1 調整tmp名稱縮為17字元
          WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 AND dzge004 = g_xg_groupsel[pi_idx].dzge004
            #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add #141013 mark
            AND dzge009 = g_code_ide                                   ##141013 add
         IF SQLCA.SQLCODE THEN
         ELSE
            
            LET g_dzge_xg_d.dzge004 = g_xg_groupsel[pi_idx].dzge004

            ##141211 刪除前先抓出欲刪除的爸爸 - add (s)
            LET l_pid2 = ""
            SELECT pid2 INTO l_pid2 FROM adzp188_sum2_tmp
             WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
               AND id2 = g_xg_groupsel[pi_idx].dzge006
               AND ide = g_code_ide
            ##141211 刪除前先抓出欲刪除的爸爸 - add (e)

            ##140326 刪除彙總 -(s)
            DELETE FROM adzp188_sum2_tmp
             WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
               #AND (pid2 = g_xg_groupsel[pi_idx].dzge006 OR id2 = g_xg_groupsel[pi_idx].dzge006)  #141211 mark
               AND (pid2 = g_xg_groupsel[pi_idx].dzge006 AND pidseq2 = 0) OR (id2 = g_xg_groupsel[pi_idx].dzge006 AND pidseq2 = 1)      #141211 add 增加刪子節點 
               #AND cust = g_cust AND ide = g_code_ide #140613 add ##141013 mark 
               AND ide = g_code_ide                                #141013 add  

            ##140326 刪除彙總 -(e)

            ##141211 add - 將刪除的下一階補上新爸爸(s) 
            UPDATE adzp188_sum2_tmp SET pid2 = l_pid2
             WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
               AND pid2 = g_xg_groupsel[pi_idx].dzge006
               AND pidseq2 = 1  #是否為父節點
               AND ide = g_code_ide
            ##141211 add - 將刪除的下一階補上新爸爸(e)   
          
         END IF
   END CASE
  

   #重整
   CALL adzp188_xg_groupsel_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 彙總頁簽-維護彙總明細及設定值
# Memo...........: 
# Usage..........: CALL adzp188_maintain_summarylist(g_detaillist_idx,g_summarylist2[g_summarylist2_idx].summaryseq2 "add")
# Input parameter: pi_idx       s_summarylist1/s_summarylist2上focus的行數
# Input parameter: ps_seq       g_summarylist2 的seq
# ...............: ps_type      add新增/upd修改/del刪除
# Return code....: None
# Date & Author..: 2014/01/23
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_summarylist(ps_idx,ps_seq, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_idx       LIKE type_t.num5
   DEFINE ps_seq       LIKE type_t.num5
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE g_seq2       LIKE type_t.num5
   DEFINE ls_pid2      DYNAMIC ARRAY OF VARCHAR(20)



   LET g_sql =" SELECT id2 FROM adzp188_sum2_tmp ",
              #" WHERE dzgb001 ='", g_dzga_m.dzga001 ,"'", " AND dzgb002 ='", g_dzga_m.dzga002,"'",  #140923 elena mark
              " WHERE dzgb001 ='", g_dzga_m.dzga001 ,"'", " AND dzgb002 ='", gs_ver,"'",             #140923 elena add
              "   AND pidseq2 = 1 ",
              #"   AND cust ='",g_cust,"' AND ide ='",g_code_ide,"'"  #140613 add   #141013 mark 
              "  AND ide ='",g_code_ide,"'"  #141013 add 
   PREPARE summary_getpid_pre FROM g_sql
   DECLARE summary_getpid_curs CURSOR FOR summary_getpid_pre   
   CASE ps_type
      WHEN "add"      
              LET li_i = 1
             #找出父節點  
              FOREACH summary_getpid_curs INTO ls_pid2[li_i]
                  LET li_i = li_i + 1
              END FOREACH 
              CALL ls_pid2.deleteElement(li_i)
              LET li_i = li_i - 1

              
             LET g_sql = "INSERT INTO adzp188_sum2_tmp ",
                         #"VALUES('",g_dzga_m.dzga001,"','", g_dzga_m.dzga002,"',?,?,?,?,?,?,?)"  #140613 add ,?,?  #141013 mark
                         "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)"  #140613 add ,?,?             #141013 add
             PREPARE adzp188_summary_tmp_ins_pre FROM g_sql

             FOR li_i = 1 TO ls_pid2.getLength()  ##每個節點都得增加欄位
                 #由s_summarylist1新增進入, 可能為多選新增
                  FOR pi_idx = 1 TO g_summarylist1.getLength()
                     IF gdig_curr.isRowSelected("s_summarylist1", pi_idx) THEN
                        #如果是點在table節點上, 批次新增所有欄位
                        IF NOT g_summarylist1[pi_idx].summaryisnode1 THEN
                           #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                           IF adzp188_chk_field_exist("s_summarylist2",g_summarylist1[pi_idx].summaryid1,ls_pid2[li_i]) THEN                             
                                EXECUTE adzp188_summary_tmp_ins_pre USING g_summarylist1[pi_idx].summaryid1, ls_pid2[li_i],g_gzgg009, '0' ,g_summarylist1[pi_idx].summaryalias,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                           END IF
                         END IF 
                     END IF
                 END FOR 
             END FOR  
             
      WHEN "upd"
         #時機點: s_xg_groupsel的AFTER ROW, 是否要進入修改可以用舊值比對新值
         #先處理dzge005的值
        
          UPDATE adzp188_sum2_tmp SET type2 = g_gzgg009                   
           WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
             AND pid2 = g_summarylist2[ps_idx].summarypid2
             AND id2 = g_summarylist2[ps_idx].summaryid2
             #AND cust = g_cust AND ide = g_code_ide #140613 add   ##141013 mark 
             AND ide = g_code_ide                                   ##141013 add           
           
      WHEN "del"
         #由s_summarylist1新增進入, ps_idx為s_summarylist2的focus行數, 砍不到也沒關係
         LET li_i = 1
         #找出父節點  

          FOREACH summary_getpid_curs INTO ls_pid2[li_i]
              LET li_i = li_i + 1
          END FOREACH 
          CALL ls_pid2.deleteElement(li_i)
          LET li_i = li_i - 1

          FOR li_i = 1 TO ls_pid2.getLength()   
              FOR pi_idx = 1 TO g_summarylist2.getLength()
                 IF gdig_curr.isRowSelected("s_summarylist2", pi_idx) THEN          
                     IF NOT cl_null(g_summarylist2[ps_idx].summarypid2) THEN               
                         DELETE FROM adzp188_sum2_tmp
                          WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
                            AND pid2 = ls_pid2[li_i]
                            AND id2 = g_summarylist2[ps_idx].summaryid2 
                            #AND cust = g_cust AND ide = g_code_ide #140613 add   ##141013 mark
                            AND ide = g_code_ide                     ##141013 add             
                         IF SQLCA.SQLCODE THEN
                         ELSE

                         END IF
                     END IF 
                 END IF 
              END FOR 
          END FOR 
   END CASE

   #重整
   CALL adzp188_summary2_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 欄位頁簽-維護欄位明細及設定值
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzgc(g_detaillist_idx, "N", "add")
# Input parameter: pi_idx       s_fieldlist/s_fieldsel上focus的行數
# ...............: pi_ud_flag   是否為自訂欄位
# ...............: ps_type      add新增/upd修改/del刪除
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzgc(pi_idx, pi_ud_flag, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE pi_ud_flag   LIKE type_t.chr1
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_dzgd006    LIKE dzgd_t.dzgd006    #150211 add
   DEFINE l_add_seq    LIKE type_t.num5       #150525-00029#1 add
   DEFINE l_new_dzgc003 LIKE type_t.num10     #150525-00029#1 add

   CASE ps_type
      WHEN "add"


         #檢查單頭是否存入, 若還未存入必須先INSERT單頭
         #dzga_t count IS NULL, INSERT INTO dzga_t

             #150525-00029#1 mark-(s)
             ##找出最大序號
             #SELECT MAX(dzgc003) + 1 INTO l_max FROM adzp188_dzgc_tmp
              #WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002   
                 ##AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add      #141013 mark 
                 #AND dzgc009 = g_code_ide #140613 add       #141013 add       
             #150525-00029#1 mark-(e)         
             #150525-00029#1 add -(s)
             ##先計算從清單選了幾個欄位             
             IF pi_ud_flag ='N' THEN  ##150617-00018 add
                 LET l_cnt = 0
                 FOR li_i = 1 TO g_fieldlist.getLength()
                     IF gdig_curr.isRowSelected("s_fieldlist", li_i) THEN 
                        IF adzp188_chk_field_exist("s_fieldsel",g_fieldlist[li_i].id,g_fieldlist[li_i].alias) THEN  #150126 add
                           LET l_cnt = l_cnt + 1      
                        END IF    
                     END IF 
                 END FOR 
             ##150617-00018 add  -(s)   
             ELSE ##自訂欄位一次只加1個
                LET l_cnt = 1
             END IF 
             #IF pi_idx IS NULL OR pi_idx = 0 THEN 
                #LET pi_idx = 1
             #END IF 
             ##150617-00018 add -(e)
             ##欄位序號一次要增加的號碼 再+1
             LET l_add_seq = l_cnt
             ##先將插入的後面序號往後更新 更新為現在的序號+新增個數+1
             FOR li_i = g_fieldsel.getLength() TO pi_idx + 1 STEP -1
                 LET l_new_dzgc003 = g_fieldsel[li_i].dzgc003 + l_add_seq
                 UPDATE adzp188_dzgc_tmp SET dzgc003 = l_new_dzgc003
                  WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002   
                    AND dzgc003 = g_fieldsel[li_i].dzgc003 AND dzgc009 = g_code_ide
             END FOR 
             ##將要新增的欄位序號改為已選欄位idx+1，因為要在之後加
             LET g_dzgc_d.dzgc003 = pi_idx + 1    
             #150525-00029#1 add -(e)

             IF g_dzgc_d.dzgc003 IS NULL THEN
                LET g_dzgc_d.dzgc003 = 1
             END IF

             LET g_sql = "INSERT INTO adzp188_dzgc_tmp ",
                         #"VALUES('",g_dzga_m.dzga001,"','", g_dzga_m.dzga002,"',?,?,?,?,?,?,?)" #140613 add ,?,?  #141003 mark
                         "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" #140613 add ,?,?   #141003 add
             PREPARE adzp188_dzgc_tmp_ins_pre FROM g_sql

             #處理不同來源的欄位新增資料值
             IF pi_ud_flag ="N" THEN
                #由s_fieldlist新增進入, 可能為多選新增
                FOR pi_idx = 1 TO g_fieldlist.getLength()
                    IF gdig_curr.isRowSelected("s_fieldlist", pi_idx) THEN
                       #如果是點在table節點上, 批次新增所有欄位
                       IF g_fieldlist[pi_idx].isnode THEN
                          #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                          FOR li_i = pi_idx + 1 TO g_fieldlist.getLength()
                              IF NOT g_fieldlist[li_i].isnode THEN
                                 #IF adzp188_chk_field_exist("s_fieldsel",g_fieldlist[li_i].id,'') THEN  #150126 mark
                                 IF adzp188_chk_field_exist("s_fieldsel",g_fieldlist[li_i].id,g_fieldlist[li_i].alias) THEN  #150126 add
                                     LET g_dzgc_d.dzgc004 = g_fieldlist[li_i].id
                                     LET g_dzgc_d.dzgc005 = "1"   #預設Both
                                     LET g_dzgc_d.dzgc006 = "N"
                                     LET g_dzgc_d.dzgc007 = g_fieldlist[li_i].alias
                                     EXECUTE adzp188_dzgc_tmp_ins_pre USING g_dzgc_d.dzgc003, g_dzgc_d.dzgc004, g_dzgc_d.dzgc005, g_dzgc_d.dzgc006,g_dzgc_d.dzgc007,g_cust,g_code_ide#140613 add ,g_cust,g_code_ide 
                                     LET g_dzgc_d.dzgc003 = g_dzgc_d.dzgc003 + 1
                                 ##150121 add -(s)    
                                 ELSE
                                    INITIALIZE g_errparam TO NULL
                                    LET g_errparam.code = "adz-00182"
                                    LET g_errparam.replace[1] = g_fieldlist[li_i].id
                                    LET g_errparam.extend = ''
                                    LET g_errparam.popup = FALSE
                                    CALL cl_err()                                     
                                 ##150121 add -(e)   
                                 END IF
                              ELSE
                                 EXIT FOR
                              END IF
                          END FOR
                       ELSE
                         #IF adzp188_chk_field_exist("s_fieldsel",g_fieldlist[pi_idx].id,'') THEN  ##150126 mark
                         IF adzp188_chk_field_exist("s_fieldsel",g_fieldlist[pi_idx].id,g_fieldlist[pi_idx].alias) THEN   ##150126 add
                              LET g_dzgc_d.dzgc004 = g_fieldlist[pi_idx].id
                              LET g_dzgc_d.dzgc005 = "1"   #預設Both
                              LET g_dzgc_d.dzgc006 = "N"
                              LET g_dzgc_d.dzgc007 = g_fieldlist[pi_idx].alias
                              EXECUTE adzp188_dzgc_tmp_ins_pre USING g_dzgc_d.dzgc003, g_dzgc_d.dzgc004, g_dzgc_d.dzgc005, g_dzgc_d.dzgc006,g_dzgc_d.dzgc007,g_cust,g_code_ide#140613 add ,g_cust,g_code_ide 
                              LET g_dzgc_d.dzgc003 = g_dzgc_d.dzgc003 + 1
                         ##150121 add -(s)
                         ELSE
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = "adz-00182"
                            LET g_errparam.extend = ''
                            LET g_errparam.replace[1] = g_fieldlist[pi_idx].id
                            LET g_errparam.popup = FALSE
                            CALL cl_err()                                    
                         ##150121 add -(e)
                          END IF
                       END IF
                    END IF
                END FOR
             ELSE
                #由自訂欄位區塊新增進入
                #IF adzp188_chk_field_exist("s_fieldsel",g_dzgd_d.dzgd003,'') THEN   ##150126 mark
                IF adzp188_chk_field_exist("s_fieldsel",g_dzgd_d.dzgd003,g_dzgd004_1) THEN    ##150126 add
                    LET g_dzgc_d.dzgc004 = g_dzgd_d.dzgd003      ##150921 mark
                    LET g_dzgc_d.dzgc004 = g_dzgd_d.dzgd003 CLIPPED      ##150921 add
                    LET g_dzgc_d.dzgc005 = "1"   #預設Both
                    LET g_dzgc_d.dzgc006 = "Y"
                    LET g_dzgc_d.dzgc007 = g_dzgd004_1
                    EXECUTE adzp188_dzgc_tmp_ins_pre USING g_dzgc_d.dzgc003, g_dzgc_d.dzgc004, g_dzgc_d.dzgc005, g_dzgc_d.dzgc006, g_dzgc_d.dzgc007,g_cust,g_code_ide#140613 add ,g_cust,g_code_ide 
                    IF SQLCA.SQLCODE THEN
                    ELSE

                       #新增到欄位列表成功後, 再寫入自訂欄位的資料(直接用畫面值去寫)
                       IF pi_ud_flag ="Y" THEN
                          LET g_dzgd_d.dzgd004 = g_dzgd004_1,".",g_dzgd004_2   #這裡會不會有資料庫廠牌差異?
                          CALL adzp188_maintain_dzgd("add")
                       END IF
                    END IF
                   LET g_dzgd_d.dzgd003 = ""                  
                   LET g_dzgd_d.dzgd005 = ""
                   DISPLAY g_dzgd_d.dzgd003 TO dzgd_d.dzgd003                   #150525-00029#1  add 
                   DISPLAY g_dzgd_d.dzgd005 TO dzgd_d.dzgd005                   #150525-00029#1  add
                   #CALL adzp188_set_table_comboitems("formonly.dzgd004_1", FALSE) RETURNING g_dzgd004_1  #161102-00030#1 mark 優化所以不用重抓
                   #LET g_dzgd004_1 = "type_t"   #重設預設值  #160921-00012#1 mark
                   #CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, FALSE) RETURNING g_dzgd004_2  #161102-00030#1 mark 優化所以不用重抓
                   #LET g_dzgd004_2 = "num5"     #重設預設值    ##140513 mark改成chr30
                   #LET g_dzgd004_2 = "chr30"     #重設預設值     ##140513 add  #160921-00012#1 mark
                   LET g_dzgd006_1 = "1"
                   DISPLAY "4 add udfield strat time:",cl_get_current()
                ##150121 add -(s)
                ELSE
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "adz-00182"
                   LET g_errparam.replace[1] = g_dzgd_d.dzgd003
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = FALSE
                   CALL cl_err()                                    
                ##150121 add -(e)                   
                END IF

             END IF



      WHEN "upd"
         #時機點: s_fieldsel的AFTER ROW, 是否要進入修改可以用舊值比對新值
         #先處理dzgc005的值
         CASE                              
           WHEN g_fieldsel[pi_idx].ext = "Y" AND g_fieldsel[pi_idx].print = "Y"
               LET g_dzgc_d.dzgc005 = "1"
            WHEN g_fieldsel[pi_idx].ext = "Y" AND g_fieldsel[pi_idx].print = "N"
               LET g_dzgc_d.dzgc005 = "2"
            WHEN g_fieldsel[pi_idx].ext = "N" AND g_fieldsel[pi_idx].print = "Y"
               LET g_dzgc_d.dzgc005 = "3"
         END CASE
         
         UPDATE adzp188_dzgc_tmp SET dzgc005 = g_dzgc_d.dzgc005 
          WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002   
            AND dzgc003 = g_fieldsel[pi_idx].dzgc003                        
            #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add       #141013 mark
            AND dzgc009 = g_code_ide                                         #141013 add            
      WHEN "del"
         #由s_fieldlist新增進入, pi_idx為s_fieldsel的focus行數, 砍不到也沒關係
         IF g_fieldsel[pi_idx].dzgcchk ="N" THEN  #單筆
                 DELETE FROM adzp188_dzgc_tmp
                  WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002 AND dzgc003 = g_fieldsel[pi_idx].dzgc003  
                    #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add     #141013 mark  
                    AND dzgc009 = g_code_ide                                      #141013 add                                        

                 ##150617-00018#1janet  add -(s)
                 #DELETE FROM adzp188_type2_tmp
                  #WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
                    #AND dzgh003 = g_dzga_m.dzga001 AND id = g_fieldsel[pi_idx].dzgc004  
                    #AND dzgh012 = g_code_ide  
                    #AND alias2 = g_fieldsel[pi_idx].dzgc007                          
                 ##150617-00018#1  add -(e)
 
                    
                 IF SQLCA.SQLCODE THEN
                 ELSE
                    #成功刪除欄位明細後, 再刪除自訂欄位資料
                    IF pi_ud_flag ="Y" THEN
                       LET g_dzgd_d.dzgd003 = g_fieldsel[pi_idx].dzgc004
                       ##150211 mark -(s)
                       #CALL adzp188_get_dzgd_data(g_fieldsel[pi_idx].dzgc004) RETURNING g_dzgd_d.dzgd005,g_dzgd004_1,g_dzgd004_2 ##140508 add 
                       #LET g_dzgd006_1 = "3"   ##140508 add  
                       ##150211 mark -(e)
                       
                       ##150211 add -(s)
                       CALL adzp188_get_dzgd_data(g_fieldsel[pi_idx].dzgc004) RETURNING g_dzgd_d.dzgd005,g_dzgd004_1,g_dzgd004_2,l_dzgd006
                       CASE l_dzgd006
                         WHEN "0"
                            LET g_dzgd006_1 = "0"
                         WHEN "''"
                            LET g_dzgd006_1 = "2"                            
                         WHEN "NULL"
                            LET g_dzgd006_1 = "1"  
                         OTHERWISE 
                            LET g_dzgd006_1 = "3"
                            LET g_dzgd_d.dzgd006 = l_dzgd006  ##150423 add
                       END CASE 
                       ##150211 add -(e)                       

                       #140715 add -(s)
                       DISPLAY g_dzgd_d.dzgd003 TO formonly.dzgd003
                       DISPLAY g_dzgd_d.dzgd005 TO formonly.dzgd005  
                       #141127 mark-(s)  
                       #DISPLAY g_dzgd004_1 TO formonly.dzgd004
                       #DISPLAY g_dzgd004_2 TO formonly.dzgd004_table
                       #141127 mark-(e) 
                       #141127 add-(s) 
                       DISPLAY g_dzgd004_1 TO formonly.dzgd004_1
                       DISPLAY g_dzgd004_2 TO formonly.dzgd004_2   
                       #141127 add-(e)                     
                       DISPLAY g_dzgd006_1 TO formonly.dzgd006_1 
                       #140715 add -(e)
                       CALL adzp188_maintain_dzgd("del")
                    END IF
                 END IF         
         ELSE 
             FOR li_i = 1 TO g_fieldsel.getLength()
                 IF g_fieldsel[li_i].dzgcchk ="Y" THEN 
                     DELETE FROM adzp188_dzgc_tmp
                      WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002 AND dzgc003 = g_fieldsel[li_i].dzgc003   
                        #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add    #141013 mark                      
                        AND dzgc009 = g_code_ide #140613 add                                            #141013 add  
                     
                     IF SQLCA.SQLCODE THEN
                     ELSE
                        #成功刪除欄位明細後, 再刪除自訂欄位資料
                        IF pi_ud_flag ="Y" THEN
                           LET g_dzgd_d.dzgd003 = g_fieldsel[li_i].dzgc004
                           ##150211 mark -(s)
                           #CALL adzp188_get_dzgd_data(g_fieldsel[pi_idx].dzgc004) RETURNING g_dzgd_d.dzgd005,g_dzgd004_1,g_dzgd004_2    ##140508 add  
                           #LET g_dzgd006_1 = "3"   ##140508 add
                           ##150211 mark -(e)
                           ##150211 add -(s)
                           CALL adzp188_get_dzgd_data(g_fieldsel[pi_idx].dzgc004) RETURNING g_dzgd_d.dzgd005,g_dzgd004_1,g_dzgd004_2,l_dzgd006
                           CASE l_dzgd006
                             WHEN "0"
                                LET g_dzgd006_1 = "0"
                             WHEN "''"
                                LET g_dzgd006_1 = "2"                            
                             WHEN "NULL"
                                LET g_dzgd006_1 = "1"  
                             OTHERWISE 
                                LET g_dzgd006_1 = "3"
                                LET g_dzgd_d.dzgd006 = l_dzgd006  ##150423 add
                           END CASE 
                           ##150211 add -(e)                           
                           #140715 add -(s)
                           DISPLAY g_dzgd_d.dzgd003 TO formonly.dzgd003
                           DISPLAY g_dzgd_d.dzgd005 TO formonly.dzgd005  
                           #141127 mark -(s)
                           #DISPLAY g_dzgd004_1 TO formonly.dzgd004
                           #DISPLAY g_dzgd004_2 TO formonly.dzgd004_table
                           #141127 mark -(e)
                           #141127 add-(s) 
                           DISPLAY g_dzgd004_1 TO formonly.dzgd004_1
                           DISPLAY g_dzgd004_2 TO formonly.dzgd004_2   
                           #141127 add-(e)                            
                           DISPLAY g_dzgd006_1 TO formonly.dzgd006_1 
                           #140715 add -(e)                           
                           CALL adzp188_maintain_dzgd("del")
                        END IF
                     END IF
                 END IF 
             END FOR 
         END IF 
   END CASE

   #重整
   CALL adzp188_fieldsel_b_fill()

END FUNCTION



#for gr 140114 -(s)

################################################################################
# Descriptions...: 群組頁簽-維護群細明細及設定值
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzge_gr(g_detaillist_idx, g_groupsel1 "add")
# Input parameter: pi_idx       s_groupsel1/s_groupse2上focus的行數
# Input parameter: pi_arrays    g_groupsel1/g_groupsel2  陣列
# ...............: ps_type      add新增/upd修改/del刪除
# Return code....: None
# Date & Author..: 2014/02/23
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzge_gr(ps_idx, ps_array,ps_type)
   DEFINE ps_idx       LIKE type_t.num5
   DEFINE ps_array     STRING   
   DEFINE ps_type      STRING
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_dzge006   LIKE dzge_t.dzge006

   CASE ps_type
      WHEN "add"
        
         #找出萃取最大序號
         IF ps_array = "s_gr_groupsel1" THEN  
            SELECT MAX(dzge004) + 1 INTO g_dzge_gr_d.dzge004 FROM adzp188_dzge_tmp
             WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
               AND dzge003 = '1'  
               #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613   #141013 mark
               AND dzge009 = g_code_ide          ##141013 add          
            LET g_dzge_gr_d.dzge003 ='1'
         ELSE  ##找出印出最大序號
             SELECT MAX(dzge004) + 1 INTO g_dzge_gr_d.dzge004 FROM adzp188_dzge_tmp
             WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
               AND dzge003 = '2' 
               #AND dzge008 = g_cust AND dzge009 = g_code_ide  #140613##141013 mark
               AND dzge009 = g_code_ide  ##141013 add
             LET g_dzge_gr_d.dzge003 ='2'       
         END IF 
         IF g_dzge_gr_d.dzge004 IS NULL THEN
            LET g_dzge_gr_d.dzge004 = 1
         END IF

         LET g_sql = "INSERT INTO adzp188_dzge_tmp ",
                     #"VALUES('",g_dzga_m.dzga001,"','", g_dzga_m.dzga002,"',?,?,?,?,?,?,?)"  #140613 add ,?,?  #141013 mark 
                     "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)"  #141013 add
         PREPARE adzp188_dzge_tmp_ins_pre FROM g_sql

         IF ps_array = "s_gr_groupsel1" THEN  
             #由s_gr_grouplist1新增進入, 可能為多選新增
             FOR ps_idx = 1 TO g_gr_grouplist1.getLength()
                 IF gdig_curr.isRowSelected("s_gr_grouplist1", ps_idx) THEN
                    #如果是點在table節點上, 批次新增所有欄位
                    IF g_gr_grouplist1[ps_idx].groupisnode1 THEN
                       #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = ps_idx + 1 TO g_gr_grouplist1.getLength()
                           IF NOT g_gr_grouplist1[li_i].groupisnode1 THEN
                              LET g_dzge_gr_d.dzge006 = g_gr_grouplist1[li_i].groupid1
                              LET g_dzge_gr_d.dzge005 = ""   #萃取沒有order by
                              #LET g_dzge_gr_d.dzge003 = "1" #萃取 
                              LET g_dzge_gr_d.dzge007 = "1" #預設升序
                              EXECUTE adzp188_dzge_tmp_ins_pre USING g_dzge_gr_d.dzge003, g_dzge_gr_d.dzge004, g_dzge_gr_d.dzge005, g_dzge_gr_d.dzge006, g_dzge_gr_d.dzge007,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                              LET g_dzge_gr_d.dzge004 = g_dzge_gr_d.dzge004 + 1
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                       LET g_dzge_gr_d.dzge006 = g_gr_grouplist1[ps_idx].groupid1
                       LET g_dzge_gr_d.dzge005 = ""   #萃取沒有order by
                       #LET g_dzge_gr_d.dzge003 = "1" #萃取 
                       LET g_dzge_gr_d.dzge007 = "1" #預設升序
                       EXECUTE adzp188_dzge_tmp_ins_pre USING g_dzge_gr_d.dzge003, g_dzge_gr_d.dzge004, g_dzge_gr_d.dzge005, g_dzge_gr_d.dzge006, g_dzge_gr_d.dzge007,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                       LET g_dzge_gr_d.dzge004 = g_dzge_gr_d.dzge004 + 1
                    END IF
                 END IF
             END FOR
         ELSE 

             ##150324 mark -將抓grouplist2改成抓grouplist1 -(s)
             ##140224 janet
             ##由s_gr_grouplist2新增進入, 可能為多選新增
             #FOR ps_idx = 1 TO g_gr_grouplist2.getLength()                 
                 #IF gdig_curr.isRowSelected("s_gr_grouplist2", ps_idx) THEN   
                    ##如果是點在table節點上, 批次新增所有欄位                              
                    #IF g_gr_grouplist2[ps_idx].groupisnode2 THEN              
                       ##因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       #FOR li_i = ps_idx + 1 TO g_gr_grouplist2.getLength()
                           #IF NOT g_gr_grouplist2[li_i].groupisnode2 THEN
                              #LET g_dzge_gr_d.dzge006 = g_gr_grouplist2[li_i].groupid2
                              #LET g_dzge_gr_d.dzge005 = g_dzge005   #沒有order by
                              #LET g_dzge_gr_d.dzge003 = "2" #印出 
                              #LET g_dzge_gr_d.dzge007 = "1" #預設升序
                              #EXECUTE adzp188_dzge_tmp_ins_pre USING g_dzge_gr_d.dzge003, g_dzge_gr_d.dzge004, g_dzge_gr_d.dzge005, g_dzge_gr_d.dzge006, g_dzge_gr_d.dzge007 ,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                              #LET g_dzge_gr_d.dzge004 = g_dzge_gr_d.dzge004 + 1
                           #ELSE
                              #EXIT FOR
                           #END IF
                       #END FOR
                    #ELSE
                       #LET g_dzge_gr_d.dzge006 = g_gr_grouplist2[ps_idx].groupid2
                       #LET g_dzge_gr_d.dzge005 = g_dzge005   #xg沒有order by
                       #LET g_dzge_gr_d.dzge003 = "2"
                       #LET g_dzge_gr_d.dzge007 = "1"
                       #EXECUTE adzp188_dzge_tmp_ins_pre USING g_dzge_gr_d.dzge003, g_dzge_gr_d.dzge004, g_dzge_gr_d.dzge005, g_dzge_gr_d.dzge006, g_dzge_gr_d.dzge007 ,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                       #LET g_dzge_gr_d.dzge004 = g_dzge_gr_d.dzge004 + 1
                    #END IF
                 #END IF
             #END FOR       
             ##150324 mark -將抓grouplist2改成抓grouplist1 -(s)
             ##150324 add 改抓grouplist1-(s)
             FOR ps_idx = 1 TO g_gr_grouplist1.getLength()                 
                 IF gdig_curr.isRowSelected("s_gr_grouplist1", ps_idx) THEN   
                    #如果是點在table節點上, 批次新增所有欄位                                           
                    IF g_gr_grouplist1[ps_idx].groupisnode1 THEN              
                       #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = ps_idx + 1 TO g_gr_grouplist1.getLength()
                           IF NOT g_gr_grouplist1[li_i].groupisnode1 THEN
                              LET g_dzge_gr_d.dzge006 = g_gr_grouplist1[li_i].groupid1
                              LET g_dzge_gr_d.dzge005 = g_dzge005   #沒有order by
                              LET g_dzge_gr_d.dzge003 = "2" #印出 
                              LET g_dzge_gr_d.dzge007 = "1" #預設升序
                              EXECUTE adzp188_dzge_tmp_ins_pre USING g_dzge_gr_d.dzge003, g_dzge_gr_d.dzge004, g_dzge_gr_d.dzge005, g_dzge_gr_d.dzge006, g_dzge_gr_d.dzge007 ,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                              LET g_dzge_gr_d.dzge004 = g_dzge_gr_d.dzge004 + 1
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                       LET g_dzge_gr_d.dzge006 = g_gr_grouplist1[ps_idx].groupid1
                       LET g_dzge_gr_d.dzge005 = g_dzge005   #xg沒有order by
                       LET g_dzge_gr_d.dzge003 = "2"
                       LET g_dzge_gr_d.dzge007 = "1"
                       EXECUTE adzp188_dzge_tmp_ins_pre USING g_dzge_gr_d.dzge003, g_dzge_gr_d.dzge004, g_dzge_gr_d.dzge005, g_dzge_gr_d.dzge006, g_dzge_gr_d.dzge007 ,g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                       LET g_dzge_gr_d.dzge004 = g_dzge_gr_d.dzge004 + 1
                    END IF
                 END IF
             END FOR      
             ##150324 add 改抓grouplist1-(e)  
         END IF 

         
      WHEN "upd"
         #時機點: s_gr_groupsel1的AFTER ROW, 是否要進入修改可以用舊值比對新值
         IF ps_array = "s_gr_groupsel1" THEN  
             LET g_dzge_gr_d.dzge007 = g_gr_groupsel1[ps_idx].dzge007
             UPDATE adzp188_dzge_tmp SET dzge007 = g_dzge_gr_d.dzge007
              WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                AND dzge003 = g_gr_groupsel1[ps_idx].dzge003 AND dzge004 = g_gr_groupsel1[ps_idx].dzge004
                #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add  ##141013 mark
                AND dzge009 = g_code_ide                                      ##141013 add
         
         ELSE
             LET g_dzge_gr_d.dzge007 = g_gr_groupsel2[ps_idx].dzge007 
             UPDATE adzp188_dzge_tmp SET dzge007 = g_dzge_gr_d.dzge007
              WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                AND dzge003 = g_gr_groupsel2[ps_idx].dzge003 AND dzge004 = g_gr_groupsel2[ps_idx].dzge004  
                #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add  #141013 mark
                AND dzge009 = g_code_ide                       ##141013 add   
                           
         END IF    
      WHEN "del"
         #由s_xg_grouplist新增進入, ps_idx為s_xg_groupsel的focus行數, 砍不到也沒關係
          IF ps_array = "s_gr_groupsel1" THEN  
             DELETE FROM adzp188_dzge_tmp
              WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 
                AND dzge003 = g_gr_groupsel1[ps_idx].dzge003 AND dzge004 = g_gr_groupsel1[ps_idx].dzge004
                #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add ##141013 mark 
                AND dzge009 = g_code_ide                                   ##141013 add   
              
          ELSE 
             DELETE FROM adzp188_dzge_tmp
              WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 
                AND dzge003 = g_gr_groupsel2[ps_idx].dzge003 AND dzge004 = g_gr_groupsel2[ps_idx].dzge004
                #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add  #141013 mark 
                AND dzge009 = g_code_ide                                    #141013 add                     
          END IF 
         IF SQLCA.SQLCODE THEN

         END IF
   END CASE

   #重整
   CALL adzp188_gr_groupsel_b_fill()

END FUNCTION


#for gr 140223 -(e)

################################################################################
# Descriptions...: 群組頁簽-維護xg主檔與xg明細檔群組資訊
# Memo...........: 
# Usage..........: CALL adzp188_maintain_gzgggzgf(l_gzgf_max,g_xg_groupsel)
# Input parameter: p_gzgf_max      xg主檔報表ID
# Input parameter: p_xg_groupsel   群組頁籤ARRAY
# Return code....: None
# Date & Author..: 2014/01/10
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_gzgggzgf(p_gzgf_max,p_xg_groupsel)
   DEFINE p_gzgf_max   LIKE gzgf_t.gzgf000
   DEFINE p_xg_groupsel   DYNAMIC ARRAY OF RECORD
          dzge006            LIKE dzge_t.dzge006,
          name               LIKE dzebl_t.dzebl003,
          group              LIKE type_t.chr1,
          sort               LIKE dzge_t.dzge007,
          paging             LIKE type_t.chr1,
          dzge004            LIKE dzge_t.dzge004,  #避免排序錯誤, 序號值必須抓出, 但不顯示
          alias              LIKE dzgc_t.dzgc007   #140606 add
                             END RECORD
   DEFINE l_group_tmp  LIKE gzgf_t.gzgf014
   DEFINE l_sort_tmp   LIKE gzgf_t.gzgf015
   DEFINE l_paging_tmp LIKE gzgf_t.gzgf016 
   DEFINE li           LIKE type_t.num5
   DEFINE lc_group     LIKE type_t.chr1
   DEFINE lc_sort      LIKE type_t.num5
   DEFINE lc_paging    LIKE type_t.chr1
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE lc_dzge004   LIKE type_t.num5 
   DEFINE lc_id2       LIKE type_t.chr20
   DEFINE lc_type2     LIKE type_t.chr1
   DEFINE l_gzgg_cnt   LIKE type_t.num5 
   DEFINE l_sort_str   LIKE gzgf_t.gzgf018  
   DEFINE lc_field     LIKE type_t.chr80
   DEFINE lc_seq       LIKE type_t.num5
   DEFINE l_alias      LIKE dzgc_t.dzgc007       #140606 add
   DEFINE l_gzgg014    LIKE gzgg_t.gzgg014       #140606 add  
   DEFINE l_gzgg015    LIKE gzgg_t.gzgg015       #140606 add   
   DEFINE l_gzgg016    LIKE gzgg_t.gzgg016       #140606 add
  
   
   LET l_group_tmp =""
   LET l_paging_tmp =""
   LET l_sort_tmp =""
   LET l_sort_str =""

   ##撈出group、sort、paging的欄位組合
   LET g_sql = " SELECT dzge006, group1, sort, paging,dzge004 FROM adzp188_gexg_tmp  ",      #151012-00003#1 調整tmp名稱縮為17字元               
               #" WHERE dzge001 ='",g_dzga_m.dzga001,"'", " AND dzge002 ='",g_dzga_m.dzga002,"'",   #140923 elena mark
               " WHERE dzge001 ='",g_dzga_m.dzga001,"'", " AND dzge002 ='",gs_ver,"'",              #140923 elena add
               #"   AND dzge008 ='",g_cust,"' AND dzge009 ='",g_code_ide ,"'",  #140613 add    ##141013 add
               "   AND dzge009 ='",g_code_ide ,"'",  #141013 add         
               " ORDER BY dzge004"
   PREPARE xg_gorupsel_b_fill_pre1 FROM g_sql 
   DECLARE xg_groupsel_b_fill_curs1 CURSOR FOR xg_gorupsel_b_fill_pre1
   FOREACH xg_groupsel_b_fill_curs1 INTO lc_dzge006, lc_group, lc_sort, lc_paging,lc_dzge004   
       IF lc_group = 'Y' THEN 
          IF cl_null(l_group_tmp) THEN 
             LET l_group_tmp = lc_dzge006
          ELSE 
             LET l_group_tmp = l_group_tmp,",",lc_dzge006
          END IF 
       END IF 
       IF lc_sort = '1' OR lc_sort = '2' THEN 
          IF cl_null(l_sort_tmp) THEN 
             LET l_sort_tmp = lc_dzge006
             LET l_sort_str = lc_sort
          ELSE 
             LET l_sort_tmp = l_sort_tmp,",",lc_dzge006
             LET l_sort_str = l_sort_str,",",lc_sort USING "<<<<<"
          END IF 
       ##150325 add 若沒排序 -(s)
       ELSE
          IF cl_null(l_sort_tmp) THEN 
             LET l_sort_tmp = lc_dzge006
             LET l_sort_str = lc_sort
          ELSE 
             LET l_sort_tmp = l_sort_tmp,",",lc_dzge006
             LET l_sort_str = l_sort_str,",",''
          END IF          
       ##150325 add 若沒排序 -(e)
       END IF 
       IF lc_paging = 'Y' THEN 
          IF cl_null(l_paging_tmp) THEN 
             LET l_paging_tmp = lc_dzge006
          ELSE 
             LET l_paging_tmp = l_paging_tmp,",",lc_dzge006
          END IF 
       END IF        
   END FOREACH  


   ##將群組欄位、排序欄位、跳頁欄位存入xg主檔，存入格式ex:inaa001,inba002，以","隔開
   UPDATE gzgf_t SET gzgf014 = l_group_tmp, gzgf015 = l_sort_tmp,
                   gzgf016 = l_paging_tmp,gzgf018 =l_sort_str
    WHERE gzgfstus = 'Y' #AND gzgfent = g_enterprise  #140612 mark ent
      AND gzgf000 = p_gzgf_max
      #AND gzgf003 = g_code_ide          #140612 add    #140617 mark
      AND gzgf003 = g_gzgf003            #140617 add 
      
   ##將彙總欄位的型態存入
   LET lc_id2=""   
   LET lc_type2=""
   LET g_sql = " SELECT id2, type2,alias FROM adzp188_sum2_tmp ",      #140606 add alias              
               #" WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",g_dzga_m.dzga002,"'",  #140923 elena mark
               " WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",gs_ver,"'",             #140923 elena add
               "   AND pid2 IS NOT NULL ", 
               #"   AND cust ='",g_cust,"' AND ide ='",g_code_ide,"'", #140613 add   #141013 mark 
               "   AND ide ='",g_code_ide,"'", #141013 add  
               " ORDER BY pidseq2 "
   PREPARE summary_insert_pre FROM g_sql 
   DECLARE summary_insert_curs CURSOR FOR summary_insert_pre
   FOREACH summary_insert_curs INTO lc_id2,lc_type2, l_alias   #140606 add
       LET l_gzgg_cnt = 0
       SELECT COUNT(*) INTO l_gzgg_cnt FROM gzgg_t
         WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_id2 AND gzgg009 IS NULL AND gzgg025 = l_alias  ##140606 add  AND gzgg009 IS NULL AND gzgg025 = l_alias #140612 mark ent
       IF l_gzgg_cnt>0 THEN      
           UPDATE gzgg_t SET gzgg009 = lc_type2, gzgg010 = lc_type2
            WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_id2 AND gzgg025 = l_alias  ##140606 add AND gzgg025 = l_alias #140612 mark ent
           IF SQLCA.sqlcode THEN              
           END IF

       END IF 
       ##140605 add xg樣板明細檔-(s)
    
           ##140606 add -(s)
           UPDATE dzgl_t SET dzgl011 = lc_type2, dzgl012 = lc_type2
            WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002 
              AND dzgl003 = g_dzga_m.dzga001 AND dzgl005 = lc_id2 AND dzgl027 = l_alias  ##140606 add AND dzgl027 = l_alias
              #AND dzgl029 = g_cust AND dzgl030 = g_code_ide #140613 add    ##141013 mark 
              AND dzgl030 = g_code_ide                                      ##141013 add     
                       
           IF SQLCA.sqlcode THEN              
           END IF
           ##140606 add -(e)

       ##140605 add xg樣板明細檔-(e)


       
   END FOREACH  
  
   ##將交叉表存入  140521 -(s)
   LET lc_field = ""   
   LET lc_type2 = ""
   LET g_sql = " SELECT field, type,fieldseq,alias FROM adzp188_xgtype_tmp ",       ##140606 add alias              
               #" WHERE dzgh001 ='",g_dzga_m.dzga001,"'", " AND dzgh002 ='",g_dzga_m.dzga002,"'",    #140923 elena mark
               " WHERE dzgh001 ='",g_dzga_m.dzga001,"'", " AND dzgh002 ='",gs_ver,"'",               #140923 elena add
               #"   AND cust ='",g_cust,"' AND ide ='",g_code_ide,"'", #140613 add  #141017 mark
               "   AND ide ='",g_code_ide,"'", #141017 add
               " ORDER BY type,fieldseq "
   PREPARE xgtype_insert_pre FROM g_sql 
   DECLARE xgtype_insert_curs CURSOR FOR xgtype_insert_pre
   FOREACH xgtype_insert_curs INTO lc_field,lc_type2,lc_seq ,l_alias     #140606 add
       #LET l_gzgg_cnt = 0
       #SELECT COUNT(*) INTO l_gzgg_cnt FROM gzgg_t
         #WHERE gzggent = g_enterprise 
          #AND gzgg000 = p_gzgf_max AND gzgg001 = lc_field
       #IF l_gzgg_cnt > 0 THEN
           CASE lc_type2
             WHEN "r"
                   #140606 add -(s) 
                   LET l_gzgg015 = 0  
                   SELECT gzgg015 INTO l_gzgg015 FROM gzgg_t
                    WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_field AND gzgg025 = l_alias #140612 mark gzggent = g_enterprise AND
                                            
                   IF l_gzgg015 = 0 THEN 
                   #140606 add -(e)  
                       UPDATE gzgg_t SET gzgg015 = lc_seq
                        WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_field AND gzgg025 = l_alias  ##140606 add AND gzgg025 = l_alias  #140612 mark gzggent = g_enterprise AND
                       IF SQLCA.sqlcode THEN                      
                       END IF
                   END IF  #140606 add  
                   ##140606 add - (s)
                   UPDATE dzgl_t SET dzgl017 = lc_seq
                    WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002 
                      AND dzgl003 = g_dzga_m.dzga001 AND dzgl005 = lc_field AND dzgl027 = l_alias  ##140606 add AND dzgl027 = = l_alias
                      #AND dzgl029 = g_cust AND dzgl030 = g_code_ide #140613 add        #141013 mark                   
                      AND dzgl030 = g_code_ide                                          ##141013 add  
                    
                   IF SQLCA.sqlcode THEN                      
                   END IF                   
                   ##140606 add - (e)
             WHEN "c"    
                   #140606 add -(s) 
                   LET l_gzgg015 = 0  
                   SELECT gzgg015 INTO l_gzgg015 FROM gzgg_t
                    WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_field AND gzgg025 = l_alias    #140612 mark gzggent = g_enterprise AND                    
                   IF l_gzgg015 = 0 THEN 
                   #140606 add -(e)              
                       UPDATE gzgg_t SET gzgg015 = lc_seq
                        WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_field AND gzgg025 = l_alias  ##140606 add AND gzgg025 = l_alias  #140612 mark gzggent = g_enterprise AND
                       IF SQLCA.sqlcode THEN                      
                       END IF 
                    END IF  #140606 add
                   ##140606 add - (s)
                   UPDATE dzgl_t SET dzgl016 = lc_seq
                    WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002 
                      AND dzgl003 = g_dzga_m.dzga001 AND dzgl005 = lc_field  AND dzgl027 = l_alias  ##140606 add AND dzgl027 = = l_alias
                      #AND dzgl029 = g_cust AND dzgl030 = g_code_ide #140613 add   ##141013 mark 
                      AND dzgl030 = g_code_ide                                     ##141013 add 
                 
                   IF SQLCA.sqlcode THEN                      
                   END IF                   
                   ##140606 add - (e)                   
                   
             WHEN "s"      
                   #140606 add -(s) 
                   LET l_gzgg016 = 0  
                   SELECT gzgg016 INTO l_gzgg016 FROM gzgg_t
                    WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_field AND gzgg025 = l_alias    #140612 mark gzggent = g_enterprise AND                   
                   IF l_gzgg016 = 0 THEN 
                   #140606 add -(e) 
                       UPDATE gzgg_t SET gzgg016 = lc_seq
                        WHERE gzgg000 = p_gzgf_max AND gzgg001 = lc_field AND gzgg025 = l_alias  ##140606 add AND gzgg025 = l_alias   #140612 mark gzggent = g_enterprise AND
                       IF SQLCA.sqlcode THEN                      
                       END IF   
                   END IF #140606 add
                   ##140606 add - (s)
                   UPDATE dzgl_t SET dzgl018 = lc_seq
                    WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002 
                      AND dzgl003 = g_dzga_m.dzga001 AND dzgl005 = lc_field AND dzgl027 = l_alias  ##140606 add AND dzgl027 = = l_alias
                      #AND dzgl029 = g_cust AND dzgl030 = g_code_ide #140613 add  ##141013mark
                       AND dzgl030 = g_code_ide                      ##141013 add -(e)  
                     
                   IF SQLCA.sqlcode THEN                      
                   END IF                   
                   ##140606 add - (e)                   
           END CASE 
       #END IF 
   END FOREACH 
   ##將交叉表存入  140521 -(e)
   

END FUNCTION     


################################################################################
# Descriptions...: 確定欄位是否存在tmp檔裡
# Memo...........: 
# Usage..........: CALL adzp188_chk_field_exist("s_xg_groupsel", g_xg_groupsel[p_li].dzge006)
# Input parameter: ps_array   移動的array名稱
# ...............: ps_field   判斷欄位
# Return code....: l_exist    boolean
# Date & Author..: 2014/01/16
# Modify.........:
################################################################################
FUNCTION adzp188_chk_field_exist(ps_array, ps_field,ps_field1)
   DEFINE ps_array   STRING
   DEFINE ps_field   STRING
   DEFINE ps_field1  STRING
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_field   STRING
   DEFINE ls_field1  STRING 
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE ls_key3    STRING   #140613 add
   DEFINE ls_key4    STRING   #140613 add 


   #array對應的Table及順序欄位指定
   CASE ps_array
      #WHEN "s_join"
         #LET ls_table = "adzp188_dzgb_tmp"
         #LET ls_key1 = "dzgb001"
         #LET ls_key2 = "dzgb002"
         #LET ls_seq = "dzgb003"
      WHEN "s_fieldsel"
         LET ls_table = "adzp188_dzgc_tmp"
         LET ls_key1 = "dzgc001"
         LET ls_key2 = "dzgc002"
         LET ls_field = "dzgc004"
         LET ls_field1 = "dzgc007"  #別名
         LET ls_key3 ="dzgc008"   #140613 add  
         LET ls_key4 ="dzgc009"   #140613 add
         
      WHEN "s_filter"
         LET ls_table = "adzp188_dzgf_tmp"
         LET ls_key1 = "dzgf001"
         LET ls_key2 = "dzgf002"
         LET ls_field = "dzgf006"
         LET ls_key3 ="dzgf011"#140613 add  
         LET ls_key4 ="dzgf012"#140613 add         
      WHEN "s_xg_groupsel"   
         LET ls_table = "adzp188_gexg_tmp  "    #151012-00003#1 調整tmp名稱縮為17字元
         LET ls_key1 = "dzge001"
         LET ls_key2 = "dzge002"
         LET ls_field = "dzge006"
         LET ls_key3 ="dzge008"#140613 add   
         LET ls_key4 ="dzge009"#140613 add         
      WHEN "s_summarylist2"   
         LET ls_table = "adzp188_sum2_tmp"
         LET ls_key1 = "dzgb001"
         LET ls_key2 = "dzgb002"
         LET ls_field = "id2"
         LET ls_field1 = "pid2"  
         LET ls_key3 ="cust"#140613 add   
         LET ls_key4 ="ide"#140613 add       
         
   END CASE
   LET l_cnt = 0
   #找尋暫存檔裡是否有欄位
  
   IF ps_array = "s_summarylist2"  OR ps_array = "s_fieldsel" THEN 
      ##150121 add -(s)
      IF ps_array = "s_fieldsel" AND ps_field.subString(1,2)="l_" THEN
          LET g_sql = " SELECT COUNT(*) FROM ",ls_table,                      
                      " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_field," = '",ps_field,"'",                                             
                      "   AND ", ls_key4," ='",g_code_ide,"'"    
      ELSE      
      ##150121 add -(e)
          LET g_sql = " SELECT COUNT(*) FROM ",ls_table,
                      #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"' AND ",ls_field," = '",ps_field,"'",  #141013 mark
                      " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_field," = '",ps_field,"'",   #141013 add
                      "   AND ", ls_field1," ='",ps_field1,"'",
                      #"   AND ",ls_key3," = '",g_cust,"' AND ", ls_key4," ='",g_code_ide,"'" #140613 add #141013 mark
                      "   AND ", ls_key4," ='",g_code_ide,"'" #141013 add
      END IF   ##150121 add
   ELSE 
      LET g_sql = " SELECT COUNT(*) FROM ",ls_table,
                  ##141013 mark -(s)
                  #" WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",g_dzga_m.dzga002,"' AND ",ls_field," = '",ps_field,"'",
                  #"   AND ",ls_key3," = '",g_cust,"' AND ", ls_key4," ='",g_code_ide,"'" #140613 add
                  ##141013 mark -(e)
                  #141013 add -(s)
                  " WHERE ",ls_key1," = '", g_dzga_m.dzga001,"' AND ",ls_key2," = '",gs_ver,"' AND ",ls_field," = '",ps_field,"'",
                  "   AND ", ls_key4," ='",g_code_ide,"'" 
                  #141013 add -(e)
   END IF 
               
   PREPARE chk_field_exist_pre FROM g_sql

   DECLARE chk_field_exist_curs CURSOR FOR chk_field_exist_pre
   FOREACH chk_field_exist_curs INTO l_cnt  #140116
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
# Descriptions...: 紙張方向圖示
# Memo...........: 
# Usage..........: CALL adzp188_direction_img()
# Input parameter: 
# ...............: 
# Return code....: 
# Date & Author..: 2014/01/19
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_direction_img()
   DEFINE l_img_dir        STRING   #圖片路徑
   DEFINE l_img_template   STRING
   DEFINE l_str            STRING
   DEFINE l_str2           STRING

   ##圖片都放在report目錄下
   LET l_img_dir = "report/"

   IF g_paper_set.r_direction ="1" THEN  #直向  
      
      #LET l_img_template = l_img_dir,"voucher"      ##150213 add  ##150225mark
      ##150225 add -(s)
      CASE g_dzga_m.dzga003 
        WHEN "1"
              CASE g_dzga_m.dzga004
                WHEN "1"
                 LET l_img_template = l_img_dir,"voucher_v"      
              END CASE
        WHEN "2" 
              CASE g_dzga_m.dzga004
                WHEN "2"
                 LET l_img_template = l_img_dir,"detail_v" 
                WHEN "3"  
                 LET l_img_template = l_img_dir,"pivot_v"     
              END CASE    
         OTHERWISE 
              LET l_img_template = l_img_dir,"voucher_v"   
      END CASE
      
      ##150225 add -(e)
      
   ELSE
      # LET l_img_template = l_img_dir,"horizontal"    ##150225 mark
      ##150225 add -(s)
      CASE g_dzga_m.dzga003 
         WHEN "1"    
              CASE g_dzga_m.dzga004
                WHEN "1"
                 LET l_img_template = l_img_dir,"voucher_h"            
              END CASE
         WHEN "2"
               CASE g_dzga_m.dzga004
                 WHEN "2"
                   LET l_img_template = l_img_dir,"detail_h" 
                 WHEN "3"  
                   LET l_img_template = l_img_dir,"pivot_h"     
               END CASE  
         OTHERWISE 
               LET l_img_template = l_img_dir,"voucher_h"            
      END CASE 
      ##150225 add -(e)
            
      
   END IF
   #圖片要先上傳至$FGLIMAGEPATH/report上
   #ex:img_template=report/vertical
   DISPLAY l_img_template TO formonly.img_paper
END FUNCTION



################################################################################
# Descriptions...: 樣板圖示顯示
# Memo...........: 
# Usage..........: CALL adzp188_direction_img()
# Input parameter: 
# ...............: 
# Return code....: 
# Date & Author..: 2014/01/19
# Modify.........:
################################################################################
##150226 mark -(s)
#PRIVATE FUNCTION adzp188_temp_type_img()#225
   #DEFINE l_img_dir        STRING   #圖片路徑
   #DEFINE l_temp_img1      STRING
   #DEFINE l_temp_img2      STRING
   #DEFINE l_temp_img3      STRING   
   #DEFINE l_str            STRING
   #DEFINE l_str2           STRING
#
   ###圖片都放在report目錄下
   #LET l_img_dir = "report/"
#
   #IF g_prog_type ="G" THEN  #GR
      #LET l_temp_img1 = l_img_dir,"voucher" 
      #LET l_temp_img2 = l_img_dir,"label" 
      #LET l_temp_img3 = l_img_dir,"overlay" 
       ##圖片要先上傳至$FGLIMAGEPATH/report上
       ##ex:img_template=report/detail
       #DISPLAY l_temp_img1 TO formonly.temp_img4
       #DISPLAY l_temp_img2 TO formonly.temp_img5
       #DISPLAY l_temp_img3 TO formonly.temp_img6      
   #ELSE 
     #IF g_prog_type ="X" THEN
       #LET l_temp_img1 = l_img_dir,"detail" 
       #LET l_temp_img2 = l_img_dir,"pivot" 
       #LET l_temp_img3 = l_img_dir,"tree"
       ##圖片要先上傳至$FGLIMAGEPATH/report上
       ##ex:img_template=report/detail
       #DISPLAY l_temp_img1 TO formonly.temp_img1
       #DISPLAY l_temp_img2 TO formonly.temp_img2
       #DISPLAY l_temp_img3 TO formonly.temp_img3 
     #ELSE 
       #LET l_temp_img1 = l_img_dir,"voucher" 
       #LET l_temp_img2 = l_img_dir,"label" 
       #LET l_temp_img3 = l_img_dir,"overlay" 
       ##圖片要先上傳至$FGLIMAGEPATH/report上
       ##ex:img_template=report/detail
       #DISPLAY l_temp_img1 TO formonly.temp_img4
       #DISPLAY l_temp_img2 TO formonly.temp_img5
       #DISPLAY l_temp_img3 TO formonly.temp_img6        
     #END IF    
   #END IF
#
#END FUNCTION

##150226 mark -(e)

################################################################################
# Descriptions...: 顯示dzga004_desc明細表/交叉表/樹狀表/馮證/標籤/套表
# Memo...........: 
# Usage..........: CALL adzp188_display_dzga004()
# Input parameter: 
# ...............: 
# Return code....: 
# Date & Author..: 2014/01/22
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_display_dzga004()
  DEFINE g_dzga004_str     STRING 
  DEFINE l_dzga004_str     STRING    ##150303 add
  DEFINE l_paper_desc_str1 STRING    ##150303 add
  DEFINE l_paper_desc_str  STRING    ##150319 add
  DEFINE l_len             STRING    ##150319 add
  DEFINE l_width           STRING    ##150319 add

   LET g_dzga004_str =""
   LET l_paper_desc_str =""   ##150303 add
   LET l_paper_desc_str1 =""   ##150319 add
   ##150225 mark -(s)
   #IF g_prog_type ="G" THEN   
       #IF g_gr_temp_set.r_voucher = "1" THEN LET g_dzga004_str = cl_getmsg("adz-00264",g_lang) END IF #憑證
       #IF g_gr_temp_set.r_label = "1" THEN LET g_dzga004_str = cl_getmsg("adz-00265",g_lang) END IF #標籤   
       #IF g_gr_temp_set.r_overlay = "1"  THEN LET g_dzga004_str = cl_getmsg("adz-00266",g_lang) END IF #套表   
   #ELSE 
       #IF g_temp_set.r_detail = "1" THEN LET g_dzga004_str = cl_getmsg("adz-00256",g_lang) END IF #明細表
       #IF g_temp_set.r_povit = "1" THEN LET g_dzga004_str = cl_getmsg("adz-00257",g_lang) END IF #交叉表   
       #IF g_temp_set.r_tree = "1"  THEN LET g_dzga004_str = cl_getmsg("adz-00258",g_lang) END IF #樹狀表 
   #END IF
  ##150225 mark -(e) 
   ##150225 add -(s)
   CASE g_dzga_m.dzga004
     WHEN "1"
          LET g_dzga004_str = cl_getmsg("adz-00264",g_lang)  #憑證
     WHEN "2" 
          LET g_dzga004_str = cl_getmsg("adz-00256",g_lang)  #明細表 
     WHEN "3" 
          LET g_dzga004_str = cl_getmsg("adz-00257",g_lang)  #交叉表
     WHEN "4" 
          LET g_dzga004_str = cl_getmsg("adz-00265",g_lang)  #標籤 
     WHEN "5" 
          LET g_dzga004_str = cl_getmsg("adz-00266",g_lang)  #套表
     WHEN "6" 
          LET g_dzga004_str = cl_getmsg("adz-00258",g_lang)  #樹狀表 
   END CASE
   ##150225 add -(e)
   DISPLAY g_dzga004_str TO formonly.dzga004_desc
   
   ##150303 add -(s)

   LET l_paper_desc_str = l_dzga004_str,g_dzga004_str,cl_getmsg("adz-00554",g_lang)  
   CALL gfrm_curr.setElementText("lbl_paper_desc",l_paper_desc_str)  
   CASE g_paper_set.c_std
     WHEN "1"
         LET l_paper_desc_str1 ="A4("  
     WHEN "2"
         LET l_paper_desc_str1 ="A3("
     OTHERWISE
         LET l_paper_desc_str1 = g_paper_set.custom, "("
   END CASE

   ##150319 add -(s)
   LET l_len = g_paper_set.len CLIPPED
   LET l_len = l_len.trim()
   LET l_width = g_paper_set.width CLIPPED
   LET l_width = l_width.trim()
   ##150319 add -(e)
   LET l_paper_desc_str1 = l_paper_desc_str1,l_len ,"*",l_width CLIPPED ,")"
   CASE g_paper_set.r_unit
      WHEN "1"
         LET l_paper_desc_str1 = l_paper_desc_str1,"cm"
      WHEN "2"
         LET l_paper_desc_str1 = l_paper_desc_str1,"inch"
   END CASE
 
  CALL gfrm_curr.setElementText("lbl_paper_desc1",l_paper_desc_str1)   
   ##150303 add -(e)


END FUNCTION


################################################################################
# Descriptions...: 判斷存入dzgc的欄位字尾，若保留字不存入
# Memo...........: crtid,crtdt,crtdp,ownid,owndp,modid,moddt
# Memo...........: cnfid,cnfdt,pstid,pstdt
# Usage..........: CALL adzp188_chk_dzgc_suffix()
# Input parameter: 
# ...............: 
# Return code....: 
# Date & Author..: 2014/02/07
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_chk_dzgc_suffix(ps_dzgc004)
  DEFINE ps_dzgc004     LIKE dzgc_t.dzgc004
  DEFINE l_dzgc_str     STRING 
  DEFINE l_suffix       LIKE type_t.num5

  LET l_suffix = 1
  LET l_dzgc_str = ps_dzgc004
  IF l_dzgc_str.getIndexOf('crtid',1)>0 OR l_dzgc_str.getIndexOf('crtdt',1)>0 OR
     l_dzgc_str.getIndexOf('crtdp',1)>0 OR l_dzgc_str.getIndexOf('ownid',1)>0 OR
     l_dzgc_str.getIndexOf('owndp',1)>0 OR l_dzgc_str.getIndexOf('modid',1)>0 OR
     l_dzgc_str.getIndexOf('moddt',1)>0 OR l_dzgc_str.getIndexOf('cnfid',1)>0 OR
     l_dzgc_str.getIndexOf('cnfdt',1)>0 OR l_dzgc_str.getIndexOf('pstid',1)>0 OR
     l_dzgc_str.getIndexOf('pstdt',1)>0 THEN     
     LET l_suffix = 0 
  END IF 
  RETURN l_suffix
END FUNCTION


################################################################################
# Descriptions...: 清除暫存檔
# Memo...........: 
# Usage..........: CALL adzp188_delete_temptable()
# Input parameter: 
# ...............: 
# Return code....: 
# Date & Author..: 2014/02/13
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_delete_temptable()

   #先將暫存檔清空
   DELETE FROM adzp188_dzga_tmp 
   DELETE FROM adzp188_dzgb_tmp
   DELETE FROM adzp188_dzgc_tmp
   DELETE FROM adzp188_dzgd_tmp
   DELETE FROM adzp188_dzgf_tmp  
   DELETE FROM adzp188_dzgb_tmp1  #處理join的wc
   DELETE FROM adzp188_dzge_tmp
   DELETE FROM adzp188_gexg_tmp      #151012-00003#1 調整tmp名稱縮為17字元
   DELETE FROM adzp188_sum2_tmp
   DELETE FROM adzp188_dzgi_tmp   #table
   DELETE FROM adzp188_dzgh_tmp
   DELETE FROM adzp188_type2_tmp
   DELETE FROM adzp188_dzgj_tmp
   DELETE FROM adzp188_xgtype_tmp   ##140521 add

END FUNCTION 

## 140110 add -(e)------------------------


################################################################################
# Descriptions...: 清除暫存檔
# Memo...........: 
# Usage..........: CALL adzp188_ref_wc_addalias(l_wc_str)
# Input parameter: ps_wc_str   wc句子(已整理好主table名)
# Input parameter: ps_dzgb009  table2
# ...............: 
# Return code....: ls_wc_alias    STRING 
# Date & Author..: 2014/02/14
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_ref_wc_addalias(ps_wc_str,ps_dzgb009)
   DEFINE ps_wc_str    STRING
   DEFINE ps_dzgb009   LIKE dzgb_t.dzgb009    
   DEFINE ls_wc_return STRING 
   DEFINE ls_wc_str    STRING 
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE ls_alias_tmp1 STRING
   DEFINE ls_alias     STRING 
   DEFINE ls_alias_tmp STRING 
   DEFINE ls_tab_tmp   STRING                 #table資料   
   DEFINE ls_cnt     LIKE type_t.num5   
   DEFINE ls_wc_tmp    base.StringBuffer    


   LET ls_wc_str = ps_wc_str

   ##找table2
   LET l_cnt = 0

   ##判斷別名使用
   LET g_sql = " SELECT COUNT(*) FROM adzp188_dzgb_tmp ",
               #" WHERE dzgb001 =? AND dzgb002=? AND (dzgb005 = ? OR dzgb009 = ?)"  #140613 mark 
               " WHERE dzgb001 =? AND dzgb002=? AND (dzgb005 = ? OR dzgb009 = ?) AND dzgb018 =? AND dzgb019 =? "   #140613 add
   PREPARE adzp188_get_dzgb005009_pre FROM g_sql
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       EXIT PROGRAM
   END IF   
   DECLARE adzp188_get_dzgb005009_cs1 CURSOR FOR adzp188_get_dzgb005009_pre    
   #EXECUTE adzp188_get_dzgb005009_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,ps_dzgb009,ps_dzgb009 INTO l_cnt     #140613 mark
   #EXECUTE adzp188_get_dzgb005009_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,ps_dzgb009,ps_dzgb009,g_cust,g_code_ide INTO l_cnt #140613 add g_cust,g_code_ide  #141013 mark
   EXECUTE adzp188_get_dzgb005009_cs1 USING g_dzga_m.dzga001,g_dzga_m.dzga002,ps_dzgb009,ps_dzgb009,g_cust,g_code_ide INTO l_cnt #141013 add    
   IF l_cnt > 0 THEN     
      LET ls_wc_tmp = base.StringBuffer.create()
      CALL ls_wc_tmp.append(ls_wc_str)
      LET ls_alias =''
      LET ls_alias_tmp =''
      LET ls_tab_tmp = ''
      LET ls_alias_tmp1 =''
      ##t1
      LET ls_alias = 't',g_alias_seq USING "<<<<<"
      ##ex: inba_t t1 前後留空白
      LET ls_alias_tmp = ps_dzgb009,' ',ls_alias
      ##ex: inba_t. 前留空白
      LET ls_tab_tmp = ' ',ps_dzgb009,'.'
      ##ex: t1.
      LET ls_alias_tmp1 = ' ',ls_alias,'.'
      ## table後加別名
      CALL ls_wc_tmp.replace(ps_dzgb009,ls_alias_tmp,1)
      ## 置換table名為別名
      WHILE ls_wc_tmp.getIndexOf(ls_tab_tmp,1) > 0
        CALL ls_wc_tmp.replace(ls_tab_tmp,ls_alias_tmp1,1)
      END WHILE
      LET g_alias_seq = g_alias_seq + 1
      LET ls_wc_str = ls_wc_tmp.toString()
   ELSE
     
       ##若沒有重覆，但裡面已有別名要清除
       LET ls_alias_tmp = ' t'
       IF ls_wc_str.getIndexOf(' t',1)>0 THEN 
           ##ex: t1 
           LET ls_alias_tmp = ls_wc_str.subString(ls_wc_str.getIndexOf(' t',1),ls_wc_str.getIndexOf(' t',1)+2)
           ##ex: t1.
           LET ls_alias_tmp1 = ls_alias_tmp,"."
           ##ex: inbb_t.
           LET ls_tab_tmp = ' ',ps_dzgb009,'.'
           LET ls_alias_tmp = ls_alias_tmp," "
           LET ls_wc_tmp = base.StringBuffer.create()
           CALL ls_wc_tmp.append(ls_wc_str)
           CALL ls_wc_tmp.replace(ls_alias_tmp1 , '',1)
           WHILE ls_wc_tmp.getIndexOf(ls_alias_tmp1,1) > 0
              CALL ls_wc_tmp.replace(ls_alias_tmp1,ls_tab_tmp,1)
           END WHILE 
           LET ls_wc_str = ls_wc_tmp.toString()   
       END IF     
   END IF 
   
   LET ls_wc_return = ls_wc_str
   RETURN ls_wc_return,ls_alias  
   
END FUNCTION 



################################################################################
# Descriptions...: 清除暫存檔
# Memo...........: 
# Usage..........: CALL adzp188_ref_wc_addalias(l_wc_str)
# Input parameter: ps_wc_str   wc句子(已整理好主table名)
# Input parameter: ps_dzgb009  table2
# ...............: 
# Return code....: ls_wc_alias    STRING 
# Date & Author..: 2014/02/14
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_ref_wc_delalias(ps_wc_str,ps_dzgb009)
   DEFINE ps_wc_str    STRING
   DEFINE ps_dzgb009   LIKE dzgb_t.dzgb009    
   DEFINE ls_wc_return STRING 
   DEFINE ls_wc_str    STRING 
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE ls_alias_tmp1 STRING
   DEFINE ls_alias     STRING 
   DEFINE ls_alias_tmp STRING 
   DEFINE ls_tab_tmp   STRING                 #table資料   
   DEFINE ls_cnt     LIKE type_t.num5   
   DEFINE ls_wc_tmp    base.StringBuffer    


   LET ls_wc_str = ps_wc_str
   ##若沒有重覆，但裡面已有別名要清除
   LET ls_alias_tmp = ' t'
   IF ls_wc_str.getIndexOf(' t',1)>0 THEN 
       ##ex: t1 
       LET ls_alias_tmp = ls_wc_str.subString(ls_wc_str.getIndexOf(' t',1),ls_wc_str.getIndexOf(' t',1)+2)
       ##ex: t1.
       LET ls_alias_tmp1 = ls_alias_tmp,"."
       ##ex: inbb_t.
       LET ls_tab_tmp = ' ',ps_dzgb009,'.'
       LET ls_alias_tmp = ls_alias_tmp," "
       LET ls_wc_tmp = base.StringBuffer.create()
       CALL ls_wc_tmp.append(ls_wc_str)
       CALL ls_wc_tmp.replace(ls_alias_tmp1 , '',1)
       WHILE ls_wc_tmp.getIndexOf(ls_alias_tmp1,1) > 0
          CALL ls_wc_tmp.replace(ls_alias_tmp1,ls_tab_tmp,1)
       END WHILE 
       LET ls_wc_str = ls_wc_tmp.toString()   
   END IF     

   
   LET ls_wc_return = ls_wc_str
   RETURN ls_wc_return,ls_alias  
   
END FUNCTION 


################################################################################
# Descriptions...: 判斷欄位是否為blob或clob
# Memo...........: 
# Usage..........: CALL adzp188_chk_field_blobclob(lc_dzeb002)
# Input parameter: ps_field     欄位
# Return code....: 1:非blob欄位/0:blob欄位
# Date & Author..: 2014/02/18
# Modify.........:
################################################################################
FUNCTION adzp188_chk_field_blobclob(ps_field)
   DEFINE ps_field     LIKE dzgc_t.dzgc004
   DEFINE l_cnt        LIKE type_t.num5

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM dzeb_t WHERE dzeb006 LIKE 'B%' AND dzeb002 = ps_field  

   IF l_cnt > 0 THEN
      RETURN 0
   ELSE
      RETURN 1
   END IF 

END FUNCTION


################################################################################
# Descriptions...: 判斷欄位是否為blob或clob
# Memo...........: 
# Usage..........: CALL adzp188_field_sel('Y')
# Input parameter: ps_yn    Y:全選/N:全不選
# Return code....: 
# Date & Author..: 2014/02/21
# Modify.........:
################################################################################
FUNCTION adzp188_field_sel(ps_yn)
   DEFINE ps_yn     LIKE dzgc_t.dzgc004
   DEFINE li       LIKE type_t.num5

   FOR li = 1 TO g_fieldsel.getLength()
       LET g_fieldsel[li].dzgcchk = ps_yn
   END FOR 

END FUNCTION


################################################################################
# Descriptions...: GR印出資料複製萃取排序欄位
# Memo...........: 
# Usage..........: CALL adzp188_copy_dzge_from_sel1()
# Return code....: 
# Date & Author..: 2014/02/24
# Modify.........:
################################################################################
FUNCTION adzp188_copy_dzge_from_sel1()
   DEFINE li           LIKE type_t.num5

   ##若原先有資料，要先刪掉
   DELETE FROM adzp188_dzge_tmp
    WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 
      AND dzge003 = '2'
      #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add   ##141013 mark
       AND dzge009 = g_code_ide                                    ##141013 add   

    LET g_sql = " INSERT INTO adzp188_dzge_tmp ",
                   " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
         PREPARE adzp188_dzge_tmp_ins_pre1 FROM g_sql      
    ##141013 mark -(e)  
   FOR li = 1 TO g_gr_groupsel1.getLength()
   
       ##141013 mark -(s)  
       #INSERT INTO adzp188_dzge_tmp
       #VALUES ( g_dzga_m.dzga001,g_dzga_m.dzga002,'2', li, g_dzge005, g_gr_groupsel1[li].dzge006, g_gr_groupsel1[li].dzge007,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
       ##141013 mark -(e)  
       EXECUTE adzp188_dzge_tmp_ins_pre1 USING '2', li, g_dzge005, g_gr_groupsel1[li].dzge006, g_gr_groupsel1[li].dzge007,g_cust,g_code_ide  #141013 add       
   END FOR 

END FUNCTION



################################################################################
# Descriptions...: GR群組頁簽-已挑選欄位預設資料
# Memo...........: 
# Usage..........: CALL adzp188_gr_groupsel_default()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/25
# Modify.........:
################################################################################
FUNCTION adzp188_gr_groupsel_default()
   DEFINE lc_dzge003   LIKE dzge_t.dzge003
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE l_dzge_cnt   LIKE type_t.num5
   DEFINE lc_dzeb002_str STRING 
   DEFINE li_i         LIKE type_t.num5
   DEFINE lc_dzeb002   LIKE dzeb_t.dzeb002
   DEFINE lc_dzge004   LIKE dzge_t.dzge004
   DEFINE lc_dzge005   LIKE dzge_t.dzge005
   DEFINE lc_dzge006   LIKE dzge_t.dzge006
   DEFINE lc_dzge007   LIKE dzge_t.dzge007   


   ##只抓主table有docno字尾的欄位過去groupsel     
   LET g_sql = "INSERT INTO adzp188_dzge_tmp ",
               #"VALUES('",g_dzga_m.dzga001,"','", g_dzga_m.dzga002,"',?,?,?,?,?,?,?)"  #140613 add ,?,?  ##141013 mark
               "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)"  #141013 add 
   PREPARE adzp188_dzge_tmp_ins_pre2 FROM g_sql 
   
   LET l_dzge_cnt = 0
   SELECT COUNT(*) INTO l_dzge_cnt FROM adzp188_dzge_tmp
    WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
      #AND dzge008 = g_cust AND dzge009 = g_code_ide #140613 add  ##141013 mark 
      AND dzge009 = g_code_ide                                    ##141013 add 
    
   IF l_dzge_cnt = 0 THEN  ##先從tablesel補進adzp188_dzge_temp 
     LET li_cnt = 1
     FOR li_i = 1 TO g_tablesel.getLength()
         IF li_i > 1 THEN 
            EXIT FOR 
         END IF 
                  
         LET g_sql = "SELECT dzeb002 FROM dzeb_t",                     
                     " WHERE dzeb001 = '",g_tablesel[li_i].id,"'",
                     " ORDER BY dzeb002"
         PREPARE gr_groupsel_b_fill_pre1 FROM g_sql
         DECLARE gr_groupsel_b_fill_curs1 CURSOR FOR gr_groupsel_b_fill_pre1
         FOREACH gr_groupsel_b_fill_curs1 INTO lc_dzeb002
             ##欄位若是blob或clob不存入清單
             IF adzp188_chk_field_blobclob(lc_dzeb002) THEN  
                LET lc_dzeb002_str = lc_dzeb002 
                ##判斷是單號欄位
                IF lc_dzeb002_str.getIndexOf('docno',1)>0 THEN
                   EXECUTE adzp188_dzge_tmp_ins_pre2 USING '1', li_cnt, '', lc_dzeb002, '1',g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                   EXECUTE adzp188_dzge_tmp_ins_pre2 USING '2', li_cnt, '', lc_dzeb002, '1',g_cust,g_code_ide #140613 add ,g_cust,g_code_ide
                END IF 
             END IF 
         END FOREACH 
     END FOR 

   END IF 

   
END FUNCTION


##20140226-(S)
################################################################################
# Descriptions...: GR排版頁簽-已挑選欄位樹狀
# Memo...........: 
# Usage..........: CALL adzp188_typelist2_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/26
# Modify.........:
################################################################################
FUNCTION adzp188_typelist2_b_fill()
   DEFINE lc_cnt       LIKE type_t.num5
   #DEFINE lc_id2       LIKE type_t.chr20    ##140507 mark
   DEFINE lc_id2       LIKE dzgc_t.dzgc004   ##140507 add
   DEFINE lc_pid2      LIKE type_t.chr20
   DEFINE lc_idseq2    LIKE type_t.num5
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_pidseq2   LIKE type_t.num5
   DEFINE lc_pidtype2  LIKE type_t.chr1
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lc_alias2    LIKE dzgh_t.dzgh009
   DEFINE l_gztz001    LIKE gztz_t.gztz001
  

   CALL g_typelist2.clear()

   LET li_cnt = 1
   LET g_sql = " SELECT id2,dzebl003,pid2,idseq2,pidseq2,pidtype2,alias2 FROM adzp188_type2_tmp ",  
               "   LEFT OUTER JOIN dzebl_t ON dzebl001 = id2 AND dzebl002 ='",g_lang,"'",  
               ##141013 mark -(s) 
               #" WHERE dzgh001 ='",g_dzga_m.dzga001,"'", " AND dzgh002 ='",g_dzga_m.dzga002,"'",      
               #"   AND dzgh003 ='",g_dzga_m.dzga001,"'",
               #"    AND dzgh011 ='",g_cust,"' AND dzgh012 ='",g_code_ide,"'",           #140613 add
               ##141013 mark -(e)
               ##141013 add -(s)
               " WHERE dzgh001 ='",g_dzga_m.dzga001,"'", " AND dzgh002 ='",gs_ver,"'",      
               "   AND dzgh003 ='",g_dzga_m.dzga001,"'",
               "   AND dzgh012 ='",g_code_ide,"'",          
               ##141013 add -(e)
               " ORDER BY pidtype2,pidseq2,idseq2 "
               #" ORDER BY seq "
   PREPARE typelist2_b_fill_pre1 FROM g_sql 
   DECLARE typelist2_b_fill_curs1 CURSOR FOR typelist2_b_fill_pre1
   FOREACH typelist2_b_fill_curs1 INTO lc_id2, lc_dzebl003,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2
     IF lc_pid2 = "" OR cl_null(lc_pid2) THEN 
        LET g_typelist2[li_cnt].typename2 = lc_id2
        LET g_typelist2[li_cnt].typeid2 = lc_id2
        LET g_typelist2[li_cnt].typeexp2 = TRUE  #開
        LET g_typelist2[li_cnt].typeisnode2 = TRUE  #有欄位了
        LET g_typelist2[li_cnt].typepidseq2 = lc_pidseq2  #區塊順序
        LET g_typelist2[li_cnt].typepidtype2 = lc_pidtype2  #區塊 
        LET g_typelist2[li_cnt].typealias2 = lc_alias2  #表格別名 
        LET li_cnt = li_cnt + 1
     ELSE 
      ##子節點
        ##140424
        IF cl_null(lc_dzebl003) THEN 
          SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
           WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
             AND dzgd003 = lc_id2
             #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add  ##141013 mark
              AND dzgd008 = g_code_ide              ##141013 add 
             
        END IF         
        SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = lc_id2
           AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
           ##161227-00056#1 add -(s)
           AND gztz001 NOT LIKE 'erp%'   
           AND gztz001 NOT LIKE 'all%'
           AND gztz001 NOT LIKE 'b2b%'
           AND gztz001 NOT LIKE 'pos%'
           AND gztz001 NOT LIKE 'dsm%'
           ##161227-00056#1 add -(e)           
        IF l_gztz001 = lc_alias2 THEN 
          LET g_typelist2[li_cnt].typename2 = lc_id2,":",lc_dzebl003
        ELSE 
          LET g_typelist2[li_cnt].typename2 = "(",lc_alias2,")",lc_id2,":",lc_dzebl003
        END IF 
        LET g_typelist2[li_cnt].typepid2 = lc_pid2
        LET g_typelist2[li_cnt].typeid2 = lc_id2 
        LET g_typelist2[li_cnt].typeexp2 = FALSE  #不開
        LET g_typelist2[li_cnt].typeisnode2 = FALSE  #沒有欄位了
        LET g_typelist2[li_cnt].typepidseq2 = lc_pidseq2  #區塊順序
        LET g_typelist2[li_cnt].typepidtype2 = lc_pidtype2  #區塊
        LET g_typelist2[li_cnt].typeseq2 = lc_idseq2   
        LET g_typelist2[li_cnt].typealias2 = lc_alias2  #表格別名
      LET li_cnt = li_cnt + 1
     END IF 
   END FOREACH

END FUNCTION


##20140226 janet
################################################################################
# Descriptions...: GR排版頁簽-已挑選欄位預設資料
# Memo...........: 
# Usage..........: CALL adzp188_typelist2_default()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/26
# Modify.........:
################################################################################
FUNCTION adzp188_typelist2_default()
   DEFINE lc_dzgh004   LIKE dzgh_t.dzgh004
   DEFINE lc_dzgh005   LIKE dzgh_t.dzgh005
   DEFINE lc_dzgh006   LIKE dzgh_t.dzgh006
   DEFINE lc_dzgh007   LIKE dzgh_t.dzgh007
   DEFINE lc_dzgh008   LIKE dzgh_t.dzgh008
   DEFINE lc_dzgh009   LIKE dzgh_t.dzgh009
   DEFINE lc_dzgh005_t LIKE dzgh_t.dzgh005
   DEFINE lc_dzgh006_t LIKE dzgh_t.dzgh006
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_cnt       LIKE type_t.num5   
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lc_typename2 LIKE type_t.chr20
   DEFINE lc_typepid2  LIKE type_t.chr20
   DEFINE i            INTEGER
   DEFINE l_zone       STRING 
   DEFINE lc_typeid2   LIKE type_t.chr20 
   DEFINE lc_masterzone   INTEGER
   DEFINE lc_masterzone_t INTEGER  
   DEFINE lc_detailrow    INTEGER
   DEFINE lc_detailrow_t  INTEGER
   DEFINE l_str           STRING

      

   SELECT COUNT(*) INTO lc_cnt FROM adzp188_dzgh_tmp
   WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
     AND dzgh003 = g_dzga_m.dzga001
     #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
     AND dzgh012 = g_code_ide   ##141013 add 
       
   LET lc_dzgh005_t = ''
   LET lc_dzgh006_t = ''
   LET li_cnt = 1

   ##141013 add -(s)
   ##INSERT PREPARE
   LET g_sql = " INSERT INTO adzp188_type2_tmp ",                    
               "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?)" 
   PREPARE type2_tmp_ins_pre FROM g_sql   
   ##141013 add -(e)

   IF lc_cnt > 0 THEN 
 
       LET g_sql = " SELECT dzgh004, dzgh005, dzgh006, dzgh007, dzebl003, dzgh008,dzgh009  FROM adzp188_dzgh_tmp ",  
                   "   LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgh007 AND dzebl002 ='",g_lang,"'",   
                   #"  WHERE dzgh001 ='",g_dzga_m.dzga001,"'", " AND dzgh002 ='",g_dzga_m.dzga002,"'",       #140923 elena mark
                   "  WHERE dzgh001 ='",g_dzga_m.dzga001,"'", " AND dzgh002 ='",gs_ver,"'",                  #140923 elena add
                   "    AND dzgh003 ='",g_dzga_m.dzga001,"'",
                   #"    AND dzgh011 ='",g_cust,"' AND dzgh012 ='",g_code_ide,"'",                           ##140613 add ##141013 mark
                   "    AND dzgh012 ='",g_code_ide,"'",                            ##141013 add
                   "  ORDER BY dzgh005,dzgh006,dzgh008 "
       PREPARE typelist2_b_fill_pre FROM g_sql 
       DECLARE typelist2_b_fill_curs CURSOR FOR typelist2_b_fill_pre
       FOREACH typelist2_b_fill_curs INTO lc_dzgh004, lc_dzgh005, lc_dzgh006,lc_dzgh007,lc_dzebl003,lc_dzgh008,lc_dzgh009
               IF cl_null(lc_dzgh005_t) THEN LET lc_dzgh005_t=" " END IF 
               IF lc_dzgh005 <> lc_dzgh005_t THEN ##單頭或單身
                  #新增一個父節點
                  IF lc_dzgh005 = "1" THEN LET l_zone ="單頭" END IF 
                  IF lc_dzgh005 = "2" THEN LET l_zone ="單身" END IF 
                  LET lc_typeid2 = l_zone,lc_dzgh006 USING "<<<<<<"             
                  LET lc_dzgh005_t = lc_dzgh005
                  LET lc_dzgh006_t = lc_dzgh006
                  ##janet 140226
                  ##141013 mark -(s)
                  #INSERT INTO adzp188_type2_tmp
                         #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_typeid2,'',0,lc_dzgh006,lc_dzgh005,'',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                  ##141013 mark -(e)       
                  EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001,lc_typeid2,'', '0' ,lc_dzgh006,lc_dzgh005,'',g_cust,g_code_ide ##141013 add
                  
                  LET li_cnt = 1
                  ##141013 mark -(s)         
                  #INSERT INTO adzp188_type2_tmp
                         #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_dzgh007,lc_typeid2,li_cnt,lc_dzgh006,lc_dzgh005,lc_dzgh009,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                  ##141013 mark -(e)       
                  EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001,lc_dzgh007,lc_typeid2,li_cnt,lc_dzgh006,lc_dzgh005,lc_dzgh009,g_cust,g_code_ide  ##141013 add           
                  LET li_cnt = li_cnt + 1                      
               ELSE###相同的單頭或單身
                   IF cl_null(lc_dzgh006_t) THEN LET lc_dzgh006_t=" " END IF 
                   IF lc_dzgh006 <> lc_dzgh006_t THEN  ##區塊順序不同 
                      #新增一個父節點
                      IF lc_dzgh005 = "1" THEN LET l_zone ="單頭" END IF 
                      IF lc_dzgh005 = "2" THEN LET l_zone ="單身" END IF                       
                      LET lc_typeid2 = l_zone,lc_dzgh006 USING "<<<<<<" 
                      ##141013 mark -(s)        
                      #INSERT INTO adzp188_type2_tmp
                      #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_typeid2,'',0,lc_dzgh006,lc_dzgh005,'',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                      ##141013 mark -(e)
                      EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001,lc_typeid2,'','0',lc_dzgh006,lc_dzgh005,'',g_cust,g_code_ide  ##141013 add
                      LET lc_dzgh006_t = lc_dzgh006   
                      LET li_cnt = 1
                      ##141013 mark -(s) 
                      #INSERT INTO adzp188_type2_tmp
                             #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_dzgh007,lc_typeid2,li_cnt,lc_dzgh006,lc_dzgh005,lc_dzgh009,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                      ##141013 mark -(e) 
                      EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001,lc_dzgh007,lc_typeid2,li_cnt,lc_dzgh006,lc_dzgh005,lc_dzgh009,g_cust,g_code_ide     ##141013 add
                      LET li_cnt = li_cnt + 1  
                   ELSE 
                       ##141013 mark -(s)
                       #INSERT INTO adzp188_type2_tmp
                               #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_dzgh007,lc_typeid2,li_cnt,lc_dzgh006,lc_dzgh005,lc_dzgh009,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                       ##141013 mark -(e)        
                       EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001,lc_dzgh007,lc_typeid2,li_cnt,lc_dzgh006,lc_dzgh005,lc_dzgh009,g_cust,g_code_ide #141013 add        
                       LET li_cnt = li_cnt + 1                      
                   END IF 
                   
      
               END IF  
               ##子節點
  
           
       END FOREACH

       ##單頭區塊數
      SELECT MAX(dzgh006) INTO g_gr_temp_set.c_masterzone FROM adzp188_dzgh_tmp
       WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002 AND dzgh003 = g_dzga_m.dzga001 AND dzgh005 = '1'
         #AND dzgh011 = g_cust AND dzgh012 = g_code_ide   #140613 add  ##141013 mark 
          AND dzgh012 = g_code_ide   #141013 add
       
       IF cl_null(g_gr_temp_set.c_masterzone) OR g_gr_temp_set.c_masterzone IS NULL THEN
          LET g_gr_temp_set.c_masterzone ="1" 
       END IF 
       
       ##單身行數
      SELECT MAX(dzgh006) INTO g_gr_temp_set.c_detailrow FROM adzp188_dzge_tmp
       WHERE dzgh001 =  g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002 AND dzgh003 =  g_dzga_m.dzga001 AND dzgh005 = '2'
         #AND dzgh011 = g_cust AND dzgh012 = g_code_ide   #140613 add   ##141013 mark
         AND dzgh012 = g_code_ide   #140613 add                         ##141013 add

        IF cl_null(g_gr_temp_set.c_detailrow) OR g_gr_temp_set.c_detailrow IS NULL THEN
          LET g_gr_temp_set.c_detailrow ="1" 
       END IF
       
   ELSE 
       DELETE FROM adzp188_type2_tmp    #150807-00006 add
       LET lc_masterzone = g_gr_temp_set.c_masterzone
       LET lc_detailrow = g_gr_temp_set.c_detailrow
       FOR i = 1 TO lc_masterzone
           #新增一個單頭父節點
           LET l_zone ='單頭'
           LET l_str = i
           LET lc_typeid2 = l_zone, l_str  
           ##141013 mark -(s)          
           #INSERT INTO adzp188_type2_tmp
           #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001, lc_typeid2 ,'', 0, i, '1','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
           ##141013 mark -(e)
           EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001, lc_typeid2 ,'', '0', i, '1','',g_cust,g_code_ide  ##141013 add
       END FOR 
       FOR i = 1 TO lc_detailrow
           #新增一個單頭父節點
           LET l_zone ='單身' 
           LET l_str = i
           LET lc_typeid2 = l_zone, l_str 
           ##141013 mark -(s)           
           #INSERT INTO adzp188_type2_tmp
           #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001, lc_typeid2 ,'' ,0 ,i ,'2','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
           ##141013 mark -(e) 
           EXECUTE type2_tmp_ins_pre USING g_dzga_m.dzga001, lc_typeid2 ,'' ,'0' ,i ,'2','',g_cust,g_code_ide  ##141013 add
       END FOR        
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 篩選頁簽-維護dzgf_t及更新wc組合字串
# Memo...........: 
# Usage..........: CALL adzp188_maintain_typelist2(g_typelist1,g_typelist2, "add")
# Input parameter: pi_idx     指定序號
# ...............: pi_src_idx 目地序號
# ...............: ps_type    add新增, upd修改或del刪除
# Return code....: None
# Date & Author..: 2013/12/05
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_typelist2(pi_idx,pi_src_idx, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE pi_src_idx   LIKE type_t.num5
   DEFINE ps_type      STRING
   #DEFINE lc_id2       LIKE type_t.chr20    ##140507舊版mark
   #DEFINE lc_pid2      LIKE type_t.chr20    ##140507舊版mark
   DEFINE lc_id2       LIKE dzgc_t.dzgc004     ##140507新版
   DEFINE lc_pid2      LIKE dzgc_t.dzgc004     ##140507新版
   DEFINE lc_idseq2    LIKE type_t.num5
   DEFINE lc_pidseq2   LIKE type_t.num5
   DEFINE lc_pidtype2  LIKE type_t.chr1
   DEFINE lc_alias2    LIKE dzgh_t.dzgh009  ##140327 add
   DEFINE li_i         LIKE type_t.num5  
   


   
   CASE ps_type
      WHEN "add"   

         ##141013 add -(s)
         ##INSERT PREPARE
         LET g_sql = " INSERT INTO adzp188_type2_tmp ",                    
                     "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?)" 
         PREPARE type2_tmp_ins_pre1 FROM g_sql   
         ##141013 add -(e) 
         
         SELECT MAX(idseq2) + 1 INTO g_dzgh_d.dzgh008 FROM adzp188_type2_tmp
          WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
            AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 = g_typelist2[pi_src_idx].typepidtype2
            AND pidseq2 = g_typelist2[pi_src_idx].typepidseq2    
            #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
            AND dzgh012 = g_code_ide                                     ##141013 add  
                   
          
         IF cl_null(g_dzgh_d.dzgh008) OR g_dzgh_d.dzgh008 = 0 THEN
            LET g_dzgh_d.dzgh008 = 1
         END IF
             
             #由s_typelist1新增進入, 可能為多選新增
             FOR pi_idx = 1 TO g_typelist1.getLength()
                 IF gdig_curr.isRowSelected("s_typelist1", pi_idx) THEN
                    #如果是點在table節點上, 批次新增所有欄位
                    IF g_typelist1[pi_idx].typeisnode1 THEN
                       #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = pi_idx + 1 TO g_typelist1.getLength()
                           IF NOT g_typelist1[li_i].typeisnode1 THEN
                             LET lc_id2 = g_typelist1[li_i].typeid1
                             IF g_typelist2[pi_src_idx].typeisnode2 = 0 THEN 
                                LET lc_pid2 = g_typelist2[pi_src_idx].typepid2
                             ELSE 
                                LET lc_pid2 = g_typelist2[pi_src_idx].typeid2
                             END IF 
                             LET lc_idseq2 = g_dzgh_d.dzgh008
                             LET lc_pidseq2 = g_typelist2[pi_src_idx].typepidseq2
                             LET lc_pidtype2 = g_typelist2[pi_src_idx].typepidtype2
                             LET lc_alias2 = g_typelist1[li_i].typealias1   ##140327 add
                             #IF adzp188_chk_type2_field_exit(lc_pidtype2,lc_pidseq2,lc_id2) THEN   #140314 janet add#141127 mark
                             IF adzp188_chk_type2_field_exit(lc_pidtype2,lc_pidseq2,lc_id2,lc_alias2) THEN   #141127 add
                                 ##141013 mark -(s)
                                 #INSERT INTO adzp188_type2_tmp         
                                     ##VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2) ###140327 add lc_alias2 #140613mark
                                     #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2,g_cust,g_code_ide) ###140613 add
                                 ##141013 mark -(e)  
                                 EXECUTE type2_tmp_ins_pre1 USING g_dzga_m.dzga001,lc_id2,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2,g_cust,g_code_ide ##141013 add  
                                     LET g_dzgh_d.dzgh008 = g_dzgh_d.dzgh008 + 1 
                             END IF     
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                         LET lc_id2 = g_typelist1[pi_idx].typeid1
                         IF g_typelist2[pi_src_idx].typeisnode2 = 0 THEN 
                            LET lc_pid2 = g_typelist2[pi_src_idx].typepid2
                         ELSE 
                            LET lc_pid2 = g_typelist2[pi_src_idx].typeid2
                         END IF 
                         LET lc_idseq2 = g_dzgh_d.dzgh008
                         LET lc_pidseq2 = g_typelist2[pi_src_idx].typepidseq2
                         LET lc_pidtype2 = g_typelist2[pi_src_idx].typepidtype2
                         LET lc_alias2 = g_typelist1[pi_idx].typealias1   ##140327 add
                         #IF adzp188_chk_type2_field_exit(lc_pidtype2,lc_pidseq2,lc_id2) THEN   #140314 janet add #141127 mark
                         IF adzp188_chk_type2_field_exit(lc_pidtype2,lc_pidseq2,lc_id2,lc_alias2) THEN   #141127 add
                             ##141013 mark -(s)
                             #INSERT INTO adzp188_type2_tmp         
                             ##VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2) ###140327 add lc_alias2
                             #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2,g_cust,g_code_ide) ###140613 add
                             ##141013 mark -(s)
                             EXECUTE type2_tmp_ins_pre1 USING g_dzga_m.dzga001,lc_id2,lc_pid2,lc_idseq2,lc_pidseq2,lc_pidtype2,lc_alias2,g_cust,g_code_ide #141013 add
                             LET g_dzgh_d.dzgh008 = g_dzgh_d.dzgh008 + 1  

                         END IF 
                    END IF
                 END IF
             END FOR


      WHEN "upd"
         #IF pi_idx > 0 THEN
            #UPDATE adzp188_dzgf_tmp SET dzgf004 = g_dzgf_d.dzgf004, dzgf005 = g_dzgf_d.dzgf005,
                                        #dzgf006 = g_dzgf_d.dzgf006, dzgf007 = g_dzgf_d.dzgf007,
                                        #dzgf008 = g_dzgf_d.dzgf008, dzgf009 = g_dzgf_d.dzgf009,
                                        #dzgf010 = g_dzgf_d.dzgf010
             #WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
               #AND dzgf003 = g_filter[pi_idx].dzgf003
         #END IF
         
      WHEN "del"

         ##140320-舊版mark-(s)
         #IF pi_idx > 0 THEN
            #DELETE FROM adzp188_type2_tmp
             #WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
               #AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 = g_typelist2[pi_idx].typepidtype2
               #AND idseq2 = g_typelist2[pi_idx].typeseq2 AND pidseq2 = g_typelist2[pi_idx].typepidseq2
#
         #END IF
         ##140320-舊版mark-(e)
         ##140320-新版add-(s)
         IF pi_idx > 0 THEN 
             FOR pi_idx = 1 TO g_typelist2.getLength()
                 IF gdig_curr.isRowSelected("s_typelist2", pi_idx) THEN
                    #如果是點在table節點上, 批次新增所有欄位
                    IF g_typelist2[pi_idx].typeisnode2 THEN
                       #因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = pi_idx + 1 TO g_typelist2.getLength()
                           IF NOT g_typelist2[li_i].typeisnode2 THEN
                              DELETE FROM adzp188_type2_tmp
                               WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
                                 AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 = g_typelist2[pi_idx].typepidtype2
                                 AND idseq2 = g_typelist2[pi_idx].typeseq2 AND pidseq2 = g_typelist2[pi_idx].typepidseq2
                                 #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
                                 AND dzgh012 = g_code_ide   ##141013 add
                                 AND alias2 = g_typelist2[pi_src_idx].typealias2              ##141127 add   
                         
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                        DELETE FROM adzp188_type2_tmp

                          WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
                            AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 = g_typelist2[pi_idx].typepidtype2
                            AND idseq2 = g_typelist2[pi_idx].typeseq2 AND pidseq2 = g_typelist2[pi_idx].typepidseq2
                            #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add     ##141013 mark
                            AND dzgh012 = g_code_ide    ##141013 add   
                            AND alias2 = g_typelist2[pi_idx].typealias2              ##141127 add   
                          
                    END IF
                 END IF
             END FOR
         END IF 
         ##140320-新版add-(e)
   END CASE

   #CALL adzp188_refresh_seq("s_typelist2")
   CALL adzp188_typelist2_b_fill()

END FUNCTION


################################################################################
# Descriptions...: GR排版頁簽-維護typelist2
# Memo...........: 
# Usage..........: CALL adzp188_maintain_type2_pid()
# Input parameter: pi_idx     指定序號
# ...............: pi_src_idx 目地序號
# ...............: ps_type    add新增, upd修改或del刪除
# Return code....: None
# Date & Author..: 2014/02/27
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_type2_pid()
  DEFINE lc_masterzone_t   LIKE type_t.num5
  DEFINE lc_detailrow_t    LIKE type_t.num5
  DEFINE lc_masterzone     LIKE type_t.num5
  DEFINE lc_detailrow      LIKE type_t.num5
  DEFINE i                 LIKE type_t.num5
  DEFINE lc_id2            LIKE type_t.chr20
  DEFINE l_k               LIKE type_t.num5   #141013 add


       ##141013 add -(s)
       ##INSERT PREPARE
       LET g_sql = " INSERT INTO adzp188_type2_tmp ",                    
                   "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?)" 
       PREPARE type2_tmp_ins_pre2 FROM g_sql   
       ##141013 add -(e)   

       LET lc_masterzone = g_gr_temp_set.c_masterzone 
       #抓單頭區塊數
       SELECT MAX(pidseq2) INTO lc_masterzone_t FROM adzp188_type2_tmp
        WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 =g_dzga_m.dzga002      
          AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 ='1'
          #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
          AND dzgh012 = g_code_ide                                     ##141013 add    
            
       IF lc_masterzone_t > 0 THEN  ##已有維護
           LET lc_masterzone = g_gr_temp_set.c_masterzone
           IF lc_masterzone > lc_masterzone_t THEN 
              FOR i = lc_masterzone_t + 1 TO lc_masterzone                  
                  LET lc_id2 = "單頭",i USING "<<<<<<"
                  ##141013 mark -(s)
                  #INSERT INTO adzp188_type2_tmp         
                  #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,'',0,i,'1','',g_cust,g_code_ide)  #140615 add ,g_cust,g_code_ide
                  ##141013 mark -(e)
                  ##141013 add -(s)
                  LET l_k = 0 
                  EXECUTE type2_tmp_ins_pre2 USING g_dzga_m.dzga001,lc_id2,'',l_k,i,'1','',g_cust,g_code_ide 
                  ##141013 add -(e)
              END FOR               
           ELSE 
              FOR i = lc_masterzone + 1 TO lc_masterzone_t
                  DELETE FROM adzp188_type2_tmp       
                   WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 =g_dzga_m.dzga002      
                     AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 ='1' AND pidseq2 = i
                     #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
                      AND dzgh012 = g_code_ide   ##141013 add
                                       
              END FOR               
           END IF 
       #140912 add -(s)
       ELSE    
              LET lc_masterzone_t = 0
              FOR i = lc_masterzone_t + 1 TO lc_masterzone
                  LET lc_id2 = "單頭",i USING "<<<<<<"
                  ##141013 mark -(s)
                  #INSERT INTO adzp188_type2_tmp         
                  #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,'',0,i,'1','',g_cust,g_code_ide)
                  ##141013 mark -(e)
                  ##141013 add -(s)
                  LET l_k = 0                  
                  EXECUTE type2_tmp_ins_pre2 USING g_dzga_m.dzga001,lc_id2,'',l_k,i,'1','',g_cust,g_code_ide  
                  ##141013 add -(e)
              END FOR        
       #140912 add -(e)           
       END IF 

        #抓單身行數
        LET lc_detailrow = g_gr_temp_set.c_detailrow
       SELECT  MAX(pidseq2) INTO lc_detailrow_t FROM adzp188_type2_tmp
        WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 =g_dzga_m.dzga002      
          AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 ='2' 
          #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
          AND dzgh012 = g_code_ide #141013 add   
       
       IF lc_detailrow_t > 0 THEN  ##已有維護
           
           IF lc_detailrow > lc_detailrow_t THEN 
              FOR i = lc_detailrow_t + 1 TO lc_detailrow
                  LET lc_id2 = "單身",i USING "<<<<<<"
                  ##141013 mark -(s)
                  #INSERT INTO adzp188_type2_tmp         
                  #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,'',0,i,'2','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                  ##141013 mark -(e)
                  ##141013 add -(s)
                  LET l_k = 0                    
                  EXECUTE type2_tmp_ins_pre2 USING g_dzga_m.dzga001,lc_id2,'',l_k,i,'2','',g_cust,g_code_ide  
                  ##141013 add -(e)
              END FOR               
           ELSE 
              FOR i = lc_detailrow + 1 TO lc_detailrow_t
                  DELETE FROM adzp188_type2_tmp   
                   WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 =g_dzga_m.dzga002      
                     AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 ='2' AND pidseq2 = i
                     #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   #141013 mark
                     AND dzgh012 = g_code_ide                                     #141013 add   
                   
              END FOR               
           END IF
       #140703 add -(s)
       ELSE    
              LET lc_detailrow_t = 0
              FOR i = lc_detailrow_t + 1 TO lc_detailrow
                  LET lc_id2 = "單身",i USING "<<<<<<"
                  ##141013 mark -(s)
                  #INSERT INTO adzp188_type2_tmp         
                  #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,g_dzga_m.dzga001,lc_id2,'',0,i,'2','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                  ##141013 mark -(e)
                  ##141013 add -(s)
                  LET l_k = 0                   
                  EXECUTE type2_tmp_ins_pre2 USING g_dzga_m.dzga001,lc_id2,'',l_k,i,'2','',g_cust,g_code_ide  
                  ##141013 add -(e)
              END FOR        
       #140703 add -(e)
       END IF 
          
END FUNCTION 
##20140226-(e)

################################################################################
# Descriptions...: 確認reference table是主或第一個單身table
# Memo...........: 
# Usage..........: CALL adzp188_chk_table_needinsert(ls_table_tmp)
# Input parameter: ps_table   參考table
# Return code....: li_result  此reference資訊是否要處理
# Date & Author..: 2014/03/01
# Modify.........:
################################################################################
FUNCTION adzp188_chk_table_needinsert(ps_table)
   DEFINE ps_table     LIKE dzgb_t.dzgb005
   DEFINE li_result    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM adzp188_dzgi_tmp
   WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
     AND dzgi004 = ps_table AND (dzgi003 = 1 OR dzgi003 = 2)
     #AND dzgi005 = g_cust AND dzgi006 = g_code_ide  #140613 add  ##141013 mark 
     AND dzgi006 = g_code_ide     ##141013 add 


      #SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
      #WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
        #AND dzgi004 = ls_dzai[ls_i].dzai008    

   IF l_cnt = 0 THEN  
      LET li_result = 0 
   ELSE 
      LET li_result = 1
   END IF 
    
   RETURN li_result
   
END FUNCTION 

################################################################################
# Descriptions...: 顯示紙張長寬
# Memo...........: 
# Usage..........: CALL adzp188_paper_len_width()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/03/04
# Modify.........:
################################################################################
FUNCTION adzp188_paper_len_width()

      IF g_paper_set.c_std = "1" THEN  #A4
         IF g_paper_set.r_direction = "1" THEN #直向
            LET g_paper_set.len = 29.70
            LET g_paper_set.width = 21.00
         ELSE 
            LET g_paper_set.len = 21.00 
            LET g_paper_set.width = 29.70                  
         END IF               
      ELSE   #A3
         IF g_paper_set.r_direction = "1" THEN  #直向
            LET g_paper_set.len = 42.00
            LET g_paper_set.width = 29.70
         ELSE 
            LET g_paper_set.len = 29.70 
            LET g_paper_set.width = 42.00                  
         END IF                      
      END IF  
END FUNCTION 

################################################################################
# Descriptions...: 確認欄位是否存在
# Memo...........: 
# Usage..........: CALL adzp188_field_exist(g_dzgj[g_dzgj_idx].dzgj006_1)
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/03/06
# Modify.........:
################################################################################
FUNCTION adzp188_field_exist(ps_field)
   DEFINE ps_field       LIKE gztz_t.gztz002
   DEFINE l_have         LIKE type_t.num5  
   
   LET l_have = 0
   SELECT COUNT(*) INTO l_have FROM gztz_t WHERE gztz002 = ps_field
      AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
      ##161227-00056#1 add -(s)
      AND gztz001 NOT LIKE 'erp%'   
      AND gztz001 NOT LIKE 'all%'
      AND gztz001 NOT LIKE 'b2b%'
      AND gztz001 NOT LIKE 'pos%'
      AND gztz001 NOT LIKE 'dsm%'
      ##161227-00056#1 add -(e)      

   RETURN l_have
END FUNCTION 


##0306 -(S)
################################################################################
# Descriptions...: 維護dzgj參數檔資訊
# Memo...........: 
# Usage..........: CALL adzp188_maintain_dzgj(g_argsel_idx)
# Input parameter: ps_argsel_idx
# Return code....: 
# Date & Author..: 2014/03/07
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_dzgj(ps_argsel_idx)
   DEFINE ps_argsel_idx    LIKE type_t.num5
   DEFINE l_have         LIKE type_t.num5  

   IF ps_argsel_idx = 0 THEN RETURN END IF 
   LET l_have = 0
   SELECT COUNT(*) INTO l_have FROM adzp188_dzgj_tmp 
    WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002 AND dzgj003 = g_argsel[ps_argsel_idx].dzgj003
      #AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add    ##141013 mark 
      AND dzgj008 = g_code_ide                                      ##141013 add          
      
    LET g_dzgj_d.dzgj003 = g_argsel[ps_argsel_idx].dzgj003
    LET g_dzgj_d.dzgj004 = g_argsel[ps_argsel_idx].dzgj004
    IF g_argsel[ps_argsel_idx].dzgj005_2 = "Y" THEN 
       LET g_dzgj_d.dzgj005 = "0"
    ELSE 
       LET g_dzgj_d.dzgj005 = g_argsel[ps_argsel_idx].dzgj005_1
    END IF 
    LET g_dzgj_d.dzgj006 = g_argsel[ps_argsel_idx].dzgj006
   IF l_have > 0 THEN 
      UPDATE adzp188_dzgj_tmp SET dzgj004 = g_dzgj_d.dzgj004 , dzgj005 = g_dzgj_d.dzgj005 ,
                                  dzgj006 = g_dzgj_d.dzgj006
        WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002 AND dzgj003 = g_dzgj_d.dzgj003
         #AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add     ##141013 mark
         AND dzgj008 = g_code_ide                                        ##141013 add  
             
   ELSE 
      ##141013 mark -(s)
      #INSERT INTO adzp188_dzgj_tmp
           #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, g_dzgj_d.dzgj003, g_dzgj_d.dzgj004, g_dzgj_d.dzgj005, g_dzgj_d.dzgj006,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
      ##141013 mark -(e)
      ##141013 add -(s)   
      LET g_sql = " INSERT INTO adzp188_dzgj_tmp ",                    
                  "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,)" 
      PREPARE adzp188_dzgj_tmp_ins_pre FROM g_sql
      EXECUTE adzp188_dzgj_tmp_ins_pre USING g_dzgj_d.dzgj003, g_dzgj_d.dzgj004, g_dzgj_d.dzgj005, g_dzgj_d.dzgj006,g_cust,g_code_ide
      ##141013 add -(e)           
   END IF 
END FUNCTION
##0306 -(e)
##0311 -(S)
################################################################################
# Descriptions...: 維護dzgj參數檔資訊
# Memo...........: 
# Usage..........: CALL adzp188_maintain_argsel(g_arg)
# Input parameter: ps_arg       參數個數
# Return code....: 
# Date & Author..: 2014/03/11
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_argsel(ps_arg)
   DEFINE ps_arg       LIKE type_t.num5
   DEFINE i            LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5


   ##141013 add -(s)   
   LET g_sql = " INSERT INTO adzp188_dzgj_tmp ",                    
               "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?)" 
   PREPARE adzp188_dzgj_tmp_ins_pre1 FROM g_sql
   ##141013 add -(e)
   
   ##已有值，則若傳進來>l_cnt則新增，若<l_cnt則刪除
   SELECT COUNT(*) INTO l_cnt FROM adzp188_dzgj_tmp 
    WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
      #AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add  ##141013 mark
      AND dzgj008 = g_code_ide                                    ##141013 add
    
   IF l_cnt = 0 THEN 
      ##若無資料代表先帶預設
       FOR i = 1 TO ps_arg
           ##141013 mark -(s)
           #INSERT INTO adzp188_dzgj_tmp 
           #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,i,'','','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
           ##141013 mark -(e)
           EXECUTE adzp188_dzgj_tmp_ins_pre1 USING i,'','','',g_cust,g_code_ide  ##141013 add
       END FOR      
   ELSE 
   
       IF ps_arg > l_cnt THEN 
           FOR i = l_cnt +1 TO ps_arg
               ##141013 mark -(s)
               #INSERT INTO adzp188_dzgj_tmp 
               #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,i,'','','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
               ##141013 mark -(e)
               EXECUTE adzp188_dzgj_tmp_ins_pre1 USING i,'','','',g_cust,g_code_ide  ##141013 add
           END FOR
       ELSE 
            FOR i = ps_arg + 1 TO l_cnt

                DELETE FROM adzp188_dzgj_tmp
                 WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002 AND dzgj003 = i
                   #AND dzgj007 = g_cust AND dzgj008 = g_code_ide #140613 add ##141013 mark
                   AND dzgj008 = g_code_ide                                   ##141013 add
               
           END FOR     
       END IF 
   END IF 
   
END FUNCTION 


################################################################################
# Descriptions...: 參數頁簽-建立資料
# Memo...........: 
# Usage..........: CALL adzp188_argsel_b_fill()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/03/11
# Modify.........:
################################################################################
FUNCTION adzp188_argsel_b_fill()
   DEFINE ps_arg       LIKE type_t.num5
   DEFINE i            LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE lc_dzgj003   LIKE dzgj_t.dzgj003
   DEFINE lc_dzgj004   LIKE dzgj_t.dzgj004
   DEFINE lc_dzgj005   LIKE dzgj_t.dzgj005
   DEFINE lc_dzgj006   LIKE dzgj_t.dzgj006 

   CALL g_argsel.clear()
   LET l_cnt = 1
   LET g_sql = "SELECT dzgj003,dzgj004,dzgj005,dzgj006 ",
               " FROM adzp188_dzgj_tmp ",
               #" WHERE dzgj001 = '",g_dzga_m.dzga001,"' AND dzgj002 = '",g_dzga_m.dzga002,"'",  #140923 elena mark
               " WHERE dzgj001 = '",g_dzga_m.dzga001,"' AND dzgj002 = '",gs_ver,"'",             #140923 elena add
               #"   AND dzgj007 = '",g_cust,"' AND dzgj008 = '",g_code_ide,"'",       #140613 add  ##141013 mark
               "   AND dzgj008 = '",g_code_ide,"'",       #141013 add
               " ORDER BY dzgj003"
            
   PREPARE argsel_b_fill_pre FROM g_sql
   DECLARE argsel_b_fill_curs CURSOR FOR argsel_b_fill_pre  
   FOREACH argsel_b_fill_curs INTO lc_dzgj003,lc_dzgj004,lc_dzgj005,lc_dzgj006
      LET g_argsel[l_cnt].dzgj003 = lc_dzgj003
      LET g_argsel[l_cnt].dzgj004 = lc_dzgj004
      IF lc_dzgj005 ="0" THEN 
         LET g_argsel[l_cnt].dzgj005_2 ="Y"
         LET g_argsel[l_cnt].dzgj005_1 =""
      ELSE 
         LET g_argsel[l_cnt].dzgj005_2 ="N"
         LET g_argsel[l_cnt].dzgj005_1 = lc_dzgj005      
      END IF 
      LET g_argsel[l_cnt].dzgj006 = lc_dzgj006  
      LET l_cnt = l_cnt + 1
   END FOREACH  
   
   CALL g_argsel.deleteElement(l_cnt)
   
END FUNCTION 
##0311 -(E)

################################################################################
# Descriptions...: 排版頁簽-判斷同區塊資料不重覆
# Memo...........: 
# Usage..........: adzp188_chk_type2_field_exit(lc_pidtype2,lc_pidseq2,lc_id2)
# Input parameter: ps_pidtype2         區塊:1單頭/2單身
# Input parameter: ps_pidseq2          區塊順序
# Input parameter: ps_id2              欄位
# Return code....: 
# Date & Author..: 2014/03/14
# Modify.........:
################################################################################
#FUNCTION adzp188_chk_type2_field_exit(ps_pidtype2,ps_pidseq2,ps_id2)  #141127 mark
FUNCTION adzp188_chk_type2_field_exit(ps_pidtype2,ps_pidseq2,ps_id2,ps_alias2)   #141127 add
   DEFINE ps_pidtype2  LIKE type_t.chr1
   DEFINE ps_pidseq2   LIKE type_t.num5
   DEFINE ps_id2       LIKE type_t.chr20
   DEFINE ps_alias2    LIKE dzgh_t.dzgh009  #141127 add
   DEFINE lc_exist     LIKE type_t.num5
   DEFINE lc_cnt       LIKE type_t.num5


   LET lc_exist = 0
   LET lc_cnt = 0
   SELECT COUNT(*) INTO lc_cnt FROM adzp188_type2_tmp
    WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
      AND dzgh003 = g_dzga_m.dzga001 AND pidtype2 = ps_pidtype2
      AND pidseq2 = ps_pidseq2 AND id2 = ps_id2
      #AND dzgh011 = g_cust AND dzgh012 = g_code_ide #140613 add   ##141013 mark
      AND dzgh012 = g_code_ide                                       ##141013 add 
      AND alias2 = ps_alias2                                        ##141127 add
        
    
   IF lc_cnt = 0 THEN 
      LET lc_exist = 1
   END IF 
   
   RETURN lc_exist
END FUNCTION 


################################################################################
# Descriptions...: 增加主table的enterprise
# Memo...........: 
# Usage..........: adzp188_create_maintable_dzgf(lc_dzgi004[li_k])
# Input parameter: ps_dzgi004          主TABLE名
# Return code....: 
# Date & Author..: 2014/03/17
# Modify.........:
################################################################################
FUNCTION adzp188_create_maintable_dzgf(ps_dzgi004)
   DEFINE ps_dzgi004   LIKE dzgi_t.dzgi004
   DEFINE ls_dzgi004   STRING 
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_gztz002    LIKE gztz_t.gztz002
   DEFINE l_k          LIKE type_t.num5       #141013 add

   LET ls_dzgi004 = ps_dzgi004
   LET ls_dzgi004 = ls_dzgi004.subString(1,ls_dzgi004.getIndexOf("_",1)-1),"ent"
   LET l_gztz002 = ls_dzgi004
   
   SELECT COUNT(*) INTO l_cnt FROM gztz_t 
    WHERE gztz001 = ps_dzgi004 AND gztz002 = l_gztz002
     
   IF l_cnt > 0 THEN 
         ##enterprise用99這個序號，因為要組在最後面
          ##141013 mark -(s)   
         #INSERT INTO adzp188_dzgf_tmp
         #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, 99 , '', ps_dzgi004,
                #l_gztz002, '01','g_enterprise', '', '',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
         ##141013 mark -(e)       
         ##141013 add -(s)   
         LET g_sql = " INSERT INTO adzp188_dzgf_tmp ",                    
                     "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?,?)" 
         PREPARE adzp188_dzgf_tmp_ins_pre FROM g_sql
         LET l_k = 99
         EXECUTE adzp188_dzgf_tmp_ins_pre USING l_k , '', ps_dzgi004,
                l_gztz002, '01','g_enterprise', '', '',g_cust,g_code_ide
         ##141013 add -(e)                
   END IF 
END FUNCTION 


################################################################################
# Descriptions...: 每個join都要判斷主table與reference是否有ent、site、ld字尾，2個同時存在要組上join
# Memo...........: 
# Usage..........: CALL adzp188_chk_table_suffix(ps_dzgb005,ps_dzgb009)
# Input parameter: p_dzgb005          主TABLE名
# Input parameter: p_dzgb009          reference TABLE名
# Return code....: 
# Date & Author..: 2014/03/19
# Modify.........:
################################################################################
FUNCTION adzp188_chk_table_suffix(p_dzgb005,p_dzgb009,p_str)
   DEFINE p_dzgb005      LIKE dzgb_t.dzgb005
   DEFINE p_dzgb009      LIKE dzgb_t.dzgb009
   DEFINE p_str          STRING 
   DEFINE ls_m_ent       STRING
   DEFINE ls_m_site      STRING 
   DEFINE ls_m_ld        STRING
   DEFINE ls_d_ent       STRING
   DEFINE ls_d_site      STRING 
   DEFINE ls_d_ld        STRING
   DEFINE l_m_table      STRING
   DEFINE l_d_table      STRING
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_gztz002      LIKE gztz_t.gztz002
   DEFINE l_suffix       STRING 
   DEFINE l_dzeb002      LIKE dzeb_t.dzeb002
   DEFINE l_dzeb001      LIKE dzeb_t.dzeb001


   ##主table
   LET l_m_table = p_dzgb005
   LET ls_m_ent = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ent"
   ##140512 只加ent, 其餘不加-(s)
   #LET ls_m_site = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"site"
   #LET ls_m_ld = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ld"
   ##140512 只加ent, 其餘不加-(e) 
   #reference table
   LET l_d_table = p_dzgb009
   LET ls_d_ent = l_d_table.subString(1,l_d_table.getIndexOf("_",1)-1),"ent"   
   ##140512 只加ent, 其餘不加-(s)
   #LET ls_d_site = l_d_table.subString(1,l_d_table.getIndexOf("_",1)-1),"site"
   #LET ls_d_ld = l_d_table.subString(1,l_d_table.getIndexOf("_",1)-1),"ld"
   ##140512 只加ent, 其餘不加-(e)

   IF p_str.getIndexOf("ent",1) = 0 THEN 
       IF adzp188_table_field_exist(l_m_table,ls_m_ent) THEN
          IF adzp188_table_field_exist(l_d_table,ls_d_ent) THEN
             LET l_suffix = l_suffix , l_m_table,".",ls_m_ent," = ",l_d_table,".",ls_d_ent
          END IF  
       END IF 
   END IF 
   ##140512 只加ent, 其餘不加-(s)
   #IF p_str.getIndexOf("site",1) = 0 THEN    
       #IF adzp188_table_field_exist(l_m_table,ls_m_site) THEN
          #IF adzp188_table_field_exist(l_d_table,ls_d_site) THEN
             #IF NOT cl_null(l_suffix) THEN
                #LET l_suffix = l_suffix ," AND "
             #END IF  
             #LET l_suffix = l_suffix , l_m_table,".",ls_m_site," = ",l_d_table,".",ls_d_site         
          #END IF  
       #END IF 
   #END IF
   #IF p_str.getIndexOf("ld",1) = 0 THEN   
       #IF adzp188_table_field_exist(l_m_table,ls_m_ld) THEN
          #IF adzp188_table_field_exist(l_d_table,ls_d_ld) THEN
             #IF NOT cl_null(l_suffix) THEN
                #LET l_suffix = l_suffix ," AND "
             #END IF  
             #LET l_suffix = l_suffix , l_m_table,".",ls_m_ld," = ",l_d_table,".",ls_d_ld
          #END IF  
       #END IF 
   #END IF
   ##140512 只加ent, 其餘不加-(e)
   
  ##reference table若為語言檔，要抓出語言別欄位
  LET l_dzeb001 = p_dzgb005 
  LET l_dzeb002 =''
  SELECT dzeb002 INTO l_dzeb002 FROM dzeb_t 
    LEFT JOIN dzea_t ON dzea004 ='L' and dzea001 = dzeb001
   WHERE dzeb006 ='C800' and dzeb001 = l_dzeb001
  IF NOT cl_null(l_dzeb002)  THEN 
     IF NOT cl_null(l_suffix) THEN
        LET l_suffix = l_suffix ," AND "
     END IF   
     LET l_suffix = l_suffix , l_dzeb001,".",l_dzeb002," = g_dlang"
  END IF  
   
   RETURN l_suffix
END FUNCTION 





################################################################################
# Descriptions...: 確認table' 欄位是否存在
# Memo...........: 
# Usage..........: CALL adzp188_table_field_exist(l_m_table,ls_m_ld) 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/03/18
# Modify.........:
################################################################################
FUNCTION adzp188_table_field_exist(ps_table,ps_field)
   DEFINE ps_table       LIKE gztz_t.gztz001
   DEFINE ps_field       LIKE gztz_t.gztz002
   DEFINE l_have         LIKE type_t.num5  

   LET l_have = 0
   SELECT COUNT(*) INTO l_have FROM gztz_t 
    WHERE gztz001 = ps_table AND gztz002 = ps_field

   RETURN l_have
END FUNCTION 


################################################################################
# Descriptions...: 主表若有ent、comp、ld、legl、orga、site、unit字尾的欄位就要新增至dzgc
# Memo...........: 
# Usage..........: CALL adzp188_add_main_table_suffix(l_dzgi004[li_k])
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/03/31
# Modify.........:
################################################################################
FUNCTION adzp188_add_main_table_suffix(ps_table)
   DEFINE ps_table       LIKE gztz_t.gztz001
   DEFINE ls_m_field      DYNAMIC ARRAY OF STRING 
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_dzgc003      LIKE dzgc_t.dzgc003
   DEFINE l_m_table      STRING 
   DEFINE l_gztz002      LIKE gztz_t.gztz002
   DEFINE l_cnt          LIKE type_t.num5

   ##主table
   CALL ls_m_field.clear()
   LET l_m_table = ps_table
   LET ls_m_field[1] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ent"
   LET ls_m_field[2] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"site"
   LET ls_m_field[3]= l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ld"
   LET ls_m_field[4] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"comp"
   LET ls_m_field[5] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"legl"
   LET ls_m_field[6] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"orga"
   LET ls_m_field[7] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"unit"  

   SELECT MAX(dzgc003) INTO l_dzgc003 FROM adzp188_dzgc_tmp
    WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002 
      #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  ##141013 mark
       AND dzgc009 = g_code_ide                                    ##141013 add    


    LET g_sql = " INSERT INTO adzp188_dzgc_tmp ",                    
                " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
    PREPARE dzgc_tmp_ins_pre FROM g_sql
   
    ##141013 add -(e)
   FOR l_i = 1 TO ls_m_field.getLength()
       LET l_gztz002 = ls_m_field[l_i]
       IF adzp188_table_field_exist(ps_table,l_gztz002) THEN
          ##140401  已存在就不存入
          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt FROM adzp188_dzgc_tmp

           WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002 
             AND dzgc007 = ps_table AND dzgc004 = l_gztz002 
             #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  ##141013 mark
             AND dzgc009 = g_code_ide #140613 add                        ##141013 add
                      
          IF l_cnt = 0 THEN  
              ##141013 mark -(s)
              #INSERT INTO adzp188_dzgc_tmp
                   #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,l_dzgc003,l_gztz002,'1','N',ps_table,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
              ##141013 mark -(e)     
              EXECUTE dzgc_tmp_ins_pre USING l_dzgc003,l_gztz002,'1','N',ps_table,g_cust,g_code_ide    ##141013 add  
              LET l_dzgc003 = l_dzgc003 + 1 #140702 add     
          END IF 
       END IF 
   END FOR 
   
    
END FUNCTION 



################################################################################
# Descriptions...: 確認table' 欄位是否存在
# Memo...........: 
# Usage..........: CALL adzp188_chk_main_table_suffix(ps_field) 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/03/18
# Modify.........:
################################################################################
FUNCTION adzp188_chk_main_table_suffix(ps_field)
   DEFINE ps_table       LIKE gztz_t.gztz001
   DEFINE ps_field       LIKE gztz_t.gztz002
   DEFINE l_have         LIKE type_t.num5 
   DEFINE l_dzgi004      LIKE dzgj_t.dzgj004
   DEFINE ls_m_field     DYNAMIC ARRAY OF STRING 
   DEFINE l_m_table      STRING 
   DEFINE l_i            LIKE type_t.num5
   
   
   ##抓出主報表
   CALL ls_m_field.clear() 
   
   LET l_dzgi004 =''
   SELECT dzgi004 INTO l_dzgi004 FROM adzp188_dzgi_tmp
    WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002 AND dzgi003 = 1 
      #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add  ##141013 mark
      AND dzgi006 = g_code_ide                                    ##141013 add

   LET l_m_table = l_dzgi004
   LET ls_m_field[1] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ent"
   LET ls_m_field[2] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"site"
   LET ls_m_field[3]= l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ld"
   LET ls_m_field[4] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"comp"
   LET ls_m_field[5] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"legl"
   LET ls_m_field[6] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"orga"
   LET ls_m_field[7] = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"unit"      
    
   LET l_have = 0
   FOR l_i = 1 TO ls_m_field.getLength()
       IF ps_field = ls_m_field[l_i] THEN
          LET l_have = 1 
          EXIT FOR 
       END IF 
   END FOR 

   RETURN l_have
END FUNCTION 


################################################################################
# Descriptions...: 若原單身TABLE刪除，重抓單身TABLE的REFERENCE資訊
# Memo...........: 
# Usage..........: CALL adzp188_get_d_reference_join(ps_field) 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/07
# Modify.........:
################################################################################
FUNCTION adzp188_get_d_reference_join(ps_table)
  DEFINE ps_table      LIKE dzgi_t.dzgi004
  DEFINE l_dzag005     LIKE dzag_t.dzag005
  DEFINE l_dzaf003     VARCHAR(15)  #LIKE dzaf_t.dzaf003
  DEFINE l_dzaa003     VARCHAR(15)  #LIKE dzaa_t.dzaa003 
  DEFINE l_dzaa004     LIKE dzaa_t.dzaa004
  DEFINE l_dzaa006     LIKE dzaa_t.dzaa006
  DEFINE li_cnt        LIKE type_t.num5
  DEFINE ls_dzai    DYNAMIC ARRAY OF RECORD 
         dzai005      LIKE dzai_t.dzai005,
         dzai007      LIKE dzai_t.dzai007,
         dzai008      LIKE dzai_t.dzai008,
         dzai009      LIKE dzai_t.dzai009,
         dzai011      LIKE dzai_t.dzai011
         END RECORD  
  DEFINE ls_dzgb      DYNAMIC ARRAY OF type_g_dzgb_d
  DEFINE ls_dzgb_t    type_g_dzgb_d
  DEFINE ls_i         LIKE type_t.num5
  DEFINE ls_dzgc_seq  LIKE dzgc_t.dzgc003
  DEFINE ls_dzgb_seq  LIKE dzgb_t.dzgb003
  DEFINE l_dzgb_cnt   LIKE type_t.num5
  DEFINE ls_tableseq  LIKE type_t.num5
  DEFINE ls_exist     LIKE type_t.num5
  DEFINE lc_tmp       DYNAMIC ARRAY OF RECORD  #dzgc存入別名用
         lc_dzgc003   LIKE dzgc_t.dzgc003,
         lc_dzgc004   LIKE dzgc_t.dzgc004
         END RECORD  
  DEFINE l_i          LIKE type_t.num5
  DEFINE l_alias      LIKE dzgc_t.dzgc007
  DEFINE ls_space_str STRING
  DEFINE l_wc_str     STRING  
  DEFINE li_k         LIKE type_t.num5      
  DEFINE li_j         LIKE type_t.num5 
  DEFINE l_dzgi004    DYNAMIC ARRAY OF VARCHAR(15)  
  DEFINE l_dzgb_n     DYNAMIC ARRAY OF RECORD 
         l_dzgb015    LIKE dzgb_t.dzgb015,
         l_dzgb016    LIKE dzgb_t.dzgb016,
         l_dzgb017    LIKE dzgb_t.dzgb017
         END RECORD
  DEFINE l_cnt        LIKE type_t.num5 
  DEFINE ls_table_cnt LIKE type_t.num5
  DEFINE ls_table_str STRING
  DEFINE ls_table_tmp LIKE dzgb_t.dzgb005
  DEFINE l_dzgi004_str STRING 
  DEFINE li_i         LIKE type_t.num5  
  DEFINE ls_tmp       STRING 
  DEFINE li_i_cnt     LIKE type_t.num10
  DEFINE l_dzgc004    DYNAMIC ARRAY OF VARCHAR(15)
  DEFINE ls_wc        LIKE dzgb_t.dzgb011
  DEFINE l_dzgb       DYNAMIC ARRAY OF RECORD 
         l_dzgb003    LIKE dzgb_t.dzgb003,
         l_dzgb012    LIKE dzgb_t.dzgb012,
         l_dzgb013    LIKE dzgb_t.dzgb013,
         l_dzgb014    LIKE dzgb_t.dzgb014,
         l_dzgb015    LIKE dzgb_t.dzgb015,
         l_dzgb016    LIKE dzgb_t.dzgb016
         END RECORD 
  DEFINE ls_dzac002 DYNAMIC ARRAY OF VARCHAR(20) 
  DEFINE l_gztz001    LIKE gztz_t.gztz001
  DEFINE l_dzag004    LIKE dzag_t.dzag004
  DEFINE ls_dzed004   STRING 
  DEFINE ls_dzed006   STRING 
  DEFINE g_nFind_table STRING 
  DEFINE ls_err_msg   STRING 
  DEFINE l_m_field    LIKE dzgc_t.dzgc004
   DEFINE l_prog_type  LIKE gzde_t.gzde005     #程式類型   #140701 add
   DEFINE l_module     LIKE gzde_t.gzde002     #模組       #140701 add
   DEFINE l_spec_ver   LIKE dzga_t.dzga002     #客製版次    #140701 add
   DEFINE l_spec_ide   LIKE dzga_t.dzga005     #規格標示    ##140701 add  
   DEFINE l_dzaf003_ver STRING                 #141017 add
               
   ##140613 mark 換呼叫hiko的function來取得規格版次-(s)
  #140407
   ##先取出最新的規格版次
   #SELECT dzaf003 INTO l_dzaf003 FROM dzaf_t af WHERE af.dzaf001= p_gzza001 AND dzaf002 = (SELECT MAX(dzaf002) FROM dzaf_t af1 WHERE af1.dzaf001 = g_gzza001 AND af1.dzaf005 = af.dzaf005 AND af1.dzaf006 = af.dzaf006) #AND dzafstus='Y'
   ##若沒有版次就先1 
   #IF cl_null(l_dzaf003) THEN LET l_dzaf003 ="1" END IF 
   ##140613 mark -(e)


   ##141013 insert prepare -(s)
   LET g_sql = " INSERT INTO adzp188_dzgb_tmp1 ",                    
               " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" 
   PREPARE adzp188_dzgb_tmp1_ins_pre1 FROM g_sql

   LET g_sql = " INSERT INTO adzp188_dzgc_tmp ",                    
               " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
   PREPARE adzp188_dzgc_tmp_ins_pre1 FROM g_sql 

   LET g_sql = " INSERT INTO adzp188_dzgi_tmp ",                    
               " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?)" 
   PREPARE adzp188_dzgi_tmp_ins_pre1 FROM g_sql  

   LET g_sql = " INSERT INTO adzp188_dzgb_tmp ",                    
               " VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" 
   PREPARE adzp188_dzgb_tmp_ins_pre1 FROM g_sql 
   ##141013 insert prepare -(e)

   
   #140701 add -(s)
   SELECT gzde003,gzde002 INTO l_prog_type,l_module FROM gzde_t 
    WHERE gzde001 = g_gzza001  ##140523原抓dzge005改抓dzge003  #140612 g_module
   #若是報表元件再呼叫一下，若不是呼叫gzaa_t 
   IF l_prog_type IS NULL AND l_module IS NULL THEN 
      SELECT gzza002,gzza003 INTO l_prog_type,l_module FROM gzza_t 
       WHERE gzza001 = g_gzza001 
       #取出若是T類，在規格中是歸在M
       IF l_prog_type="T" THEN LET l_prog_type="M" END IF    
   END IF 
   #140701 add -(s)
   
   #140613 add 取得最新規格版次g_spec_ver、客製標示g_spec_ide -(s)
   
   #CALL sadzp060_2_get_spec_curr_revision(g_gzza001, g_prog_type, g_module) RETURNING g_spec_ver,g_spec_ide,ls_err_msg  #140701 mark
   #CALL sadzp060_2_get_spec_curr_revision(g_gzza001, l_prog_type, l_module) RETURNING l_spec_ver,l_spec_ide,ls_err_msg   #140701 add  #140730 mark
   CALL cl_adz_get_spec_curr_revision(g_gzza001, NULL,l_prog_type) RETURNING l_spec_ver,l_spec_ide,ls_err_msg   #140730 add
   IF NOT cl_null(ls_err_msg) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00303'
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_gzza001
      CALL cl_err()
      RETURN  
   END IF 
   LET l_dzaf003 = l_spec_ver
   LET l_dzaf003_ver =  l_dzaf003            #141017 add
   LET l_dzaf003_ver =  l_dzaf003_ver.trim()  #141017 add
   #140613 add 取得最新規格版次、客製標示 -(e)   
   
   #取得Table的識別碼版次
   SELECT dzaa004 INTO l_dzaa004 FROM dzaa_t 
    WHERE dzaa001 = g_gzza001 AND dzaa002 = l_dzaf003 AND dzaa003 = 'TABLE' AND dzaa005='4' #AND dzaastus='Y'
      #AND dzaa009 = l_spec_ide  AND dzaa010 = g_cust ##140613 add  #140702 mark
       AND dzaa009 = l_spec_ide ##140702 add 
      
   #
   #IF cl_null(l_dzaa004) THEN LET l_dzaa004 ="1" END IF 
   
   #判斷是否為單身table
   LET l_cnt = 0
   #151012-00003#1 mark -(s)
   #SELECT COUNT(*) INTO l_cnt FROM dzag_t
    #WHERE dzag001 = g_gzza001 AND dzag003 = l_dzaa004 AND dzagstus= 'Y' AND dzag005 ='N' 
      #AND dzag002 = ps_table  AND dzag006 =l_spec_ide  #140702 add AND dzag006 =l_spec_ide
   #151012-00003#1 mark -(e)   
   #151012-00003#1 add -(s)
   ##調整加入inner join dzaa_t
   SELECT COUNT(*) INTO l_cnt FROM dzag_t
    INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa003='TABLE' AND dzaa004=dzag003 AND dzaa006=dzag006
    WHERE dzaa001 = g_gzza001 AND dzaa002 = l_spec_ver  AND dzaa005='4' AND dzaastus= 'Y' AND dzaa009 = l_spec_ide 
      AND dzag005 ='N' AND dzag002 = ps_table
   #151012-00003#1 add -(e)

      
    IF l_cnt > 0 THEN 
      DELETE FROM adzp188_dzgb_tmp1

      ##先把資料入dzgb_tmp1
      INSERT INTO adzp188_dzgb_tmp1
         SELECT * FROM adzp188_dzgb_tmp 
          WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
            #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add   ##141013 mark
            AND dzgb019 = g_code_ide               ##141013 add 
                                         
      ##把別名與join的wc清空   
      UPDATE adzp188_dzgb_tmp1 SET dzgb017 ='',dzgb011=''
         WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 
           #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add   ##141013 mark 
           AND dzgb019 = g_code_ide     ##141013 add
 

      ##重新組dzgb的join wc
      LET ls_i = 1   
      CALL l_dzgb.clear()
      LET g_sql = " SELECT dzgb003,dzgb012,dzgb013,dzgb014,dzgb015,dzgb016 FROM adzp188_dzgb_tmp1 ",
                  #" WHERE dzgb001 = '", g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'",  #140923 elena mark
                  " WHERE dzgb001 = '", g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",             #140923 elena add
                  #"   AND dzgb018 = '",g_cust,"' AND dzgb019 = '",g_code_ide,"'", #140613 add       #141013 mark               
                  "   AND dzgb019 = '",g_code_ide,"'", #140613 add        #141013 add           
                  " ORDER BY dzgb003 "                     
      PREPARE adzp188_dzgb_regen_join_pre1 FROM g_sql
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'PREPARE:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT PROGRAM
      END IF   
      DECLARE adzp188_dzgb_regen_join_cs1 CURSOR FOR adzp188_dzgb_regen_join_pre1    
      FOREACH adzp188_dzgb_regen_join_cs1 INTO l_dzgb[ls_i].*      
         ##組FK的SQL，預設用=(01),EX:inbb_t.inbb001 = inba_t.inba001  
         LET ls_table_str = l_dzgb[ls_i].l_dzgb012
         ##判斷撈出來的table，若是b_inbb004->inbb_t，inbb_t.inbb004->inbb_t      
         IF ls_table_str.getIndexOf("b_",1)>0 AND ls_table_str.getIndexOf(".",1) = 0  THEN
            LET ls_table_str = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength()-3),"_t"
         ELSE 
            IF ls_table_str.getIndexOf(".",1)>0 THEN LET ls_table_str = ls_table_str.subString(1,ls_table_str.getIndexOf(".",1)-1) END IF
         END IF    

          ##重取關連資料表的KEY值
　　　　　　CALL sadzp188_get_jointable_key(ls_table_str,l_dzgb[ls_i].l_dzgb013, l_dzgb[ls_i].l_dzgb014, l_dzgb[ls_i].l_dzgb015) RETURNING l_dzgb[ls_i].l_dzgb013, l_dzgb[ls_i].l_dzgb015 ##160615-00007 add
          
          LET ls_wc =""
          LET ls_wc = adzp188_combine_ref_join_wc("", ls_table_str, l_dzgb[ls_i].l_dzgb013, "01", "Y", l_dzgb[ls_i].l_dzgb014, l_dzgb[ls_i].l_dzgb015)

           #UPDATE adzp188_dzgb_tmp1 SET dzgb011 = ls_wc                                                                     ##160615-00007 mark
           UPDATE adzp188_dzgb_tmp1 SET dzgb011 = ls_wc,dzgb013 = l_dzgb[ls_i].l_dzgb013 ,dzgb015 = l_dzgb[ls_i].l_dzgb015   ##160615-00007 add
            WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 AND dzgb003 =  l_dzgb[ls_i].l_dzgb003 
              #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add      ##141013 mark
              AND dzgb019 = g_code_ide      ##141013 add
         
          LET ls_i = ls_i + 1
       END FOREACH   

      ##140507 -(s) 將原來的組合欄位重刪掉，後面再重組
       DELETE FROM adzp188_dzgc_tmp 
        WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002 
          AND dzgc004 LIKE 'l_%'
          #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add   ##141013 mark
          AND dzgc009 = g_code_ide       ##141013 add       

       DELETE FROM adzp188_dzgd_tmp 
        WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002 
          AND dzgd003 LIKE 'l_%'  
          #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add  ##141013 mark 
          AND dzgd008 = g_code_ide ##141013 add
      
      ##140507 -(s)   
       
      #取得join與欄位最大序號
      SELECT MAX(dzgb003)+1 INTO ls_dzgb_seq FROM adzp188_dzgb_tmp1
      SELECT MAX(dzgc003)+1 INTO ls_dzgc_seq FROM adzp188_dzgc_tmp
      
      ##取得參考TABLE、欄位資訊
        #取得參考Table的識別碼版次   
        SELECT dzaa003, dzaa004, dzaa006 INTO l_dzaa003,l_dzaa004,l_dzaa006 FROM dzaa_t 
         WHERE dzaa001 = g_gzza001 AND dzaa002 = l_dzaf003 AND dzaa005='6' #AND dzaastus='Y'
           #AND dzaa009 = l_spec_ide  AND dzaa010 = g_cust ##140613 add  ##141013 mark 
           AND dzaa009 = l_spec_ide  ##141013 add
        
        #取得參考table list 
        ###151012-00003#1 mark -(s)
        #LET g_sql = " SELECT dzai005,dzai007,dzai008,dzai009, dzai011 FROM dzaa_t,dzai_t ",
                    #" WHERE dzaa001 = dzai001 AND dzaa003 = dzai002 AND dzaa004 = dzai003 AND dzaa006 = dzai004",
                    ##" AND dzaa001='",g_gzza001,"'"," AND dzaa002 ='", l_dzaf003 ,"'"," AND dzaa005='6' AND dzaastus='Y'",  #141017 mark
                     #" AND dzaa001='",g_gzza001,"'"," AND dzaa002 ='", l_dzaf003_ver ,"'"," AND dzaa005='6' AND dzaastus='Y'",  #141017 add
                    ##" AND dzaa009 ='", l_spec_ide,"' AND dzaa010 ='", g_cust,"'" #140613 add  ##141013 mark
                    #" AND dzaa009 ='", l_spec_ide,"'" #141013 add 
        ###151012-00003#1 mark -(e)

       ###151012-00003#1 add -(s)
       LET g_sql = " SELECT dzai005,dzai007,dzai008,dzai009, dzai011 FROM dzai_t ",
                   " INNER JOIN dzaa_t ON dzaa001=dzai001 AND dzaa003=dzai002 AND dzaa004=dzai003 AND dzaa006=dzai004 ",
                   " WHERE dzaa001='",g_gzza001,"'"," AND dzaa002 ='", l_spec_ver ,"'"," AND dzaa005='6' AND dzaastus='Y'",
                   "   AND dzaa009='",l_spec_ide,"'",
                   " ORDER BY dzai002 "                   
       ###151012-00003#1 add -(e)
                    
        PREPARE adzp188_dzai_pre_d FROM g_sql
        DECLARE adzp188_dzai_d_cs CURSOR FOR adzp188_dzai_pre_d
        LET ls_i = 1
        LET ls_table_cnt =1
        FOREACH adzp188_dzai_d_cs INTO ls_dzai[ls_i].*
          IF SQLCA.sqlcode THEN
             EXIT FOREACH
          END IF  
   
          ##140301 dzai005是要跟主表與第一個單身表有關才繼續做
          ##組FK的SQL，預設用=(01),EX:inbb_t.inbb001 = inba_t.inba001  
          LET ls_table_str = ls_dzai[ls_i].dzai005  
          ##判斷撈出來的table，若是b_inbb004->inbb_t，inbb_t.inbb004->inbb_t      
          IF ls_table_str.getIndexOf("b_",1)>0 AND ls_table_str.getIndexOf(".",1) = 0  THEN
            LET ls_table_str = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength()-3),"_t"
          ELSE 
            IF ls_table_str.getIndexOf(".",1)>0 THEN LET ls_table_str = ls_table_str.subString(1,ls_table_str.getIndexOf(".",1)-1) END IF
          END IF
          ##TABLE是單身TABLE才做  EX:ls_table_str ="xmbc_t"
          IF ls_table_str = ps_table THEN 
            LET ls_table_tmp = ls_table_str      
              IF NOT adzp188_chk_table_needinsert(ls_table_tmp) THEN 
                 CONTINUE FOREACH 
              END IF

              ##重取關連資料表的KEY值
　　　　　　　　 CALL sadzp188_get_jointable_key(ls_table_str,ls_dzai[ls_i].dzai007, ls_dzai[ls_i].dzai008, ls_dzai[ls_i].dzai009) RETURNING ls_dzai[ls_i].dzai007, ls_dzai[ls_i].dzai009 ##160615-00007 add
              
              #組參考來源join wc    
              LET ls_wc =""
              LET ls_wc = adzp188_combine_ref_join_wc("", ls_table_str, ls_dzai[ls_i].dzai007, "01", "Y", ls_dzai[ls_i].dzai008, ls_dzai[ls_i].dzai009)
    
              #報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入
              #IF ls_table_tmp ="inbd_t" THEN LET ls_table_tmp ="" END IF       #131231先擋inbd_t
              ##先判斷是否存在，不存在則存入
              LET l_dzgb_cnt = 0
              SELECT COUNT(*) INTO l_dzgb_cnt FROM adzp188_dzgb_tmp1
              WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002 AND dzgb011 = ls_wc
                #AND dzgb018 = g_cust AND dzgb019 = g_code_ide #140613 add     ##141013 mark 
                 AND dzgb019 = g_code_ide                                      ##141013 add 
              IF l_dzgb_cnt = 0 THEN    
              #IF NOT (ls_table_tmp = "inbd_t" OR  ls_table_tmp = "inbc_t" OR ls_dzai[ls_i].dzai008 ="inbd_t") THEN
                IF adzp188_chk_table_needinsert(ls_table_tmp) THEN 
                  IF adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai007) AND adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai009) THEN
                    ##141013 mark -(s)
                    #INSERT INTO adzp188_dzgb_tmp1
                            #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_table_tmp,'','','',ls_dzai[ls_i].dzai008,'',ls_wc,
                                   #ls_dzai[ls_i].dzai005,ls_dzai[ls_i].dzai007,ls_dzai[ls_i].dzai008,ls_dzai[ls_i].dzai009,ls_dzai[ls_i].dzai011,'',
                                   #g_cust,g_code_ide)  #140613 add  
                    ##141013 mark -(e)
                    ##141013 add -(s)
                    EXECUTE adzp188_dzgb_tmp1_ins_pre1 USING ls_dzgb_seq,'',ls_table_tmp,'','','',ls_dzai[ls_i].dzai008,'',ls_wc,
                                   ls_dzai[ls_i].dzai005,ls_dzai[ls_i].dzai007,ls_dzai[ls_i].dzai008,ls_dzai[ls_i].dzai009,ls_dzai[ls_i].dzai011,'',
                                   g_cust,g_code_ide 
                    ##141013 add -(e)               
                    LET ls_dzgb_seq = ls_dzgb_seq + 1  
    
                        ##判斷字尾不是保留字才存
                    IF adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai011) AND adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai007) AND adzp188_chk_dzgc_suffix(ls_dzai[ls_i].dzai009) THEN
                        ##撈出欄位存入dzgc_t 
                        IF NOT cl_null(ls_dzai[ls_i].dzai011) THEN  
                            ##141013 mark -(s)
                            #INSERT INTO adzp188_dzgc_tmp
                                    #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgc_seq,ls_dzai[ls_i].dzai011,'1','N','',g_cust,g_code_ide)  #140613 add ,g_cust,g_code_ide
                            ##141013 mark -(e)        
                            EXECUTE adzp188_dzgc_tmp_ins_pre1 USING ls_dzgc_seq,ls_dzai[ls_i].dzai011,'1','N','',g_cust,g_code_ide     #141013 add    
                        END IF 
                        ##140313存入資料表暫存檔--(s)      
                        LET ls_exist = 0         
                        SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
                        WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                          AND dzgi004 = ls_dzai[ls_i].dzai008
                          #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add  #141017 mark
                          AND dzgi006 = g_code_ide #141017 add
                        IF ls_exist = 0 THEN 
                            IF NOT cl_null(ls_dzai[ls_i].dzai008) THEN 
                                SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
                                IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
                                ##141013 mark -(s)
                                #INSERT INTO adzp188_dzgi_tmp
                                        #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq, ls_dzai[ls_i].dzai008,g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
                                ##141013 mark -(e)        
                                EXECUTE adzp188_dzgi_tmp_ins_pre1 USING ls_tableseq, ls_dzai[ls_i].dzai008,g_cust,g_code_ide  ##141013 add        
                            END IF 
                        END IF     
                        ##140313存入資料表暫存檔--(e)                               
                    LET ls_dzgc_seq = ls_dzgc_seq +1
                    END IF    
                  END IF 
                END IF ##IF adzp188_chk_table_needinsert(ls_table_tmp)
              END IF  ##IF l_dzgb_cnt = 0 THEN 
              LET ls_i = ls_i + 1
              LET ls_table_cnt =ls_table_cnt +1
          END IF ##IF ls_table_str = ps_table THEN 
      END FOREACH 

      ###140409
      SELECT MAX(dzgb003)+1 INTO ls_dzgb_seq FROM adzp188_dzgb_tmp1
      ##抓單身table
      #151012-00003#1 mark -(s)
      #SELECT dzag004 INTO l_dzag004 FROM dzag_t
      #WHERE dzag001 = g_gzza001 AND dzag003 = l_dzaa004 AND dzagstus= 'Y' AND dzag005 ='N'
        #AND dzag002 = ps_table  
        ##AND dzag006 = g_code_ide  #140613 add   #150817-00030#1  mark  
        #AND dzag006 = l_spec_ide  #150817-00030#1 add  
      #151012-00003#1 mark -(e)
      #151012-00003#1 add -(s)
      SELECT dzag004 INTO l_dzag004 FROM dzag_t
       INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa003='TABLE' AND dzaa004=dzag003 AND dzaa006=dzag006
       WHERE dzaa001 = g_gzza001 AND dzaa002 = l_spec_ver  AND dzaa005='4' AND dzaastus= 'Y' AND dzaa009 = l_spec_ide 
         AND dzag005 ='N' AND dzag002 = ps_table
      #151012-00003#1 add -(e)
        
      #抓出tableFK值
      CALL adzp188_tab_get_relation(ps_table,"FK",l_dzag004) RETURNING ls_dzed004,ls_dzed006,ls_err_msg
      #未找到fk的table
      LET g_nFind_table = g_nFind_table,ls_err_msg,","   
      
      #組參考來源join wc
      ##組FK的SQL，預設用=(01),EX:inba_t OUTER LEFT JOIN inbb_t ON inbb_t.inbb001 = inba_t.inba001              
      LET ls_wc = adzp188_combine_ref_join_wc("", ps_table, ls_dzed004, "01", "Y", l_dzag004, ls_dzed006)
      
      #報表元件設計-資料模型Table明細檔 預設SQL是自組出來，TABLE仍要存入  
      ##擋掉保留字的wc
      IF adzp188_chk_dzgc_suffix(ls_dzed004) AND adzp188_chk_dzgc_suffix(ls_dzed006) THEN   
         ##141013 mark -(s)
         #INSERT INTO adzp188_dzgb_tmp1
                 #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ps_table,'','','',l_dzag004,'',ls_wc,'','','','','','',g_cust,g_code_ide) #140613 add ,g_cust,g_code_ide
         ##141013 mark -(e)  
         EXECUTE adzp188_dzgb_tmp1_ins_pre1 USING ls_dzgb_seq,'',ps_table,'','','',l_dzag004,'',ls_wc,'','','','','','',g_cust,g_code_ide  ##141013 add       
         LET ls_dzgb_seq = ls_dzgb_seq + 1  
      END IF

       
       ##140408
      #取得欄位的識別碼版次
       #151012-00003#1  mark -(s)
       #LET g_sql = " SELECT DISTINCT dzac002 from dzaa_t,dzac_t ",
                   ##" WHERE dzaa001 = dzac001 and dzaa003 = dzac003 and dzaa004 = dzac004 and dzaa006 = dzac012  AND dzaa001 = '",g_gzza001, "'"," AND dzaastus ='Y' and dzaa005 ='1'", "AND dzaa002='",l_dzaf003,"'",  #141017 mark
                   #" WHERE dzaa001 = dzac001 and dzaa003 = dzac003 and dzaa004 = dzac004 and dzaa006 = dzac012  AND dzaa001 = '",g_gzza001, "'"," AND dzaastus ='Y' and dzaa005 ='1'", "AND dzaa002='",l_dzaf003_ver,"'",   #141017 add
                   ##"   AND dzaa009 ='",l_spec_ide,"' AND dzaa010 ='",g_cust,"'",  #140613 add  ##141013 mark 
                   #"   AND dzaa009 ='",l_spec_ide,"'",  #141013 add 
                   #"   AND dzac002 IS NOT NULL "
       #151012-00003#1  mark -(e)
       #151012-00003#1  add -(s)
       LET g_sql = " SELECT DISTINCT dzac002 FROM dzac_t ",
                   " INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012 ",
                   " WHERE dzaa001 = '",g_gzza001, "'"," AND dzaastus ='Y' and dzaa005 ='1'", "AND dzaa002='",l_spec_ver,"'", 
                   " AND dzaa009 ='",l_spec_ide,"'",
                   " AND dzac002 IS NOT NULL "
       #151012-00003#1  add -(s)


                   
       PREPARE adzp188_dzac_d_pre1 FROM g_sql
       DECLARE adzp188_dzac_d_cs CURSOR FOR adzp188_dzac_d_pre1
       LET ls_i = 1
       LET ls_dzgc_seq = 1
       FOREACH adzp188_dzac_d_cs INTO ls_dzac002[ls_i]     
          #報表元件設計-資料模型欄位明細檔 
          IF NOT cl_null(ls_dzac002[ls_i]) THEN  

             ##140301只抓主，第一單身table欄位
             LET l_gztz001 =''
             SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 =ls_dzac002[ls_i]
                AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
                ##161227-00056#1 add -(s)
                AND gztz001 NOT LIKE 'erp%'   
                AND gztz001 NOT LIKE 'all%'
                AND gztz001 NOT LIKE 'b2b%'
                AND gztz001 NOT LIKE 'pos%'
                AND gztz001 NOT LIKE 'dsm%'
                ##161227-00056#1 add -(e)                
             IF l_gztz001 = ps_table THEN 
                 IF adzp188_chk_dzgc_suffix(ls_dzac002[ls_i]) THEN 
                    LET l_gztz001 =''
                    SELECT gztz001 INTO l_gztz001 FROM gztz_t WHERE gztz002 = ls_dzac002[ls_i]  
                    ##141013 mark -(s)     
                    #INSERT INTO adzp188_dzgc_tmp
                           #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgc_seq,ls_dzac002[ls_i],'1','N',l_gztz001,
                                  #g_cust,g_code_ide)  #140613 add g_cust,g_code_ide
                    ##141013 mark -(e)  
                    ##141013 add -(s)            
                    EXECUTE adzp188_dzgc_tmp_ins_pre1 USING ls_dzgc_seq,ls_dzac002[ls_i],'1','N',l_gztz001,
                                  g_cust,g_code_ide  
                    ##141013 add -(e)                
                    LET ls_dzgc_seq = ls_dzgc_seq + 1  #順序      
                 END IF 
              END IF 

              LET ls_i = ls_i +1
          END IF 
       END FOREACH          

       LET g_alias_seq = 1
       CALL ls_dzgb.clear()
       DELETE FROM adzp188_dzgb_tmp
       ##將left join的wc再處理排序過  ---(S)
       ##ex :inaa LEFT OUTER JOIN inab ON~~
       ##         LEFT OUTER JOIN inac ON~~ ,
       ##    inad LEFT OUTER JOIN inae ON~~   

       LET ls_dzgb_seq = 1
       LET g_sql =" SELECT dzgb003, dzgb004, dzgb005, dzgb006, dzgb007, dzgb008, dzgb009, dzgb010,dzgb011,",
                  "        dzgb012, dzgb013, dzgb014, dzgb015, dzgb016,dzgb017 ",
                  "   FROM adzp188_dzgb_tmp1 ",
                  #"  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'",  #140923 elena mark
                  "  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",             #140923 elena add
                  #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'", #140613 add        #141013 mark  
                  "    AND dzgb019 ='",g_code_ide,"'", #141013 add  
                  "  ORDER BY dzgb005 "
       PREPARE adzp188_dzgb_sort_d_pre FROM g_sql
       DECLARE adzp188_dzgb_sort_d_cs CURSOR FOR adzp188_dzgb_sort_d_pre
       LET ls_i = 1
       FOREACH adzp188_dzgb_sort_d_cs INTO ls_dzgb[ls_i].*
         IF SQLCA.sqlcode THEN
           EXIT FOREACH
         END IF   
         IF ls_i = 1 THEN
            IF cl_null(ls_dzgb[ls_i].dzgb017) THEN LET ls_dzgb[ls_i].dzgb017 = ls_dzgb[ls_i].dzgb014 END IF
            ##141013 mark -(s)  
            #INSERT INTO adzp188_dzgb_tmp
            #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',
                   #ls_dzgb[ls_i].dzgb009,'',ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,
                   #ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,
                   #g_cust,g_code_ide) #140613 add
            ##141013 mark -(e)
            ##141013 add -(s)
            EXECUTE adzp188_dzgb_tmp_ins_pre1 USING ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',
                   ls_dzgb[ls_i].dzgb009,'',ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,
                   ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,
                   g_cust,g_code_ide
            ##141013 add -(e)          
         ELSE    
             LET l_wc_str = ls_dzgb[ls_i].dzgb011
             ##table相同，則left join前換成空白
             IF l_wc_str.getIndexOf("JOIN",1)>0 THEN 
                 IF ls_dzgb[ls_i].dzgb005 = ls_dzgb_t.dzgb005 THEN
                   IF cl_null(ls_dzgb[ls_i].dzgb017) THEN  
                        LET ls_tmp = ls_dzgb[ls_i].dzgb005
                        LET ls_space_str = ls_tmp.getLength()+ 5 SPACE 
                        LET l_wc_str =ls_space_str, l_wc_str.subString(l_wc_str.getindexof(ls_dzgb[ls_i].dzgb005,1)+ls_tmp.getLength() ,l_wc_str.getLength())              
                        LET ls_dzgb[ls_i].dzgb011 = l_wc_str
                   END IF 
                 END IF 
             END IF 
             ##加上別名##   
             IF NOT cl_null(ls_dzgb[ls_i].dzgb012) THEN   ##140325排除foreign key組成的不置換別名         
                 CALL adzp188_ref_wc_addalias(l_wc_str,ls_dzgb[ls_i].dzgb009) RETURNING ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb017  
                 IF cl_null(ls_dzgb[ls_i].dzgb017) THEN  LET ls_dzgb[ls_i].dzgb017 = ls_dzgb[ls_i].dzgb009 END IF   
                 #LET ls_dzgb[ls_i].dzgb011 = adzp188_ref_wc_addalias(l_wc_str,ls_dzgb[ls_i].dzgb009) # l_wc_str
             END IF  
             ##141013 mark -(s)  
             #INSERT INTO adzp188_dzgb_tmp
                  #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',
                         #ls_dzgb[ls_i].dzgb009,'',ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,
                         #ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,
                         #g_cust,g_code_ide) #140613 add
            ##141013 mark -(e)
            ##141013 add -(s)
            EXECUTE adzp188_dzgb_tmp_ins_pre1 USING ls_dzgb_seq,'',ls_dzgb[ls_i].dzgb005,'','','',
                         ls_dzgb[ls_i].dzgb009,'',ls_dzgb[ls_i].dzgb011,ls_dzgb[ls_i].dzgb012,ls_dzgb[ls_i].dzgb013,
                         ls_dzgb[ls_i].dzgb014,ls_dzgb[ls_i].dzgb015,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017,
                         g_cust,g_code_ide 
            ##141013 add -(e)              
         END IF         
             LET ls_dzgb_seq = ls_dzgb_seq + 1   
             LET ls_dzgb_t.* =ls_dzgb[ls_i].*     

         ##140206存入資料表暫存檔--(s)
         LET ls_exist = 0         

         SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
          WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
            AND dzgi004 = ls_dzgb[ls_i].dzgb005
            #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add  ##141013 mark
            AND dzgi006 = g_code_ide                                      ##141013 add   
          
         IF ls_exist = 0 THEN 

           IF NOT cl_null(ls_dzgb[ls_i].dzgb005) THEN 
              SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
              IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
              ##141013 mark -(s)
              INSERT INTO adzp188_dzgi_tmp
                   VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq , ls_dzgb[ls_i].dzgb005,g_cust,g_code_ide)  #140613 add ,g_cust,g_code_ide
              ##141013 mark -(e)     
              ##141013 add -(s)
              EXECUTE adzp188_dzgi_tmp_ins_pre1 USING ls_tableseq , ls_dzgb[ls_i].dzgb005,g_cust,g_code_ide
              ##141013 add -(e)     
           END IF 

         END IF   
         LET ls_exist = 0         

         SELECT COUNT(*) INTO ls_exist FROM adzp188_dzgi_tmp 
          WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
            AND dzgi004 = ls_dzgb[ls_i].dzgb009
            #AND dzgi005 = g_cust AND dzgi006 = g_code_ide #140613 add   ##141013 mark
            AND dzgi006 = g_code_ide     ##141013 add
      
         IF ls_exist = 0 THEN 
 
             IF NOT cl_null(ls_dzgb[ls_i].dzgb009) THEN 
               SELECT MAX(dzgi003)+1 INTO ls_tableseq FROM adzp188_dzgi_tmp
               IF ls_tableseq = 0 OR cl_null(ls_tableseq) THEN LET ls_tableseq = 1 END IF 
                 ##141013 mark -(s)
                 #INSERT INTO adzp188_dzgi_tmp
                      #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, ls_tableseq , ls_dzgb[ls_i].dzgb009,g_cust,g_code_ide)  #140613 add ,g_cust,g_code_ide
                 ##141013 mark -(s)     
                 ##141013 add -(s)
                 EXECUTE adzp188_dzgi_tmp_ins_pre1 USING ls_tableseq , ls_dzgb[ls_i].dzgb009,g_cust,g_code_ide
                 ##141013 add -(e)        
             END IF 

         END IF      
         ##140206存入資料表暫存檔--(e)      
         LET ls_i = ls_i + 1    
       END FOREACH 
         
        ##140317新的~(s)
        CALL l_dzgi004.clear()
        LET li_k = 1
        LET li_j = 1
        CALL lc_tmp.clear()
        LET g_sql = "SELECT dzgi004 FROM adzp188_dzgi_tmp ",
                    #" WHERE dzgi001 = '", g_dzga_m.dzga001,"' AND dzgi002 = '", g_dzga_m.dzga002,"'",  #140923 elena mark
                    " WHERE dzgi001 = '", g_dzga_m.dzga001,"' AND dzgi002 = '", gs_ver,"'",             #140923 elena add
                    #"   AND dzgi005 = '", g_cust,"' AND dzgi006 = '", g_code_ide,"'", #140613 add  ##141013 mark 
                    "   AND dzgi006 = '", g_code_ide,"'", #141013 add
                    " ORDER BY dzgi003 "  
        PREPARE xg_dzgi_d_pre FROM g_sql
        DECLARE xg_dzgi_d_curs CURSOR FOR xg_dzgi_d_pre     
        FOREACH xg_dzgi_d_curs INTO l_dzgi004[li_k]     
           LET li_k = li_k +1
        END FOREACH 
        CALL l_dzgi004.deleteElement(li_k)

        ##140324 -(S)增加單頭table
        ##140324 -(E)
        LET li_i = 1
        FOR li_k = 1 TO l_dzgi004.getLength()
             ##140331 增加主表7個保留字尾欄位至dzgc -(s)
             IF li_k = 1 THEN
                CALL adzp188_add_main_table_suffix(l_dzgi004[li_k]) 
             END IF  
             ##140331 增加主表7個保留字尾欄位至dzgc -(e)

             LET l_dzgi004_str = l_dzgi004[li_k]
             LET l_dzgi004_str = l_dzgi004_str.subString(1,l_dzgi004_str.getIndexOf("_",1)-1),"%"

             LET g_sql = " SELECT dzgc003,dzgc004 FROM adzp188_dzgc_tmp ",
                        " WHERE dzgc006 ='N'",
                        #"   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",  #140923 elena mark
                        "   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",             #140923 elena add
                        "   AND dzgc004 LIKE '",l_dzgi004_str,"'",
                        #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'", #140613 add  ##141013 mark 
                        "   AND dzgc009 ='",g_code_ide,"'", #141013 add
                        " ORDER BY dzgc004 "
            PREPARE xg_dzgc_d_pre FROM g_sql
            DECLARE xg_dzgc_d_curs CURSOR FOR xg_dzgc_d_pre     
            FOREACH xg_dzgc_d_curs INTO lc_tmp[li_i].*    
               LET li_i = li_i +1
            END FOREACH       
        END FOR 
        ##140506 type_t也要排序 -(s)
        LET g_sql = " SELECT dzgc003,dzgc004 FROM adzp188_dzgc_tmp ",
                    " WHERE dzgc006 ='Y'",
                    #"   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",  #140923 elena mark
                    "   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",             #140923 elena add
                    #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'", #140613 add          #141013 mark
                    "   AND dzgc009 ='",g_code_ide,"'",                       #141013 add       
                    " ORDER BY dzgc004 "
        PREPARE xg_dzgc_d_pre1 FROM g_sql
        DECLARE xg_dzgc_d_curs1 CURSOR FOR xg_dzgc_d_pre1    
        FOREACH xg_dzgc_d_curs1 INTO lc_tmp[li_i].*    
           LET li_i = li_i +1
        END FOREACH    
        ##140506 type_t也要排序 -(s)       
        CALL lc_tmp.deleteElement(li_i)
        ##先把順序搬到很遠去
        FOR li_i = 1 TO lc_tmp.getLength()
            LET li_i_cnt = li_i * 10000
            UPDATE adzp188_dzgc_tmp SET dzgc003 = li_i_cnt
             WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
               AND dzgc004 = lc_tmp[li_i].lc_dzgc004 AND dzgc003 = lc_tmp[li_i].lc_dzgc003  
               #AND dzgc008 = g_cust AND dzgc009 = g_code_ide  #140613 add    ##141013 mark
                AND dzgc009 = g_code_ide                                      ##141013 add 
              
             LET lc_tmp[li_i].lc_dzgc003 = li_i_cnt 
        END FOR 
        ##再依序把順序搬對
        FOR li_i = 1 TO lc_tmp.getLength()
            UPDATE adzp188_dzgc_tmp SET dzgc003 = li_i
             WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
               AND dzgc004 = lc_tmp[li_i].lc_dzgc004 AND dzgc003 = lc_tmp[li_i].lc_dzgc003  
               #AND dzgc008 = g_cust AND dzgc009 = g_code_ide  #140613 add    ##141013 mark
               AND dzgc009 = g_code_ide                                       ##141013 add 
               
        END FOR   
        
        ##140317新的~(e)
        ##欄位照table順序重排--(e)
        
        ##將別名補入dzgc--(s)
        CALL lc_tmp.clear()
        LET li_j = 1
        LET g_sql = " SELECT DISTINCT dzgc004 FROM adzp188_dzgc_tmp " ,
                    #"  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",g_dzga_m.dzga002,"'",    #140923 elena mark
                    "  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",gs_ver,"'",             #140923 elena add
                    #"    AND dzgc008 ='",g_cust ,"' AND dzgc009 ='",g_code_ide,"'", #140613 add  #141013 mark
                    "    AND dzgc009 ='",g_code_ide,"'", #141013 add
                    "  ORDER BY dzgc004 "
        PREPARE dzgc004_get_d_pre FROM g_sql
        DECLARE dzgc004_get_d_cs CURSOR FOR dzgc004_get_d_pre
        FOREACH dzgc004_get_d_cs INTO l_dzgc004[li_j]
                LET li_j = li_j + 1
        END FOREACH 
        CALL l_dzgc004.deleteElement(li_j)

        FOR li_k = 1 TO l_dzgc004.getLength()
            
            ##抓出reference的別名
            CALL l_dzgb_n.clear()
            LET l_i = 1
            LET g_sql = " SELECT dzgb015,dzgb016,dzgb017 FROM adzp188_dzgb_tmp ",
                        ##141013 mark -(s) 
                        #"  WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",g_dzga_m.dzga002,"'",
                        #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'", #140613 add
                        ##141013 mark -(e)
                        ##141013 add -(s)
                        "  WHERE dzgb001 ='",g_dzga_m.dzga001,"'", " AND dzgb002 ='",gs_ver,"'",
                        "    AND dzgb019 ='",g_code_ide,"'", 
                        ##141013 mark -(e)                       
                        "    AND dzgb016 ='", l_dzgc004[li_k] ,"'"
            PREPARE adzp188_get_dzgb017n_d_pre FROM g_sql
            DECLARE adzp188_get_dzgb017n_d_cs1 CURSOR FOR adzp188_get_dzgb017n_d_pre
            FOREACH adzp188_get_dzgb017n_d_cs1 INTO l_dzgb_n[l_i].*
               LET l_i = l_i + 1
            END FOREACH 
            CALL l_dzgb_n.deleteElement(l_i)
            ##抓dzgc欄位
            LET l_i = 1
            CALL lc_tmp.clear()
            LET g_sql = " SELECT dzgc003,dzgc004 FROM adzp188_dzgc_tmp " ,
                        #"  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",g_dzga_m.dzga002,"'",  #140923 elena mark
                        "  WHERE dzgc001 ='", g_dzga_m.dzga001,"'", " AND dzgc002 ='",gs_ver,"'",             #140923 elena add
                        "    AND dzgc004 ='",l_dzgc004[li_k],"'",
                        #"    AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'", #140613 add #141013 mark
                        "    AND dzgc009 ='",g_code_ide,"'",                                        #141013 add
                        "  ORDER BY dzgc003 "      
            PREPARE dzgc004_get_d_pre1 FROM g_sql
            DECLARE dzgc004_get_d_cs1 CURSOR FOR dzgc004_get_d_pre1
            FOREACH dzgc004_get_d_cs1 INTO lc_tmp[l_i].*
                LET l_alias =''
                IF NOT cl_null(l_dzgb_n[l_i].l_dzgb017) THEN
                   LET l_alias = l_dzgb_n[l_i].l_dzgb017
                ELSE 
                   SELECT gztz001 INTO l_alias FROM gztz_t WHERE gztz002 = lc_tmp[l_i].lc_dzgc004    
                      AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add   
                      ##161227-00056#1 add -(s)
                      AND gztz001 NOT LIKE 'erp%'   
                      AND gztz001 NOT LIKE 'all%'
                      AND gztz001 NOT LIKE 'b2b%'
                      AND gztz001 NOT LIKE 'pos%'
                      AND gztz001 NOT LIKE 'dsm%'
                      ##161227-00056#1 add -(e)                      
                END IF 
                UPDATE adzp188_dzgc_tmp SET dzgc007 = l_alias
                 WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002   ##141013 mark        
                   AND dzgc003 = lc_tmp[l_i].lc_dzgc003
                   AND dzgc009 = g_code_ide #140613 add
                   
                LET l_i = l_i + 1
            END FOREACH 
        END FOR        

         ###140506-(s)  判斷主欄位的屬性符合需要存組合欄位的屬性
       CALL ls_dzgb.clear()   
       LET g_sql =" SELECT dzgb003, dzgb004, dzgb005, dzgb006, dzgb007, dzgb008, dzgb009, dzgb010,dzgb011,",
                  "        dzgb012, dzgb013, dzgb014, dzgb015, dzgb016,dzgb017 ",
                  "   FROM adzp188_dzgb_tmp ",
                  #"  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",g_dzga_m.dzga002,"'",  #140923 elena mark
                  "  WHERE dzgb001 = '",g_dzga_m.dzga001,"' AND dzgb002 = '",gs_ver,"'",             #140923 elena add
                  #"    AND dzgb018 ='",g_cust,"' AND dzgb019 ='",g_code_ide,"'", #140613 add  ##141013 mark
                  "    AND dzgb019 ='",g_code_ide,"'",                                         ##141013 add
                  "  ORDER BY dzgb005 "
       PREPARE adzp188_dzgb_d_pre FROM g_sql
       DECLARE adzp188_dzgb_d_cs CURSOR FOR adzp188_dzgb_d_pre
       LET ls_i = 1
       FOREACH adzp188_dzgb_d_cs INTO ls_dzgb[ls_i].*

         LET ls_table_str = ls_dzgb[ls_i].dzgb012 
         ##判斷撈出來的table，若是b_inbb004->inbb_t，inbb_t.inbb004->inbb_t      
         IF ls_table_str.getIndexOf("b_",1)>0 AND ls_table_str.getIndexOf(".",1) = 0  THEN
            ##140429 抓主欄位
            LET l_m_field = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength())

            LET ls_table_str = ls_table_str.subString(ls_table_str.getIndexOf("b_",1)+2,ls_table_str.getLength()-3),"_t"
         ELSE 
            IF ls_table_str.getIndexOf(".",1)>0 THEN 
               ##140429 抓主欄位
               LET l_m_field = ls_table_str.subString(ls_table_str.getIndexOf(".",1)+1,ls_table_str.getLength())
               
               LET ls_table_str = ls_table_str.subString(1,ls_table_str.getIndexOf(".",1)-1)
            END IF
         END IF     
        ##判斷主欄位的屬性符合需要存組合欄位的屬性
         IF sadzp188_tab_chk_field_property(l_m_field,"C") THEN 
            IF NOT cl_null(ls_dzgb[ls_i].dzgb016) THEN 
               CALL adzp188_handle_combine_field(l_m_field,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017)
            END IF 
         END IF 
         LET ls_i = ls_i + 1
       END FOREACH 
        ###140506-(e)  判斷主欄位的屬性符合需要存組合欄位的屬性
        
       ##樣板設定的數值 140118
       ##GR從4RP讀取
       ##XG從gzgf017讀出   

       CALL adzp188_tablesel_b_fill()           #資料表
       CALL adzp188_tablejoin_wclist_b_fill()   #連結
       CALL adzp188_filter_b_fill()             #篩選       
    END IF     

END FUNCTION 


################################################################################
# Descriptions...: 組合出的SQL方便要驗證
# Memo...........: 
# Usage..........: CALL adzp188_combine_sql_to_verify() 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/10
# Modify.........:
################################################################################
FUNCTION adzp188_combine_sql_to_verify(ps_dzga001,ps_dzga002,ps_dzga003)
  DEFINE ps_dzga001     LIKE dzga_t.dzga001
  DEFINE ps_dzga002     LIKE dzga_t.dzga002
  DEFINE ps_dzga003     LIKE dzga_t.dzga003
  DEFINE ls_select      STRING 
  DEFINE ls_from        STRING 
  DEFINE ls_where       STRING 
  DEFINE ls_order       STRING 
  DEFINE ls_sql         STRING 
  DEFINE ls_d_select    STRING    ##單身join出來的欄位
  DEFINE ls_from_buf    base.StringBuffer
##150126 add-for 卡迪笙效用使用的sql(s)  
  DEFINE ls_select1      STRING 
  DEFINE ls_from1        STRING 
  DEFINE ls_where1       STRING 
  DEFINE ls_sql1         STRING 
##150126 add-卡迪笙效用使用的sql(e)   
  
   LET ls_select = ""
   #CALL sadzp188_get_field(ps_dzga001 ,ps_dzga002,'2') RETURNING ls_select,ls_d_select   #140619 mark
   CALL sadzp188_get_field(ps_dzga001 ,ps_dzga002,'2',g_code_ide) RETURNING ls_select,ls_d_select    #140619 add
   CALL adzp188_select_fields_combine(ls_select) RETURNING ls_select
   #160615-00007#1 add -(s)
   IF ls_select.getIndexOf("g_dlang",1)>1 OR ls_select.getIndexOf("g_enterprise",1)>1 THEN
      CALL adzp188_handle_ent_lang(ls_select) RETURNING ls_select  
   END IF 
   #160615-00007#1 add -(e)
   LET ls_select1 = ls_select  ##150126 add
   LET ls_select = "<field>",ls_select,"</field>"  ##為了檢查解析要加的tag
   
   LET ls_from = ""
   #CALL sadzp188_get_fromwhere_str(ps_dzga001,ps_dzga002,"from",ls_d_select) RETURNING ls_from  #140619 mark
   CALL sadzp188_get_fromwhere_str(ps_dzga001,ps_dzga002,"from",ls_d_select,g_code_ide) RETURNING ls_from   #140619 add
   IF ls_from.getIndexOf("g_dlang",1)>1 OR ls_from.getIndexOf("g_enterprise",1)>1 THEN
      CALL adzp188_handle_ent_lang(ls_from) RETURNING ls_from  
   END IF 
   LET ls_from1 = ls_from  ##150126 add
   LET ls_from = "<table>",ls_from,"</table>"      ##為了檢查解析要加的tag
   
   LET ls_where = ""
   #CALL sadzp188_get_fromwhere_str(ps_dzga001,ps_dzga002,"where","") RETURNING ls_where   #140619 mark
   CALL sadzp188_get_fromwhere_str(ps_dzga001,ps_dzga002,"where","",g_code_ide) RETURNING ls_where    #140619 add
   #IF cl_null(ls_where) THEN LET ls_where = " 1=1 " END IF
   LET ls_where = ls_where ," 1 = 1 " 
   LET ls_where1 = ls_where  ##150126 add
   LET ls_where = "<wc>",ls_where,"</wc>"            ##為了檢查解析要加的tag

   IF ps_dzga003 = "1" THEN 
       LET ls_order =""
       #CALL sadzp188_get_order_str(ps_dzga001,ps_dzga002,"sql") RETURNING ls_order  #140619 mark
       CALL sadzp188_get_order_str(ps_dzga001,ps_dzga002,"sql",g_code_ide) RETURNING ls_order   #140619 add
       IF NOT cl_null(ls_order) THEN 
          LET ls_order = " ORDER BY ",ls_order
       END IF 
   END IF

   LET ls_sql = " SELECT ", ls_select, " FROM ",ls_from," WHERE ", ls_where," ", ls_order
   LET ls_sql1 = " SELECT ", ls_select1, " FROM ",ls_from1," WHERE ", ls_where1," ", ls_order  ##150126 add
   RETURN ls_sql,ls_sql1

END FUNCTION 



################################################################################
# Descriptions...: 解析g_select->select sql(參考adzp151_fields_define)
# Memo...........: 
# Usage..........: CALL adzp188_select_fields_combine(ls_select) 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/11
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_select_fields_combine(p_list)  
   DEFINE p_list                  STRING               #內容值
   DEFINE lst_token               base.StringTokenizer
   DEFINE ls_token                STRING
   DEFINE l_token_count           LIKE type_t.num5
   DEFINE l_str_token_count       LIKE type_t.num5
   DEFINE ls_sql_new              STRING      #sql填入值
   DEFINE ls_type                 STRING       #變數型態
   DEFINE ls_name                 STRING       #變數名稱
   DEFINE ls_default              STRING       #預設值
   
   
   LET ls_sql_new = ""   

   LET lst_token = base.StringTokenizer.create(p_list.trim(), ',')
   LET l_str_token_count = lst_token.countTokens()

   LET l_token_count = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET l_token_count = l_token_count + 1
      #如果標示欄位名稱的字串中含有 (),表示要使用 type_t, 並且是用()內指定的型態
      #如果()裡有|，表示有預設值
      CASE 
         WHEN ls_token.getIndexOf("(",1) 
            LET ls_name = ls_token.subString(1,ls_token.getIndexOf("(",1)-1)
            #參考欄位
            LET ls_type = ls_token.subString(ls_token.getIndexOf("(",1)+1,ls_token.getIndexOf(")",1)-1)
            IF ls_type.getIndexOf("|",1) > 0 THEN
               LET ls_type = ls_token.subString(ls_token.getIndexOf("(",1)+1,ls_token.getIndexOf("|",1)-1)
               #預設值
               #LET ls_default = ls_token.subString(ls_token.getIndexOf("|",1)+1,ls_token.getIndexOf(")",1)-1)
               ##140416 add

               LET ls_default = ls_token.subString(ls_token.getIndexOf("|",1)+1,ls_token.getLength()-1)  ##trim(apca004)||'':''||trim(apca005)

               #若有計算元，加上括號
               IF ls_default.getIndexOf("+",1)>0 OR ls_default.getIndexOf("-",1)>0 OR
                  ls_default.getIndexOf("*",1)>0 OR ls_default.getIndexOf("/",1)>0 THEN 
                  LET ls_default = "(",ls_default ,")"
               END IF 

               IF ls_default IS NULL OR cl_null(ls_default) THEN
                  LET ls_default = ls_name  
               END IF 
            END IF  
            LET ls_sql_new = ls_sql_new,ls_default

         OTHERWISE      
            LET ls_sql_new = ls_sql_new,ls_token.trim()
            
      END CASE
      IF l_str_token_count != l_token_count THEN
          LET ls_sql_new = ls_sql_new, ","
      END IF
   END WHILE
   RETURN ls_sql_new

END FUNCTION


################################################################################
# Descriptions...: 解析g_enterprise' g_dlang
# Memo...........: 
# Usage..........: CALL adzp188_select_fields_combine(p_from) 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/11
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp188_handle_ent_lang(p_from)  
  DEFINE p_from          STRING 
  DEFINE ls_from_buf     base.StringBuffer
  DEFINE l_temp          STRING 
  DEFINE l_temp1          STRING 
  DEFINE ls_from         STRING 

  LET ls_from_buf = base.StringBuffer.create()
  CALL ls_from_buf.clear()
  CALL ls_from_buf.append(p_from)

  WHILE ls_from_buf.getIndexOf('genterprise',1)>0 OR ls_from_buf.getIndexOf('dlang',1)>0 
      #LET l_temp = "'\" ,", "g_enterprise",",\"'\" ,\""   #160615-00007#1 mark
      LET l_temp = "g_enterprise"                          #160615-00007#1 add
      LET l_temp1 ="'",g_enterprise,"'"
      
      #CALL ls_from_buf.replace(l_temp,g_enterprise,1)     #160615-00007#1 mark ##ENT是數字不用加上單引號

      
      #LET l_temp = "'\" ,", "g_dlang",",\"'\" ,\""        #160615-00007#1 mark  
      LET l_temp = "g_dlang"                               #160615-00007#1 add
      LET l_temp1 ="'",g_dlang,"'"
      #CALL ls_from_buf.replace(l_temp,l_temp1,1)          #160615-00007#1 mark  
      CALL ls_from_buf.replace(l_temp,l_temp1,0)            #160615-00007#1 add
         
  END WHILE    

  LET ls_from = ls_from_buf.toString()
  RETURN ls_from 
 

END FUNCTION

##140415 -(s)
################################################################################
# Descriptions...: 解析g_enterprise' g_dlang
# Memo...........: 
# Usage..........: CALL adzp188_select_fields_combine(p_from) 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/14
# Modify.........:
################################################################################
PUBLIC FUNCTION adzp188_01()
   DEFINE lwin_curr      ui.Window    #adzp188_01 
   DEFINE ls_wintitle    STRING


   #畫面開啟 (identifier)
   OPEN WINDOW w_adzp188_01 WITH FORM cl_ap_formpath("adz","adzp188_01")
   LET ls_wintitle = "自訂欄位維護視窗"
   LET lwin_curr = ui.window.getCurrent()
   CALL lwin_curr.setText(ls_wintitle)

   CALL adzp188_01_init()

   #進入選單 Menu (="N")
   CALL adzp188_01_ui_dialog()
   IF NOT cl_null(g_combine_dzgd006) THEN 
      LET g_dzgd_d.dzgd006 = g_combine_dzgd006
   END IF 

   CLOSE WINDOW w_adzp188_01

END FUNCTION


PRIVATE FUNCTION adzp188_01_init()

    DISPLAY g_dzgd_d.dzgd003 TO formonly.dzgd003
    DISPLAY g_dzgd_d.dzgd005 TO formonly.dzgd005  
    #141127 mark -(s)  
    #DISPLAY g_dzgd004_1 TO formonly.dzgd004
    #DISPLAY g_dzgd004_2 TO formonly.dzgd004_table
    #141127 mark -(e)
    #141127 add -(s)
    DISPLAY g_dzgd004_1 TO formonly.dzgd004
    DISPLAY g_dzgd004_2 TO formonly.dzgd004_table  
    #141127 add -(e)
    LET g_ud_dzgd.dzgd006_1 = ""
    LET g_ud_dzgd.dzgd006_2 = "."
    LET g_ud_dzgd.dzgd006_3 = ""
    LET g_combine_dzgd006 = ""

    ##140508 先抓預設資料 
    CALL adzp188_01_default(g_dzgd_d.dzgd003)
    
    DISPLAY g_ud_dzgd.dzgd006_1 TO formonly.dzgd006_1
    DISPLAY g_ud_dzgd.dzgd006_2 TO formonly.dzgd006_2
    DISPLAY g_ud_dzgd.dzgd006_3 TO formonly.dzgd006_3
    DISPLAY g_combine_dzgd006 TO formonly.dzgd006_field_combine
    ##欄位樹狀
    #CALL adzp188_01_fieldlist_b_fill()
    ##150323 add -(s)
    ##讓紙張不變灰階
    CALL adzp188_set_paper_data(TRUE)
    ##150323 add -(e)    

END FUNCTION

################################################################################
# Descriptions...: 先抓自訂欄位資料
# Memo...........: 
# Usage..........: CALL adzp188_01_default() 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/05/08
# Modify.........:
################################################################################
FUNCTION adzp188_01_default(ps_dzgd003)
  DEFINE ps_dzgd003      LIKE dzgd_t.dzgd003
  DEFINE l_dzgd006       LIKE dzgd_t.dzgd006
  DEFINE ls_dzgd006      STRING 
  
  
   LET ls_dzgd006 = ""
   SELECT dzgd006 INTO l_dzgd006 FROM dzgd_t 
    WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
      AND dzgd003 = ps_dzgd003
      #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add   ##141013 mark
      AND dzgd008 = g_code_ide    ##141013 add

   LET ls_dzgd006 = l_dzgd006
   LET g_combine_dzgd006 = ls_dzgd006   
   #140715 mark -(s)
   #LET g_ud_dzgd.dzgd006_1 = ls_dzgd006.subString(ls_dzgd006.getIndexOf("(",1)+1,ls_dzgd006.getIndexOf(")",1)-1)
   #LET ls_dzgd006 = ls_dzgd006.subString(ls_dzgd006.getIndexOf(")",1)+1,ls_dzgd006.getLength())
   #LET g_ud_dzgd.dzgd006_3 = ls_dzgd006.subString(ls_dzgd006.getIndexOf("(",1)+1,ls_dzgd006.getIndexOf(")",1)-1)
   #140715 mark -(e)
   #140715 add -(s)
   LET g_ud_dzgd.dzgd006_1 = ls_dzgd006.subString(ls_dzgd006.getIndexOf("trim(",1)+5,ls_dzgd006.getIndexOf(")",1)-1)
   #DISPLAY "dzgd006_1:",g_ud_dzgd.dzgd006_1
   LET ls_dzgd006 = ls_dzgd006.subString(ls_dzgd006.getIndexOf(")",1)+1,ls_dzgd006.getLength())
   #DISPLAY "ls_dzgd006:",ls_dzgd006
   LET g_ud_dzgd.dzgd006_3 = ls_dzgd006.subString(ls_dzgd006.getIndexOf("trim(",1)+5,ls_dzgd006.getIndexOf(")",1)-1)
   #DISPLAY "dzgd006_3:",g_ud_dzgd.dzgd006_3
   #140715 add -(e)  
END FUNCTION 


PRIVATE FUNCTION adzp188_01_ui_dialog()
   DEFINE l_dest         STRING          ##目的地
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form

   LET lwin_curr = ui.window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()        
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)  ##150424 add ,FIELD ORDER FORM

        INPUT g_ud_dzgd.dzgd006_1,g_ud_dzgd.dzgd006_2, g_ud_dzgd.dzgd006_3, g_combine_dzgd006
           FROM formonly.dzgd006_1, formonly.dzgd006_2,formonly.dzgd006_3, formonly.dzgd006_field_combine
             ATTRIBUTES(WITHOUT DEFAULTS)

               BEFORE FIELD dzgd006_1
                  LET l_dest = "dzgd006_1"
                  CALL lfrm_curr.setFieldStyle("formonly.dzgd006_1", "focus")  
                  CALL lfrm_curr.setFieldStyle("formonly.dzgd006_3", "unfocus")

               ON CHANGE dzgd006_2
                  LET l_dest = "dzgd006_2"                  

               BEFORE FIELD dzgd006_3
                  LET l_dest = "dzgd006_3"   
                  CALL lfrm_curr.setFieldStyle("formonly.dzgd006_1", "unfocus")  
                  CALL lfrm_curr.setFieldStyle("formonly.dzgd006_3", "focus")

               AFTER FIELD dzgd006_1
                  LET l_dest = "dzgd006_1"                  
                 

               AFTER FIELD dzgd006_2
                  LET l_dest = "dzgd006_2"                  

               AFTER FIELD dzgd006_3
                  LET l_dest = "dzgd006_3"   
 
               
        END INPUT
        
        #欄位頁簽-樹狀
        DISPLAY ARRAY g_udfieldlist TO s_udfieldlist.* ATTRIBUTES(COUNT = g_udfieldlist.getLength())
           BEFORE DISPLAY
              CALL DIALOG.setSelectionMode("s_udfieldlist", 1)
              CALL gdig_curr.setActionActive("add_udfield", TRUE)
           BEFORE ROW
              LET g_udfieldlist_idx = DIALOG.getCurrentRow("s_udfieldlist")
              #是Table的話, 不給多選
              IF g_udfieldlist[g_fieldlist_idx].isnode THEN
                 CALL DIALOG.setSelectionMode("s_udfieldlist", 0)
              ELSE
                 CALL DIALOG.setSelectionMode("s_udfieldlist", 1)
              END IF
             
           #功能鍵方式增加
           ON ACTION add_udfield
              CASE l_dest
                   WHEN "dzgd006_1" 
                      #LET g_ud_dzgd.dzgd006_1 =  g_udfieldlist[g_udfieldlist_idx].id  ##原版140423
                      LET g_ud_dzgd.dzgd006_1 = g_udfieldlist[g_udfieldlist_idx].alias CLIPPED ,".", g_udfieldlist[g_udfieldlist_idx].id CLIPPED ##新版加上別名140423                    
                   WHEN "dzgd006_3" 
                      #LET g_ud_dzgd.dzgd006_3 = g_udfieldlist[g_udfieldlist_idx].id    ##原版140423 
                      LET g_ud_dzgd.dzgd006_3 = g_udfieldlist[g_udfieldlist_idx].alias CLIPPED ,".", g_udfieldlist[g_udfieldlist_idx].id CLIPPED ##新版加上別名140423                    
              END CASE 
        END DISPLAY

        #函式頁簽-樹狀
        DISPLAY ARRAY g_funclist TO s_funclist.* ATTRIBUTES(COUNT=g_funclist.getLength())
           BEFORE DISPLAY
              CALL DIALOG.setSelectionMode("s_funclist", 1)
              CALL gdig_curr.setActionActive("add_func", TRUE)
           BEFORE ROW
              LET g_funclist_idx = DIALOG.getCurrentRow("s_funclist")
              #是Table的話, 不給多選
              IF g_funclist[g_funclist_idx].isnode THEN
                 CALL DIALOG.setSelectionMode("s_funclist", 0)
              ELSE
                 CALL DIALOG.setSelectionMode("s_funclist", 1)
              END IF
             
           #功能鍵方式增加
           ON ACTION add_func
                 DISPLAY g_funclist[g_funclist_idx].id TO formonly.dzgd006_2
                
        END DISPLAY        

        ON ACTION comfield_com
           CALL adzp188_01_combine(g_ud_dzgd.dzgd006_1,g_ud_dzgd.dzgd006_2, g_ud_dzgd.dzgd006_3) RETURNING g_combine_dzgd006

        ON ACTION comfield_add    
           LET g_dzgd_d.dzgd006 = g_combine_dzgd006
           EXIT DIALOG 

        ON ACTION comfield_cls
           LET g_combine_dzgd006 = ""
           DISPLAY g_combine_dzgd006 TO formonly.dzgd006_field_combine          
        
      ON ACTION close
         EXIT DIALOG
   END DIALOG
END FUNCTION


FUNCTION adzp188_01_combine(p_dzgd006_1,p_dzgd006_2, p_dzgd006_3)
  DEFINE p_dzgd006_1     LIKE dzgd_t.dzgd003
  DEFINE p_dzgd006_2     LIKE dzgd_t.dzgd003
  DEFINE p_dzgd006_3     LIKE dzgd_t.dzgd003
  DEFINE ls_dzgd006      LIKE dzgd_t.dzgd006 

  LET ls_dzgd006 = ""
  IF NOT cl_null(p_dzgd006_1) AND NOT cl_null(p_dzgd006_3) THEN #140715 分隔點可不存在
  #IF NOT cl_null(p_dzgd006_1) AND NOT cl_null(p_dzgd006_2) AND NOT cl_null(p_dzgd006_3) THEN #140715 mark
     ##目前只做trim() for 複合欄位
     IF NOT cl_null(p_dzgd006_2) THEN 
        LET ls_dzgd006 = "trim(",p_dzgd006_1,")||'",p_dzgd006_2, "'||trim(",p_dzgd006_3,")"
     ELSE 
        LET ls_dzgd006 = "trim(",p_dzgd006_1,")" ,"||trim(",p_dzgd006_3,")"
     END IF 
  END IF 

  RETURN ls_dzgd006
END FUNCTION 

################################################################################
# Descriptions...: 刪除此報表元件table
# Memo...........: 
# Usage..........: CALL adzp188_delete_table() 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/28
# Modify.........:
################################################################################
FUNCTION adzp188_delete_table()

   #先將暫存檔清空
   ##141013 mark -(s)
   #DELETE FROM dzga_t WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = g_dzga_m.dzga002 
                        #AND dzga005 = g_cust AND dzga006 = g_code_ide     #140612 add
                        #
   #DELETE FROM dzgb_t WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                        #AND dzgb018 = g_cust AND dzgb019 = g_code_ide     #140612 add
                        #
   #DELETE FROM dzgc_t WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                        #AND dzgc008 = g_cust AND dzgc009 = g_code_ide     #140612 add
                        #
   #DELETE FROM dzgd_t WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                        #AND dzgd007 = g_cust AND dzgd007 = g_code_ide     #140612 add
                        #
   #DELETE FROM dzge_t WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002 
                        #AND dzge008 = g_cust AND dzge009 = g_code_ide     #140612 add  
                        #
   #DELETE FROM dzgf_t WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                        #AND dzgf011 = g_cust AND dzgf012 = g_code_ide     #140612 add
                        #
   #DELETE FROM dzgj_t WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
                        #AND dzgj007 = g_cust AND dzgj008 = g_code_ide     #140612 add
                        #
   #DELETE FROM dzgi_t WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                        #AND dzgi005 = g_cust AND dzgi006 = g_code_ide     #140612 add 
                        #
   #DELETE FROM dzgg_t WHERE dzgg001 = g_dzga_m.dzga001 AND dzgg002 = g_dzga_m.dzga002 AND dzgg003 = g_dzga_m.dzga001
                        #AND dzgg016 = g_cust AND dzgg017 = g_code_ide     #140612 add 
                        #
   #DELETE FROM dzgh_t WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002 AND dzgh003 = g_dzga_m.dzga001
                        #AND dzgh011 = g_cust AND dzgh011 = g_code_ide     #140612 add  
                        #
   #DELETE FROM gzgf_t WHERE gzgfstus = g_dzga_m.dzgastus AND gzgf001 = g_dzga_m.dzga001  #140612 mark AND gzgfent = g_enterprise
                        #AND gzgf004 = 'default' AND gzgf005 = 'default'  AND gzgf003 = g_code_ide          #140612 add  #140617 mark
                        #AND gzgf004 = 'default' AND gzgf005 = 'default'  AND gzgf003 = g_gzgf003          #140617 add
   ##141013 mark -(s)
##141013 add -(s)
   #先將暫存檔清空
   DELETE FROM dzga_t WHERE dzga001 = g_dzga_m.dzga001 AND dzga002 = g_dzga_m.dzga002
                        AND dzga006 = g_code_ide     
                        
   DELETE FROM dzgb_t WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
                        AND dzgb019 = g_code_ide     
                        
   DELETE FROM dzgc_t WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
                        AND dzgc009 = g_code_ide     
                        
   DELETE FROM dzgd_t WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                        AND dzgd008 = g_code_ide     
                        
   DELETE FROM dzge_t WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
                        AND dzge009 = g_code_ide       
                        
   DELETE FROM dzgf_t WHERE dzgf001 = g_dzga_m.dzga001 AND dzgf002 = g_dzga_m.dzga002
                        AND dzgf012 = g_code_ide     
                        
   DELETE FROM dzgj_t WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
                        AND dzgj008 = g_code_ide     
                        
   DELETE FROM dzgi_t WHERE dzgi001 = g_dzga_m.dzga001 AND dzgi002 = g_dzga_m.dzga002
                        AND dzgi006 = g_code_ide      
                        
   DELETE FROM dzgg_t WHERE dzgg001 = g_dzga_m.dzga001 AND dzgg002 = g_dzga_m.dzga002 AND dzgg003 = g_dzga_m.dzga001
                        AND dzgg017 = g_code_ide      
                        
   DELETE FROM dzgh_t WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002 AND dzgh003 = g_dzga_m.dzga001
                        AND  dzgh011 = g_code_ide       
                        
   DELETE FROM gzgf_t WHERE gzgfstus = g_dzga_m.dzgastus AND gzgf001 = g_dzga_m.dzga001  
                        AND gzgf004 = 'default' AND gzgf005 = 'default'  AND gzgf003 = g_gzgf003  

##141013 add -(e)
END FUNCTION 


##140430 -(s)
################################################################################
# Descriptions...: 存組合欄位資訊
# Memo...........: 
# Usage..........: CALL adzp188_handle_combine_field(l_m_field,ls_dzgb[ls_i].dzgb016,ls_dzgb[ls_i].dzgb017) 
# Input parameter: ps_mfield        主欄位
#                  ps_dzai011       參考欄位
#                  ps_dzai017       參考欄位表格別名
# Return code....: 
# Date & Author..: 2014/04/30
# Modify.........:
################################################################################
FUNCTION adzp188_handle_combine_field(ps_mfield,ps_dzai011,ps_dzgb017)
  DEFINE ps_mfield       LIKE dzgd_t.dzgd003
  DEFINE ps_dzai011      LIKE dzai_t.dzai011
  DEFINE ps_dzgb017      LIKE dzgb_t.dzgb017
  DEFINE l_gztz001       LIKE gztz_t.gztz001
  DEFINE l_cnt           LIKE type_t.num5
  DEFINE l_dzgc_seq      LIKE type_t.num5
  DEFINE l_dzgc004       LIKE dzgc_t.dzgc004
  DEFINE l_mfield_desc   LIKE gzge_t.gzge003
  DEFINE l_dzai011_desc  LIKE gzge_t.gzge003
  DEFINE l_field_desc    LIKE dzgd_t.dzgd005
  DEFINE l_field_id      LIKE dzgd_t.dzgd003
  DEFINE l_field_len     LIKE type_t.num5
  DEFINE l_mfield_len    LIKE type_t.num5
  DEFINE l_dzai011_len   LIKE type_t.num5
  DEFINE l_len           LIKE type_t.num5
  DEFINE l_dzgd004       LIKE dzgd_t.dzgd004
  DEFINE l_table         LIKE gztz_t.gztz001
  DEFINE l_m_alias       LIKE dzgc_t.dzgc007
  DEFINE l_d_alias       LIKE dzgc_t.dzgc007
  DEFINE l_dzgd006       LIKE dzgd_t.dzgd006
  DEFINE li_i            LIKE type_t.num5
  DEFINE l_field_type    LIKE dzeb_t.dzeb002
  DEFINE l_exist         LIKE type_t.num5
  

  SELECT MAX(dzgc003) + 1 INTO l_dzgc_seq FROM adzp188_dzgc_tmp
   WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
     #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add   ##141013 mark
     AND dzgc009 = g_code_ide      ##141013 add

  ##欄位說明
  #CALL sadzp188_gen4rp_get_field_label(ps_mfield) RETURNING l_mfield_desc    #141205 cynthia mark
  #CALL sadzp188_gen4rp_get_field_label(ps_dzai011) RETURNING l_dzai011_desc  #141205 cynthia mark
  CALL sadzp188_gen4rp_get_field_label(ps_mfield,g_lang,"") RETURNING l_mfield_desc     #141205 cynthia add #141215 modify,增加3rd參數
  CALL sadzp188_gen4rp_get_field_label(ps_dzai011,g_lang,"") RETURNING l_dzai011_desc   #141205 cynthia add #141215 modify,增加3rd參數
  ##組合欄位說明
  LET l_field_desc = l_mfield_desc,l_dzai011_desc
 

  ##欄位長度
  CALL adzp188_get_field_len(ps_mfield) RETURNING l_mfield_len
  CALL adzp188_get_field_len(ps_dzai011) RETURNING l_dzai011_len
  LET l_len = l_mfield_len + l_dzai011_len

  CALL adzp188_get_field_suggest_len(l_len) RETURNING l_field_type
  LET l_table = "type_t"
  LET l_dzgd004 = l_table,".",l_field_type
  SELECT dzgc007 INTO l_m_alias FROM adzp188_dzgc_tmp 
   WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
     AND dzgc004 = ps_mfield
     #AND dzgc008 = g_cust AND dzgc009 = g_code_ide #140613 add  ##141013 mark
      AND dzgc009 = g_code_ide    ##141013 add 
    

  LET l_d_alias = ps_dzgb017   
  #SELECT dzgc007 INTO l_d_alias FROM adzp188_dzgc_tmp 
   #WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
     #AND dzgc004 = ps_dzai011     
  LET l_dzgd006 = "trim(",l_m_alias CLIPPED ,".",ps_mfield ,")||'.'||trim(",l_d_alias CLIPPED,".",ps_dzai011,")"

  ##組合欄位id
  LET l_field_id = "l_",ps_mfield,"_",ps_dzai011
  LET l_exist = 0
  SELECT COUNT(*) INTO l_exist FROM adzp188_dzgd_tmp
   WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002 
     AND dzgd003 = l_field_id
     #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add   ##141013 mark
     AND dzgd008 = g_code_ide                                       ##141013 add

  IF l_exist > 0 THEN  ## 欄位名已存在
     LET l_field_id = ""
     LET l_field_id = "l_",ps_mfield,"_",l_d_alias,"_",ps_dzai011
  END IF 
  ###140506未完成

  ##141013 mark -(s)
  #INSERT INTO adzp188_dzgc_tmp
         #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002,l_dzgc_seq,l_field_id,'1','Y',l_table,g_cust,g_code_ide) # 140613 add ,g_cust,g_code_ide  
  ##141013 mark -(e)
  ##141013 add -(s)   
  LET g_sql = " INSERT INTO adzp188_dzgc_tmp ",                    
              "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?,?)" 
  PREPARE adzp188_dzgc_tmp_ins_pre2 FROM g_sql
  EXECUTE adzp188_dzgc_tmp_ins_pre2 USING l_dzgc_seq,l_field_id,'1','Y',l_table,g_cust,g_code_ide
  ##141013 add -(e)
  ##141013 mark -(s)       
  #INSERT INTO adzp188_dzgd_tmp
         #VALUES(g_dzga_m.dzga001, g_dzga_m.dzga002, l_field_id, l_dzgd004, l_field_desc, l_dzgd006,g_cust,g_code_ide) # 140613 add ,g_cust,g_code_ide
  ##141013 mark -(e)
  ##141013 add -(s)   
  LET g_sql = " INSERT INTO adzp188_dzgd_tmp ",                    
              "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?)" 
  PREPARE adzp188_dzgd_tmp_ins_pre1 FROM g_sql
  EXECUTE adzp188_dzgd_tmp_ins_pre1 USING l_field_id, l_dzgd004, l_field_desc, l_dzgd006,g_cust,g_code_ide
  ##141013 add -(e)       
END FUNCTION 
##140430 -(e)


################################################################################
# Descriptions...: 欄位長度
# Memo...........: 
# Usage..........: CALL adzp188_delete_table() 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/30
# Modify.........:
################################################################################
FUNCTION adzp188_get_field_len(ps_mfield)
  DEFINE ps_mfield       LIKE dzgd_t.dzgd003
  DEFINE l_gztd008       LIKE gztd_t.gztd008
  DEFINE l_gztd008_str   STRING 
  DEFINE l_num1          LIKE type_t.num5
  DEFINE l_num2          LIKE type_t.num5
  DEFINE l_sum           LIKE type_t.num5


  LET l_gztd008 = ""
  LET l_gztd008_str = ""
  LET l_num1 = 0
  LET l_num2 = 0
  SELECT gztd008 INTO l_gztd008 FROM gztd_t 
   LEFT JOIN dzeb_t ON dzeb006 = gztd001
   WHERE dzeb002 = ps_mfield
   
   LET l_gztd008_str = l_gztd008
   IF l_gztd008_str.getIndexOf(",",1)>0 THEN
      ##140516，數字格式定義(20,6)，取20為長度
      LET l_num1 = l_gztd008_str.subString(1, l_gztd008_str.getIndexOf(",",1)-1)
      #LET l_num2 = l_gztd008_str.subString(l_gztd008_str.getIndexOf(",",1)+1,l_gztd008_str.getLength())
      #LET l_sum = l_num1 + l_num2
      LET l_gztd008 = l_num1
   END IF 
   RETURN  l_gztd008
  
END FUNCTION 

################################################################################
# Descriptions...: 建議自訂欄位長度
# Memo...........: 
# Usage..........: CALL adzp188_delete_table() 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/30
# Modify.........:
################################################################################
FUNCTION adzp188_get_field_suggest_len(ps_mfield)
  DEFINE ps_mfield       LIKE dzgd_t.dzgd003
  DEFINE l_gztz001       LIKE gztz_t.gztz001
  DEFINE l_cnt           LIKE type_t.num5
  DEFINE l_dzeb          DYNAMIC ARRAY OF RECORD 
         dzeb002         LIKE dzeb_t.dzeb002,
         dzeb008         LIKE type_t.num5
         END RECORD
  DEFINE l_dzeb002_r     LIKE dzeb_t.dzeb002
  DEFINE li_i            LIKE type_t.num5
  DEFINE li_j            LIKE type_t.num5
  DEFINE l_dzeb002       LIKE dzeb_t.dzeb002
  DEFINE l_dzeb008       LIKE type_t.num5


  CALL l_dzeb.clear()
  LET li_i = 1
  LET g_sql = " SELECT dzeb002,dzeb008 FROM dzeb_t ",
              " WHERE dzeb001 ='type_t' AND dzeb007 ='varchar2' AND dzeb008 <>'row_id'",
              " ORDER BY dzeb008 "
  PREPARE adzp188_get_dzeb002_pre FROM g_sql
  DECLARE adzp188_get_dzeb002_cs CURSOR FOR adzp188_get_dzeb002_pre
  FOREACH adzp188_get_dzeb002_cs INTO l_dzeb[li_i].*
     LET li_i = li_i + 1
  END FOREACH 
  CALL l_dzeb.deleteElement(li_i)
  ###由小至大排序
  FOR li_i = l_dzeb.getLength() TO 2 STEP -1
    FOR li_j = 1 TO li_i -1
      IF l_dzeb[li_j].dzeb008 > l_dzeb[li_j+1].dzeb008 THEN
         LET l_dzeb002 = l_dzeb[li_j].dzeb002
         LET l_dzeb008 = l_dzeb[li_j].dzeb008
         LET l_dzeb[li_j].dzeb002 = l_dzeb[li_j+1].dzeb002
         LET l_dzeb[li_j].dzeb008 = l_dzeb[li_j+1].dzeb008
         LET l_dzeb[li_j+1].dzeb002 = l_dzeb002 
         LET l_dzeb[li_j+1].dzeb008 = l_dzeb008       
      END IF
    END FOR 
  END FOR 
  LET l_dzeb002_r = ""
  FOR li_i = 1 TO l_dzeb.getLength()
      IF l_dzeb[li_i].dzeb008 > ps_mfield THEN
         LET l_dzeb002_r = l_dzeb[li_i].dzeb002
         EXIT FOR 
      END IF  
  END FOR 
 
   RETURN  l_dzeb002_r
  
END FUNCTION 


################################################################################
# Descriptions...: 抓取自訂欄位資料
# Memo...........: 
# Usage..........: CALL adzp188_get_dzgd_data(g_fieldsel[pi_idx].dzgc004) 
# Input parameter: ps_dzgc004            欄位變數
# Return code....:   l_dzgd005           欄位說明
#                    l_dzgd004_1         參考表格
#                    l_dzgd004_2         參考型態
# Date & Author..: 2014/05/08
# Modify.........:
################################################################################
FUNCTION adzp188_get_dzgd_data(ps_dzgc004)
  DEFINE ps_dzgc004      LIKE dzgc_t.dzgc004
  DEFINE l_dzgd005       LIKE dzgd_t.dzgd005
  DEFINE l_dzgd004_1     LIKE dzea_t.dzea001
  DEFINE l_dzgd004_2     LIKE dzeb_t.dzeb002
  DEFINE l_dzgd004       LIKE dzgd_t.dzgd004  
  DEFINE ls_dzgd004      STRING
  DEFINE l_dzgd006       LIKE dzgd_t.dzgd006   ##150211 add 
  
  
   LET l_dzgd005 = ""
   LET l_dzgd004_1 = ""
   LET l_dzgd004_2 = ""
   LET l_dzgd004 = ""
   LET ls_dzgd004 = ""
   LET l_dzgd006 = "" ##150211 add
   SELECT dzgd004,dzgd005,dzgd006 INTO l_dzgd004,l_dzgd005,l_dzgd006 FROM adzp188_dzgd_tmp   ##150211 add
   #SELECT dzgd004,dzgd005 INTO l_dzgd004,l_dzgd005 FROM adzp188_dzgd_tmp  ##150211 mark
    WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
      AND dzgd003 = ps_dzgc004
      #AND dzgd007 = g_cust AND dzgd008 = g_code_ide #140613 add   ##141013 mark
      AND dzgd008 = g_code_ide #141013 add
    
   LET ls_dzgd004 = l_dzgd004
   LET l_dzgd004_1 = ls_dzgd004.subString(1,ls_dzgd004.getIndexOf(".",1)-1)
   LET l_dzgd004_2 = ls_dzgd004.subString(ls_dzgd004.getIndexOf(".",1)+1,ls_dzgd004.getLength()) 


   #DISPLAY "l_dzgd005,l_dzgd004_1,l_dzgd004_2:",l_dzgd005,l_dzgd004_1,l_dzgd004_2
   #RETURN l_dzgd005,l_dzgd004_1,l_dzgd004_2           ##150211 mark
   RETURN l_dzgd005,l_dzgd004_1,l_dzgd004_2,l_dzgd006  ##150211 add

END FUNCTION          


    
################################################################################
# Descriptions...: 篩選頁簽-維護dzgf_t及更新wc組合字串
# Memo...........: 
# Usage..........: CALL adzp188_maintain_xgtype(DIALOG.getCurrentRow("s_tablecol"),"s", "del")
# Input parameter: pi_idx     指定序號
# ...............: pi_src_idx 類型 c:col，r:row，s:sum
# ...............: ps_type    add新增, upd修改或del刪除
# Return code....: None
# Date & Author..: 2014/05/19
# Modify.........:
################################################################################
FUNCTION adzp188_maintain_xgtype(pi_idx,ps_src_type, ps_type)
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE ps_src_type  LIKE type_t.chr1
   DEFINE ps_type      STRING
   DEFINE lc_field     LIKE dzgc_t.dzgc004  
   DEFINE lc_fieldseq  LIKE type_t.num5
   DEFINE lc_type      LIKE type_t.chr1
   DEFINE lc_alias2    LIKE dzgh_t.dzgh009  
   DEFINE li_i         LIKE type_t.num5  
   DEFINE li_max       LIKE type_t.num5
   

   CASE ps_type
      WHEN "add"  
         ##141013 add -(s)   
         LET g_sql = " INSERT INTO adzp188_xgtype_tmp ",                    
                     "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?)" 
         PREPARE adzp188_xgtype_tmp_ins_pre FROM g_sql
         ##141013 add -(e)


      
         SELECT MAX(fieldseq) + 1 INTO li_max FROM adzp188_xgtype_tmp
          WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
            AND type = ps_src_type
            #AND cust = g_cust AND ide = g_code_ide   #140613add   ##141013 mark
            AND ide = g_code_ide                      ##141013 add
              
         IF cl_null(li_max) OR li_max = 0 THEN
            LET li_max = 1
         END IF
             
             ##由s_xgtypelist1新增進入, 可能為多選新增
             FOR pi_idx = 1 TO g_xgtypelist1.getLength()
                 IF gdig_curr.isRowSelected("s_xgtypelist1", pi_idx) THEN
                    ##如果是點在table節點上, 批次新增所有欄位
                    IF g_xgtypelist1[pi_idx].xgtypeisnode1 THEN
                       ###因為只有兩階的樹狀, 可以直接將往下的欄位加進來, 直到碰到下一個isnode
                       FOR li_i = pi_idx + 1 TO g_xgtypelist1.getLength()
                           IF NOT g_xgtypelist1[li_i].xgtypeisnode1 THEN
                             LET lc_field = g_xgtypelist1[li_i].xgtypeid1
                             LET lc_fieldseq = li_max
                             LET lc_type = ps_src_type
                             LET lc_alias2 = g_xgtypelist1[li_i].xgtypealias1 
                            
                             IF adzp188_check_povit_repeat(ps_src_type,lc_field) THEN 
                                 ##141013 mark -(s)  
                                 #INSERT INTO adzp188_xgtype_tmp         
                                     #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,lc_type,lc_field,lc_fieldseq,lc_alias2,g_cust,g_code_ide) #140613 add,g_cust,g_code_ide
                                 ##141013 mark -(e)   
                                 EXECUTE adzp188_xgtype_tmp_ins_pre USING lc_type,lc_field,lc_fieldseq,lc_alias2,g_cust,g_code_ide    ##141013 add
                                     LET li_max = li_max + 1 
                             END IF     
                           ELSE
                              EXIT FOR
                           END IF
                       END FOR
                    ELSE
                         LET lc_field = g_xgtypelist1[pi_idx].xgtypeid1                         
                         LET lc_fieldseq = li_max
                         LET lc_type = ps_src_type
                         LET lc_alias2 = g_xgtypelist1[pi_idx].xgtypealias1   
                         IF adzp188_check_povit_repeat(ps_src_type,lc_field) THEN 
                             ##141013 mark -(s)  
                             #INSERT INTO adzp188_xgtype_tmp         
                             #VALUES (g_dzga_m.dzga001,g_dzga_m.dzga002,lc_type,lc_field,lc_fieldseq,lc_alias2,g_cust,g_code_ide) #140613 add,g_cust,g_code_ide
                             ##141013 mark -(e)
                             EXECUTE adzp188_xgtype_tmp_ins_pre USING lc_type,lc_field,lc_fieldseq,lc_alias2,g_cust,g_code_ide    ##141013 add  
                             LET li_max = li_max + 1 

                         END IF 
                    END IF
                 END IF
             END FOR


      WHEN "upd"

         
      WHEN "del"
         
         LET g_sql = " DELETE FROM adzp188_xgtype_tmp ",
                     ##141013 mark -(s)
                     #" WHERE dzgh001 = '", g_dzga_m.dzga001,"' AND dzgh002 = '",g_dzga_m.dzga002,"'",
                     #" AND type = ? and field = ? and fieldseq =? and alias =?",  ##140606 add and alias =?
                     #" AND cust = ? AND ide =?"  #140613 add
                     ##141013 mark -(e)
                     ##141013 add -(s)
                     " WHERE dzgh001 = '", g_dzga_m.dzga001,"' AND dzgh002 = '",gs_ver,"'",
                     " AND type = ? and field = ? and fieldseq =? and alias =? ",  
                     " AND ide =?"  
                     ##141013 add -(e)                     
         PREPARE del_xgtype_pre FROM g_sql 
         CASE ps_src_type
            ##141013 mark -(s)
            #WHEN "c" 
                  #EXECUTE del_xgtype_pre USING ps_src_type, g_tablecol[pi_idx].id,g_tablecol[pi_idx].seq,g_tablecol[pi_idx].alias,g_cust,g_code_ide  #140606 add g_tablecol[pi_idx].alias  #140613 add ,g_cust,g_code_ide
            #WHEN "r"  
                  #EXECUTE del_xgtype_pre USING ps_src_type, g_tablerow[pi_idx].id,g_tablerow[pi_idx].seq,g_tablerow[pi_idx].alias,g_cust,g_code_ide  #140606 add g_tablerow[pi_idx].alias  #140613 add ,g_cust,g_code_ide
            #WHEN "s"  
                  #EXECUTE del_xgtype_pre USING ps_src_type, g_tablesum[pi_idx].id,g_tablesum[pi_idx].seq,g_tablesum[pi_idx].alias,g_cust,g_code_ide  #140606 add g_tablesum[pi_idx].alias  #140613 add ,g_cust,g_code_ide
            ##141013 mark -(e)
            ##141013 add -(s)
            WHEN "c" 
                  EXECUTE del_xgtype_pre USING ps_src_type, g_tablecol[pi_idx].id,g_tablecol[pi_idx].seq,g_tablecol[pi_idx].alias,g_code_ide  
            WHEN "r"  
                  EXECUTE del_xgtype_pre USING ps_src_type, g_tablerow[pi_idx].id,g_tablerow[pi_idx].seq,g_tablerow[pi_idx].alias,g_code_ide  
            WHEN "s"  
                  EXECUTE del_xgtype_pre USING ps_src_type, g_tablesum[pi_idx].id,g_tablesum[pi_idx].seq,g_tablesum[pi_idx].alias,g_code_ide 
            ##141013 add -(e)      
         END CASE 
   END CASE

   
   CALL adzp188_xgtype_b_fill()

END FUNCTION


################################################################################
# Descriptions...: XG排版頁簽-檢查挑選的欄位是否有重覆, 重覆就不進"交表表"
# Memo...........: 
# Usage..........: CALL adzp188_check_povit_repeat("s",DIALOG.getCurrentRow()) RETURNING li_result
# Input parameter: pi_idx      s_tablelist上focus的行數
# Return code....: TRUE/FALSE  是否重覆
# Date & Author..: 2014/05/19
# Modify.........:
################################################################################
FUNCTION adzp188_check_povit_repeat(ps_type,ps_field)
   DEFINE ps_type    LIKE type_t.chr1
   DEFINE ps_field   LIKE dzgc_t.dzgc004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE li_repeat  LIKE type_t.num5


   LET li_repeat = FALSE  
   SELECT COUNT(field) INTO l_cnt FROM adzp188_xgtype_tmp
    WHERE dzgh001 = g_dzga_m.dzga001 AND dzgh002 = g_dzga_m.dzga002
      AND type = ps_type AND field = ps_field  
      #AND cust = g_cust AND ide = g_code_ide #140613 add  ##141013 mark
       AND ide = g_code_ide                                ##141013 add 
    
    IF l_cnt = 0 THEN 
       LET li_repeat = TRUE  
    END IF 

   RETURN li_repeat

END FUNCTION

##140519 xg排版左-樹狀  -(s)
################################################################################
# Descriptions...: GR排版頁簽-樹狀欄位列表(gr_grouplist1'gr_grouplist2)
# Memo...........: 
# Usage..........: CALL adzp188_gr_grouplist_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/23
# Modify.........:
################################################################################
FUNCTION adzp188_xgtypelist1_b_fill()
   DEFINE li_i     LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   DEFINE ls_i     LIKE type_t.num5
   DEFINE lc_tablename LIKE dzeal_t.dzeal003
   DEFINE l_def_cnt    LIKE type_t.num5
   DEFINE ls_dzgb017 DYNAMIC ARRAY OF VARCHAR(15)   #140327

   
   CALL g_xgtypelist1.clear()
   CALL ls_dzgb017.clear()    #140327

   ##抓取別名
   LET g_sql = " SELECT dzgb017 FROM adzp188_dzgb_tmp ", 
               "  WHERE dzgb001 = ? AND dzgb002 = ?", 
               "    AND dzgb014 = ? ",
               #"    AND dzgb018 = ? AND dzgb019 = ? "  #140613 add  ##141013 mark
               "    AND dzgb019 = ? "  #141013 add
               
   PREPARE adzp188_get_dzgb017_xg_pre FROM g_sql               
   DECLARE adzp188_get_dzgb017_xg_cs CURSOR FOR adzp188_get_dzgb017_xg_pre      

   LET li_cnt = 1
   FOR li_i = 1 TO g_tablesel.getLength()     
       SELECT dzeal003 INTO lc_tablename FROM dzeal_t 
        WHERE dzeal001 = g_tablesel[li_i].id AND dzeal002 = g_lang 
       ##GR排版頁籤左邊的樹也是相同來源 
       LET g_xgtypelist1[li_cnt].xgtypename1 = g_tablesel[li_i].id,":", lc_tablename
       LET g_xgtypelist1[li_cnt].xgtypeid1 = g_tablesel[li_i].id
       #LET g_xgtypelist1[li_cnt].xgtypeexp1 = TRUE   #預設全開  #150525-00029#1 mark
       LET g_xgtypelist1[li_cnt].xgtypeexp1 = FALSE  #改不展開   #150525-00029#1 add
       LET g_xgtypelist1[li_cnt].xgtypeisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線          
       
       CALL adzp188_xgtypelist1_b_fill_child(g_tablesel[li_i].id,'', li_cnt,'N') RETURNING li_cnt

      ##140327 增加別名到可選擇清單 -(s)
       LET ls_i = 1       
       #FOREACH  adzp188_get_dzgb017_xg_cs USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id INTO ls_dzgb017[ls_i] #140613 mark 
       #FOREACH  adzp188_get_dzgb017_xg_cs USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id,g_cust,g_code_ide INTO ls_dzgb017[ls_i]  #140613 add  ##141013 mark
       FOREACH  adzp188_get_dzgb017_xg_cs USING g_dzga_m.dzga001,g_dzga_m.dzga002,g_tablesel[li_i].id,g_code_ide INTO ls_dzgb017[ls_i]  #141013 add
          IF NOT cl_null(ls_dzgb017[ls_i]) AND ls_dzgb017[ls_i] <> g_tablesel[li_i].id THEN          
             LET g_xgtypelist1[li_cnt].xgtypename1 = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],"):", g_tablesel[li_i].name
             LET g_xgtypelist1[li_cnt].xgtypeid1 = g_tablesel[li_i].id,"(",ls_dzgb017[ls_i],")"
             LET g_xgtypelist1[li_cnt].xgtypeexp1 = TRUE   #預設全開
             LET g_xgtypelist1[li_cnt].xgtypeisnode1 = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線         
             CALL adzp188_xgtypelist1_b_fill_child(g_tablesel[li_i].id, ls_dzgb017[ls_i],li_cnt,'N') RETURNING li_cnt            
             LET ls_i = ls_i + 1
          END IF 
       END FOREACH 
       ##140327 增加別名到可選擇清單 -(e)
       
   END FOR

   #判斷是否有自定義欄位
   SELECT COUNT(*) INTO l_def_cnt FROM adzp188_dzgc_tmp  
    WHERE dzgc001 = g_dzga_m.dzga001 AND dzgc002 = g_dzga_m.dzga002
      AND dzgc006 ='Y' 
      #AND dzgc008 = g_cust AND dzgc009 = g_code_ide # 140613 add   ##141013 mark
      AND dzgc009 = g_code_ide      ##141013 add
 
   IF l_def_cnt > 0 THEN
       LET g_xgtypelist1[li_cnt].xgtypename1 = "自定義" ,":", "自定義欄位" 
       LET g_xgtypelist1[li_cnt].xgtypeid1 = "自定義"
       #LET g_xgtypelist1[li_cnt].xgtypeexp1 = TRUE   #預設全開   #150525-00029#1 mark
       LET g_xgtypelist1[li_cnt].xgtypeexp1 = FALSE   #改不展開    #150525-00029#1 add
       LET g_xgtypelist1[li_cnt].xgtypeisnode1  = TRUE   #一定有欄位吧! 用isnode的值當作進"已選擇欄位列表"的防線

       CALL adzp188_xgtypelist1_b_fill_child("自定義",'', li_cnt,'Y') RETURNING li_cnt       
   END IF    

END FUNCTION


################################################################################
# Descriptions...: xg排版頁簽-樹狀欄位列表(子節點)
# Memo...........: 
# Usage..........: CALL adzp188_xgtypelist1_b_fill_child(table_id, sn,p_def) RETURNING li_idx
# Input parameter: pc_dzea001   資料表
# ...............: pi_idx       最後節點位置
# Return code....: p_def        接下來的節點位置
# Date & Author..: 2014/05/19
# Modify.........:
################################################################################
FUNCTION adzp188_xgtypelist1_b_fill_child(pc_dzea001, pc_dzgb017,pi_idx,p_def)
   DEFINE pc_dzea001   LIKE dzea_t.dzea001
   DEFINE pc_dzgb017   LIKE dzgb_t.dzgb017
   DEFINE pi_idx       LIKE type_t.num5
   DEFINE p_def        LIKE dzgc_t.dzgc006
   DEFINE lc_dzgc007   LIKE dzgc_t.dzgc007
   DEFINE lc_dzgc004   LIKE dzgc_t.dzgc004
   DEFINE lc_dzebl003  LIKE dzebl_t.dzebl003
   DEFINE lc_prefix    STRING 

   
   IF p_def = "N" THEN ##非自定義欄位 
       LET lc_prefix = pc_dzea001
       LET lc_prefix = lc_prefix.subString(1,lc_prefix.getIndexOf("_",1)-1) 
       IF cl_null(pc_dzgb017) THEN 
           LET g_sql = " SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp ",  ##140327add dzgc007
                       "        LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                       " WHERE dzgc004 LIKE '",lc_prefix.trim(),"%'", " AND dzgc006 ='",p_def,"'",
                       #"   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",   #140923 elena mark
                       "   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",              #140923 elena add
                       "   AND dzgc007 ='",pc_dzea001,"'",
                       #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",   #140613 add  #141013 mark
                       "  AND dzgc009 ='",g_code_ide,"'",   #141013 add
                       " ORDER BY dzgc003 "
       ELSE 
           LET g_sql = " SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp ",  ##140327add dzgc007
                       "        LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                       " WHERE dzgc004 LIKE '",lc_prefix.trim(),"%'", " AND dzgc006 ='",p_def,"'",
                       #"   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", g_dzga_m.dzga002,"'",   #140923 elena mark
                       "   AND dzgc001 = '", g_dzga_m.dzga001,"' AND dzgc002 = '", gs_ver,"'",              #140923 elena add
                       "   AND dzgc007 ='",pc_dzgb017,"'",
                       #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",   #140613 add  #141013 mark
                       "  AND dzgc009 ='",g_code_ide,"'",   #141013 add
                       " ORDER BY dzgc003 "       
       END IF 
                   
       PREPARE xgtypelist_b_fill_pre FROM g_sql
       DECLARE xgtypelist_b_fill_curs CURSOR FOR xgtypelist_b_fill_pre
       
       LET pi_idx = pi_idx + 1
       FOREACH xgtypelist_b_fill_curs INTO lc_dzgc004, lc_dzebl003, lc_dzgc007
          LET g_xgtypelist1[pi_idx].xgtypename1 = lc_dzgc004,":", lc_dzebl003
          LET g_xgtypelist1[pi_idx].xgtypeid1 = lc_dzgc004
          IF cl_null(pc_dzgb017) THEN 
             LET g_xgtypelist1[pi_idx].xgtypepid1 = pc_dzea001
          ELSE 
             LET g_xgtypelist1[pi_idx].xgtypepid1 = pc_dzea001,"(",pc_dzgb017,")"
          END IF 
          LET g_xgtypelist1[pi_idx].xgtypeexp1 = FALSE
          LET g_xgtypelist1[pi_idx].xgtypeisnode1 = FALSE      
          LET g_xgtypelist1[pi_idx].xgtypealias1 = lc_dzgc007  ##140327add dzgc007
          LET pi_idx = pi_idx + 1
       END FOREACH
   ELSE 

       LET g_sql = "SELECT dzgc004, dzebl003,dzgc007 FROM adzp188_dzgc_tmp",
                   " LEFT OUTER JOIN dzebl_t ON dzebl001 = dzgc004 AND dzebl002 = '",g_lang,"'",
                   #" WHERE dzgc001 ='",g_dzga_m.dzga001,"' AND dzgc002 ='",g_dzga_m.dzga002,"'",   #140923 elena mark
                   " WHERE dzgc001 ='",g_dzga_m.dzga001,"' AND dzgc002 ='",gs_ver,"'",              #140923 elena add
                   "   AND dzgc006 ='",p_def,"'",
                   #"   AND dzgc008 ='",g_cust,"' AND dzgc009 ='",g_code_ide,"'",   #140613 add  #141013 mark
                   "   AND dzgc009 ='",g_code_ide,"'",   #141013 add
                   " ORDER BY dzgc003"
       PREPARE xgtypelist_b_fill_pre1 FROM g_sql
       DECLARE xgtypelist_b_fill_curs1 CURSOR FOR xgtypelist_b_fill_pre1  
       LET pi_idx = pi_idx + 1 
       FOREACH xgtypelist_b_fill_curs1 INTO lc_dzgc004, lc_dzebl003,lc_dzgc007##140327add dzgc007
          ##若欄位說明null，代表是自定義欄位
          IF cl_null(lc_dzebl003) THEN 
             SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
              WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002
                AND dzgd003 = lc_dzgc004
                #AND dzgd007 = g_cust AND dzgd008 = g_code_ide    #140613 add  ##141013 mark
                 AND dzgd008 = g_code_ide    ##141013 add 
             
          END IF 
          LET g_xgtypelist1[pi_idx].xgtypename1 = lc_dzgc004,":", lc_dzebl003
          LET g_xgtypelist1[pi_idx].xgtypeid1 = lc_dzgc004
          LET g_xgtypelist1[pi_idx].xgtypepid1 = pc_dzea001
          LET g_xgtypelist1[pi_idx].xgtypeexp1 = FALSE
          LET g_xgtypelist1[pi_idx].xgtypeisnode1 = FALSE     
          LET g_xgtypelist1[pi_idx].xgtypealias1 = lc_dzgc007  ##140327add dzgc007
          LET pi_idx = pi_idx + 1
       END FOREACH  
       
   END IF 
   RETURN pi_idx
END FUNCTION
##140519 xg排版左-樹狀  -(e)


##140520 XG排版右-交叉表-(s)
################################################################################
# Descriptions...: xg排版頁簽-已挑選交叉表欄位列表
# Memo...........: 
# Usage..........: CALL adzp188_xgtype_b_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/05/20
# Modify.........:
################################################################################
FUNCTION adzp188_xgtype_b_fill()
   DEFINE l_type         LIKE type_t.chr1
   DEFINE l_type_t       LIKE type_t.chr1
   DEFINE l_field        LIKE type_t.chr80
   DEFINE l_seq          LIKE type_t.num5
   DEFINE lc_dzebl003    LIKE dzebl_t.dzebl003
   DEFINE li_i           LIKE type_t.num5
   DEFINE l_alias        LIKE dzgc_t.dzgc007      ##140606 add
   

   CALL g_tablerow.clear()
   CALL g_tablecol.clear()
   CALL g_tablesum.clear()

   LET l_type_t =" "
   LET g_sql = " SELECT field,type,fieldseq,dzebl003,alias FROM adzp188_xgtype_tmp ",  ##140606 add alias
               "   LEFT JOIN dzebl_t ON dzebl001 = field AND dzebl002 = '",g_lang,"'",
               #" WHERE dzgh001 = '",g_dzga_m.dzga001,"' AND dzgh002 = '",g_dzga_m.dzga002,"'",  #140923 elena mark
               " WHERE dzgh001 = '",g_dzga_m.dzga001,"' AND dzgh002 = '",gs_ver,"'",             #140923 elena add
               #"   AND cust ='",g_cust,"' AND ide ='",g_code_ide,"'",  #140613 add  #141013 mark
               "   AND ide ='",g_code_ide,"'",  #141013 add
               " ORDER BY type,fieldseq "                
   LET li_i = 1
   PREPARE adzp188_xgtype_b_fill_pre FROM g_sql
   DECLARE adzp188_xgtype_b_fill_cs CURSOR FOR adzp188_xgtype_b_fill_pre
   FOREACH adzp188_xgtype_b_fill_cs INTO l_field,l_type,l_seq,lc_dzebl003,l_alias   ##140606 add l_alias
      #140703 add -(S)
      ##若欄位說明null，代表是自定義欄位
      IF cl_null(lc_dzebl003) THEN 
         SELECT dzgd005 INTO lc_dzebl003 FROM adzp188_dzgd_tmp
         # WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002  #141013 mark
          WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002   #141013 adds
            AND dzgd003 = l_field AND dzgd008 = g_code_ide
      END IF 
      #140703 add -(e)
      IF l_type <> l_type_t THEN
         LET l_type_t = l_type
         LET li_i = 1
      END IF 
      CASE l_type
        WHEN "r"
        
              LET g_tablerow[li_i].id = l_field
              LET g_tablerow[li_i].name = l_field,":",lc_dzebl003
              LET g_tablerow[li_i].seq = l_seq
              LET g_tablerow[li_i].alias = l_alias   ##140606 add
              
        WHEN "c"  
              LET g_tablecol[li_i].id = l_field
              LET g_tablecol[li_i].name = l_field,":",lc_dzebl003
              LET g_tablecol[li_i].seq = l_seq
              LET g_tablecol[li_i].alias = l_alias   ##140606 add
              
        WHEN "s"
              LET g_tablesum[li_i].id = l_field
              LET g_tablesum[li_i].name = l_field,":",lc_dzebl003
              LET g_tablesum[li_i].seq = l_seq
              LET g_tablesum[li_i].alias = l_alias   ##140606 add
              
       END CASE 
       LET li_i = li_i + 1
   END FOREACH 
   

END FUNCTION
##140520 XG排版右-交叉表-(e)

##140521 -(s)
################################################################################
# Descriptions...: XG排版頁簽-已挑選欄位交叉表預設資料
# Memo...........: 
# Usage..........: CALL adzp188_xg_type_default()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/05/21
# Modify.........:
################################################################################
FUNCTION adzp188_xg_type_default()
   DEFINE lc_cnt         LIKE type_t.num5   
   DEFINE li_i           LIKE type_t.num5  
   DEFINE l_key1         LIKE type_t.chr20
   DEFINE l_seq          LIKE type_t.num5
   DEFINE l_type         LIKE type_t.chr1
   #DEFINE l_gzgg001      LIKE gzgg_t.gzgg001  #140606 mark
   DEFINE l_dzgl026      LIKE dzgl_t.dzgl026   #140606 add
   DEFINE l_alias        LIKE dzgc_t.dzgc007   #140606 add

   ##141126 add-(s)
   LET g_sql = " INSERT INTO adzp188_xgtype_tmp ",                    
               "VALUES('",g_dzga_m.dzga001,"','", gs_ver,"',?,?,?,?,?,?)" 
   PREPARE adzp188_xgtype_tmp_ins_pre1 FROM g_sql
   ##141126 add-(e)
   FOR li_i = 1 TO 3
       CASE li_i
          WHEN 1
              #LET l_key1 = "gzgg014"   #140606 mark
              LET l_key1 = "dzgl017"    #140606 add
              LET l_type = "r"
          WHEN 2
              #LET l_key1 = "gzgg015"   #140606 mark
              LET l_key1 = "dzgl016"    #140606 add
              LET l_type = "c"
          WHEN 3
              #LET l_key1 = "gzgg016"   #140606 mark 
              LET l_key1 = "dzgl018"    #140606 add
              LET l_type = "s"   
       END CASE 
       ##140606 改用dzgl_t  mark -(s)
       #LET g_sql = " SELECT gzgg001,",l_key1," FROM gzgg_t ",
                   #" WHERE gzgg000 = '",g_gzgf000,"' AND ",l_key1," IS NOT NULL",
                   #" ORDER BY ",l_key1
       ##140606 改用dzgl_t  mark -(e)
       ##140606 改用dzgl_t  add -(s)
       LET g_sql = " SELECT dzgl005,",l_key1," ,dzgl027 FROM dzgl_t ",
                   #" WHERE dzgl001 = '",g_dzga_m.dzga001,"' AND dzgl002 = '",g_dzga_m.dzga002 ,"'",  #141013 mark
                   " WHERE dzgl001 = '",g_dzga_m.dzga001,"' AND dzgl002 = '",gs_ver ,"'",             #141013 add
                   "   AND dzgl003 = '",g_dzga_m.dzga001 ,"' AND ",l_key1," IS NOT NULL",
                   #"   AND dzgl029 = '",g_cust,"' AND dzgl030 = '",g_code_ide ,"'",   #140613 add  #141013 mark
                   "   AND dzgl030 = '",g_code_ide ,"'",                               #141013 add
                   " ORDER BY ",l_key1                   
       ##140606 改用dzgl_t  add -(e)            
       PREPARE adzp188_get_gzgg001_pre FROM g_sql
       DECLARE adzp188_get_gzgg001_cs CURSOR FOR adzp188_get_gzgg001_pre
       FOREACH adzp188_get_gzgg001_cs INTO l_dzgl026,l_seq,l_alias
           ##141013 add -(s) 
           #INSERT INTO adzp188_xgtype_tmp 
            #VALUES(g_dzga_m.dzga001,g_dzga_m.dzga002,l_type,l_dzgl026,l_seq,l_alias,g_cust,g_code_ide)  #140613 add ,g_cust,g_code_ide
           ##141013 add -(e) 
         ##141013 add -(s)   

         EXECUTE adzp188_xgtype_tmp_ins_pre1 USING l_type,l_dzgl026,l_seq,l_alias,g_cust,g_code_ide
         ##141013 add -(e)            
            
       END FOREACH 
   END FOR 
END FUNCTION
##140521 -(s)



##140605 -(s)
################################################################################
# Descriptions...: 將dzgl_t資料存入gzgg_t
# Memo...........: 
# Usage..........: CALL adzp188_insert_gzgg_data(p_gzgf000)
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/06/06
# Modify.........:
################################################################################
FUNCTION adzp188_insert_gzgg_data(p_gzgf000)
  DEFINE p_gzgf000       LIKE gzgf_t.gzgf000   
  #140612 mark -(s)
  #DEFINE l_dzgl    DYNAMIC ARRAY OF RECORD 
         #dzgl005         LIKE dzgl_t.dzgl005,  ##欄位
         #dzgl027         LIKE dzgl_t.dzgl027,   ##資料表別名
         #dzgl028         LIKE dzgl_t.dzgl028    ##欄位別名
         #END RECORD 
  #140612 mark -(s)       
  DEFINE l_i             LIKE type_t.num5
  DEFINE l_lang_cnt      LIKE type_t.num5            ##140605 add
  DEFINE l_gzgdl001      DYNAMIC ARRAY OF VARCHAR(6)       ##140605 add
  DEFINE l_gzgg026       LIKE gzgg_t.gzgg026         #140606 add
  DEFINE l_dzgd005       LIKE dzgd_t.dzgd005         #140610 add 
  DEFINE l_cnt           LIKE type_t.num5            #140610 add
  DEFINE l_current        LIKE gzgf_t.gzgfmoddt  ##140527 add
  DEFINE l_dzgl       DYNAMIC ARRAY OF RECORD LIKE dzgl_t.* #報表元件設計-樣板明細檔(XG)   #140612 add
  DEFINE l_gzgg       DYNAMIC ARRAY OF RECORD LIKE gzgg_t.* #報表元件設計-樣板明細檔(XG)   #141127 add
  DEFINE l_gzgf000    DYNAMIC ARRAY OF VARCHAR(80)          #報表樣板ID                 #141127 add
  DEFINE l_k              LIKE type_t.num5                  #141127 add
  DEFINE l_dzebl003       LIKE dzebl_t.dzebl003             #141127 add

   ##多語言
   DECLARE gzgdl000 SCROLL CURSOR FOR
           SELECT gzzy001 FROM gzzy_t   ##150617-00018 add
         #SELECT gzgdl001 FROM gzgdl_t WHERE gzgdl000='default'  #150617-00018 mark
   LET l_lang_cnt = 1
   CALL l_gzgdl001.clear()
   ##140728 add -(S)
   FOREACH gzgdl000 INTO l_gzgdl001[l_lang_cnt]
     LET l_lang_cnt = l_lang_cnt + 1
   END FOREACH
   CALL l_gzgdl001.deleteElement(l_lang_cnt)
    ##140728 add -(e)
   #140612 add -(S)
   #IF l_gzgdl001.getLength() = 0 THEN
      #LET l_gzgdl001[1] = g_lang 
   #END IF
  #140612 add -(e) 
   ##141127 add -(s)
    ##先抓出同報表元件的所有gzgf000
    LET l_k = 1
    CALL l_gzgf000.clear()
    DECLARE adzp188_get_gzgf_data_cs CURSOR FOR       
    SELECT gzgf000 FROM gzgf_t                         
     WHERE gzgf001 = g_dzga_m.dzga001 
       AND gzgf003 = g_code_ide   ###150507-00002 add
   FOREACH adzp188_get_gzgf_data_cs INTO l_gzgf000[l_k]
     LET l_k = l_k + 1
   END FOREACH
   CALL l_gzgf000.deleteElement(l_k)     
   ##141127 add -(e)

    DECLARE sadzp188_get_dzgl_data_cs CURSOR FOR       
    #SELECT dzgl005,dzgl027,dzgl028 FROM dzgl_t  #140618 mark
    SELECT * FROM dzgl_t                         #140618 add
     WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002
       AND dzgl003 = g_dzga_m.dzga001
       #AND dzgl029 = g_cust AND dzgl030 = g_code_ide #140613 add  ##141013 mark 
       AND dzgl030 = g_code_ide            ##141013 add
     ##141127 add -(s)   
     LET l_i = 1 
     CALL l_dzgl.clear()  
     FOREACH sadzp188_get_dzgl_data_cs INTO l_dzgl[l_i].*
            LET l_i = l_i + 1
     END FOREACH
     CALL l_dzgl.deleteElement(l_i)
     ##141127 add -(e)
        

    FOR l_k = 1 TO l_gzgf000.getLength()    
        #141127 mark -(s)
        #LET l_i = 1   
        #FOREACH sadzp188_get_dzgl_data_cs INTO l_dzgl[l_i].*
        #141127 mark -(e)
        FOR l_i = 1 TO l_dzgl.getLength()
          FOR l_lang_cnt = 1 TO l_gzgdl001.getLength() 
              
              ##140612 add -(s)
              ##目前只存繁中與簡中
              #IF l_gzgdl001[l_lang_cnt] ="zh_TW" OR l_gzgdl001[l_lang_cnt] ="zh_CN" THEN  #140728 add #160330-00019#3 mark
              #IF l_gzgdl001[l_lang_cnt] IS NOT NULL THEN                                 #140728 mark 
                  LET l_cnt = 0 
                  SELECT COUNT(gzgg001) INTO l_cnt FROM gzgg_t
                   WHERE gzgg000 = l_gzgf000[l_k] AND gzgg002 = l_gzgdl001[l_lang_cnt] #141127 add
                     AND gzgg001 = l_dzgl[l_i].dzgl028    #140618 mark                     

                   #WHERE gzgg000 = p_gzgf000 AND gzgg002 = l_gzgdl001[l_lang_cnt]   #141127 mark
                    #AND gzgg001 = l_dzgl[l_i].dzgl005      #140618 add       
                  IF l_cnt = 0 THEN    ##將dzgl028直接存入gzgg001
                     #INSERT INTO gzgg_t VALUES(g_enterprise,p_gzgf000,l_dzgl[l_i].dzgl028,l_gzgdl001[l_lang_cnt],l_dzgl[l_i].dzgl006,l_dzgl[l_i].dzgl004, #140618 mark
                     #INSERT INTO gzgg_t   #140804 mark
                     #140804 add -(s)
                     #141127 將後面的先重新變更順序 -(s)
                     CALL adzp188_reset_gzgg004(l_gzgf000[l_k],l_gzgdl001[l_lang_cnt],l_dzgl[l_i].dzgl004)
                     #141127 將後面的先重新變更順序 -(e)

                     #151023-00015#1 add -(s)
                     #IF adzp188_chk_gzgg017_hadset_cnt(l_gzgf000[l_k],l_gzgdl001[l_lang_cnt]) > 1 THEN  ##若有設過gzgg017就將dzgl019清空 避免多設gzgg017 #160518-00036#1 mark
                     IF adzp188_chk_gzgg017_hadset_cnt(l_gzgf000[l_k],l_gzgdl001[l_lang_cnt]) > 0 THEN  ##若有設過gzgg017就將dzgl019清空 避免多設gzgg017  #160518-00036#1  add
                        LET l_dzgl[l_i].dzgl019 = ""
                     END IF 
                     #151023-00015#1 add -(e)
                     
                     INSERT INTO gzgg_t (gzgg000,gzgg001,gzgg002,gzgg003,gzgg004,gzgg005,gzgg006,gzgg007,gzgg008,
                                         gzgg009,gzgg010,gzgg011,gzgg012,gzgg013,gzgg014,gzgg015,gzgg016,gzgg017,
                                         gzgg018,gzgg019,gzgg020,gzgg021,gzgg022,gzgg023,gzgg024,gzgg025,gzgg026)
                     #140804 add -(e)                   
                            #VALUES(p_gzgf000,l_dzgl[l_i].dzgl028,l_gzgdl001[l_lang_cnt],l_dzgl[l_i].dzgl006,l_dzgl[l_i].dzgl004,  #140618 add  #141127 mark
                            VALUES(l_gzgf000[l_k],l_dzgl[l_i].dzgl028,l_gzgdl001[l_lang_cnt],l_dzgl[l_i].dzgl006,l_dzgl[l_i].dzgl004,  #141127 add   
                                   l_dzgl[l_i].dzgl007,l_dzgl[l_i].dzgl008,l_dzgl[l_i].dzgl009,l_dzgl[l_i].dzgl010,
                                   l_dzgl[l_i].dzgl011,l_dzgl[l_i].dzgl012,l_dzgl[l_i].dzgl013,l_dzgl[l_i].dzgl014,
                                   l_dzgl[l_i].dzgl015,l_dzgl[l_i].dzgl016,l_dzgl[l_i].dzgl017,l_dzgl[l_i].dzgl018,
                                   l_dzgl[l_i].dzgl019,l_dzgl[l_i].dzgl020,l_dzgl[l_i].dzgl021,l_dzgl[l_i].dzgl022,
                                   l_dzgl[l_i].dzgl023,l_dzgl[l_i].dzgl024,l_dzgl[l_i].dzgl025,l_dzgl[l_i].dzgl026,
                                   l_dzgl[l_i].dzgl027,l_dzgl[l_i].dzgl005)   #140618 mark
                                   #l_dzgl[l_i].dzgl027,l_dzgl[l_i].dzgl028)    #140618  add
                     IF STATUS THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = STATUS
                        LET g_errparam.extend = 'insert gzgg:'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF           
                     
                  ##140612 add -(e)           
                
                     ##140610 add -(s)
                      #IF l_gzgdl001[l_lang_cnt] ="zh_TW" THEN  #140728 mark
                          ##自定欄位存入欄位說明到gzge
                          LET l_cnt =0
                          LET l_dzgd005 =''
                          SELECT dzgd005 INTO l_dzgd005 FROM dzgd_t
                           #WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd003 = l_dzgl[l_i].dzgl028   #140618 mark
                           WHERE dzgd001 = g_dzga_m.dzga001 AND dzgd002 = g_dzga_m.dzga002 AND dzgd003 = l_dzgl[l_i].dzgl005   #140618 add 用原本欄位名找                    
                              AND dzgd008 = g_code_ide #140613 add  140624 mark AND dzga007 = g_cust
                          IF NOT cl_null(l_dzgd005) OR l_dzgd005 <> '' THEN     ##自定欄位說明是有資料              
                              SELECT COUNT(gzge003) INTO l_cnt FROM gzge_t
                               WHERE gzge000 = l_gzgf000[l_k]                                            #141127 add
                                AND gzge001 = l_dzgl[l_i].dzgl028 AND gzge002 = l_gzgdl001[l_lang_cnt]  #140618 mark  #用欄位別名找
                                #WHERE gzge000 = p_gzgf000 #140612 mark AND gzgfent = g_enterprise       #141127 mark
                                #AND gzge001 = l_dzgl[l_i].dzgl005 AND gzge002 = l_gzgdl001[l_lang_cnt]  #140618 add 
                              IF l_cnt = 0 THEN    ##而gzge沒存，則存入
                                  #150525-00029#1  add -(s)
                                  ##轉換多語言                                  
                                  IF g_lang <> l_gzgdl001[l_lang_cnt] THEN  #151023-00015#1 add 
                                    LET l_dzgd005 = cl_trans_code_tw_cn(l_gzgdl001[l_lang_cnt],l_dzgd005)
                                  END IF                                    #151023-00015#1 add 
                                  #150525-00029#1  add -(e)
                                  LET l_current = cl_get_current()                   
                                  INSERT INTO gzge_t (gzgestus,gzge000,gzge001,gzge002,gzge003,gzgeownid,  #140624 移除,gzgeent
                                                                   gzgeowndp,gzgecrtid,gzgecrtdp,gzgecrtdt)                                    
                                         VALUES ('Y',l_gzgf000[l_k],l_dzgl[l_i].dzgl028,   #141127 add 
                                         #VALUES ('Y',p_gzgf000,l_dzgl[l_i].dzgl028,   #140610 add #140618 mark  #140624 移除,g_enterprise 存入欄位別名  #141127 mark
                                         #VALUES ('Y',g_enterprise,p_gzgf000,l_dzgl[l_i].dzgl005,   #140618 add
                                                 l_gzgdl001[l_lang_cnt] ,l_dzgd005,g_user,g_dept,g_user,g_dept,l_current)
                                  IF SQLCA.sqlcode THEN
                                     INITIALIZE g_errparam TO NULL
                                     LET g_errparam.code = SQLCA.sqlcode
                                     LET g_errparam.extend = "gzge_t"
                                     LET g_errparam.popup = FALSE
                                     CALL cl_err()
                                  END IF
                                  ##141127 add -(s)
                                  ##組出來的欄位若在r.t找不到也要存入gzge(ex:xmdd_t_xmdd001)
                                  #LET l_cnt =0
                                  #LET l_dzebl003 =''
                                  ##先用組合出來的欄位名xmdd_t_xmdd001去找r.t有沒有欄位說明
                                  #SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t                      
                                   #WHERE dzebl001 = l_dzgl[l_i].dzgl028   # 用組合出來的欄位找                    
                                     #AND dzebl002 = l_gzgdl001[l_lang_cnt]  
                                  #IF cl_null(l_dzebl003) OR l_dzebl003 ='' OR l_dzebl003 IS NULL THEN
                                      ##先用原欄位名xmdd001去找r.t有沒有欄位說明
                                      #LET l_dzebl003 =''
                                      #SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t                      
                                       #WHERE dzebl001 = l_dzgl[l_i].dzgl005   # 原來的欄位名                    
                                          #AND dzebl002 = l_gzgdl001[l_lang_cnt]                          
                                  #END IF     
                                  #IF NOT cl_null(l_dzebl003) THEN                 
                                      #SELECT COUNT(gzge003) INTO l_cnt FROM gzge_t
                                       #WHERE gzge000 = l_gzgf000[l_k]
                                         #AND gzge001 = l_dzgl[l_i].dzgl028 AND gzge002 = l_gzgdl001[l_lang_cnt]  
                                      #IF l_cnt = 0 THEN    
                                          #LET l_current = cl_get_current()                   
                                          #INSERT INTO gzge_t (gzgestus,gzge000,gzge001,gzge002,gzge003,gzgeownid,  
                                                                           #gzgeowndp,gzgecrtid,gzgecrtdp,gzgecrtdt)                                    
                                                 #VALUES ('Y',l_gzgf000[l_k],l_dzgl[l_i].dzgl028,    
                                                         #l_gzgdl001[l_lang_cnt] ,l_dzebl003,g_user,g_dept,g_user,g_dept,l_current)
                                          #IF SQLCA.sqlcode THEN
                                             #INITIALIZE g_errparam TO NULL
                                             #LET g_errparam.code = SQLCA.sqlcode
                                             #LET g_errparam.extend = "gzge_t"
                                             #LET g_errparam.popup = FALSE
                                             #CALL cl_err()
                                          #END IF
                                     #END IF 
                                  #END IF 
                                  ##141127 add -(e)
                              END IF 
                          ##150521 增加非單頭與單身之外的欄位說明存入 add -(s)     
                          ELSE 
                                  LET l_dzebl003 = ''
                                  ##先用組合出來的欄位名xmdd_t_xmdd001去找r.t有沒有欄位說明
                                  SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t                      
                                   WHERE dzebl001 = l_dzgl[l_i].dzgl028   # 用組合出來的欄位找                    
                                     AND dzebl002 = l_gzgdl001[l_lang_cnt]  
                                  IF cl_null(l_dzebl003) OR l_dzebl003 ='' OR l_dzebl003 IS NULL THEN
                                      ##先用原欄位名xmdd001去找r.t有沒有欄位說明
                                      SELECT dzebl003 INTO l_dzebl003 FROM dzebl_t                      
                                       WHERE dzebl001 = l_dzgl[l_i].dzgl005   # 原來的欄位名                    
                                          AND dzebl002 = l_gzgdl001[l_lang_cnt]                          
                                  END IF     
                                  IF NOT cl_null(l_dzebl003) THEN                 
                                      SELECT COUNT(gzge003) INTO l_cnt FROM gzge_t
                                       WHERE gzge000 = l_gzgf000[l_k]
                                         AND gzge001 = l_dzgl[l_i].dzgl028 AND gzge002 = l_gzgdl001[l_lang_cnt]  
                                      IF l_cnt = 0 THEN    
                                          LET l_current = cl_get_current()                   
                                          INSERT INTO gzge_t (gzgestus,gzge000,gzge001,gzge002,gzge003,gzgeownid,  
                                                                           gzgeowndp,gzgecrtid,gzgecrtdp,gzgecrtdt)                                    
                                                 VALUES ('Y',l_gzgf000[l_k],l_dzgl[l_i].dzgl028,    
                                                         l_gzgdl001[l_lang_cnt] ,l_dzebl003,g_user,g_dept,g_user,g_dept,l_current)
                                          IF SQLCA.sqlcode THEN
                                             INITIALIZE g_errparam TO NULL
                                             LET g_errparam.code = SQLCA.sqlcode
                                             LET g_errparam.extend = "gzge_t"
                                             LET g_errparam.popup = FALSE
                                             CALL cl_err()
                                          END IF
                                     END IF 
                                  END IF 
                          ##150521 增加非單頭與單身之外的欄位說明存入 add -(e) 
                          END IF 
                      #END IF   #140728 mark
                     ##140610 add -(e)  
                  ##141127 add -(s)
                  ELSE  ##若有存在 那要更新gzgg_t 的gzgg004 欄位順序
                       UPDATE gzgg_t
                          SET gzgg004 = l_dzgl[l_i].dzgl004
                        WHERE gzgg000 = l_gzgf000[l_k] AND gzgg002 = l_gzgdl001[l_lang_cnt]
                          AND gzgg001 = l_dzgl[l_i].dzgl028    
                  ##141127 add -(s)
                  END IF 
              #END IF  #IF l_gzgdl001[l_lang_cnt] IS NOT NULL THEN  #160330-00019#3 mark
          END FOR 
        #141127 mark -(s)  
        #  LET l_i = l_i + 1
        #END FOREACH
       #141127 mark -(e)
        END FOR  #l_dzgl 
    END FOR     #141127 add
    ##141127 -(s) janet
    ##反向回去，用gzgg_t去查dzgl_t，若gzgg_t有而dzgl_t沒有，則gzgg_t要刪掉資料
    LET l_i = 1 
    CALL l_gzgg.clear()
    ##抓出gzgg_t 
    DECLARE adzp188_get_gzgg_data SCROLL CURSOR FOR
     SELECT * FROM gzgg_t 
      WHERE gzgg000 = ? AND gzgg002 = ?        


   FOR l_k = 1 TO l_gzgf000.getLength() 
       FOR l_lang_cnt = 1 TO l_gzgdl001.getLength()
           ##抓出gzgg_t資料
           LET l_i = 1
           FOREACH adzp188_get_gzgg_data USING l_gzgf000[l_k],l_gzgdl001[l_lang_cnt] INTO l_gzgg[l_i].*
             LET l_i = l_i + 1
           END FOREACH
           CALL l_gzgg.deleteElement(l_i)
            
           FOR l_i = 1 TO l_gzgg.getLength()

             IF (l_gzgg[l_i].gzgg017 <> '2' AND l_gzgg[l_i].gzgg017 <> '3' AND l_gzgg[l_i].gzgg017 <> '4') OR  l_gzgg[l_i].gzgg017 IS NULL THEN
           
                LET l_cnt = 0
                SELECT count(dzgl028) INTO l_cnt FROM dzgl_t                         
                 WHERE dzgl001 = g_dzga_m.dzga001 AND dzgl002 = g_dzga_m.dzga002
                   AND dzgl003 = g_dzga_m.dzga001
                   AND dzgl028 = l_gzgg[l_i].gzgg001   #用組合後的欄位名去找
                   AND dzgl030 = g_code_ide                           
                IF l_cnt = 0 THEN  #若反找dzgl沒有，代表dzgl刪了 所以gzgg_t也要跟著刪
                     DELETE FROM gzgg_t 
                      WHERE gzgg000 = l_gzgf000[l_k]     #報表樣板ID
                        AND gzgg002 = l_gzgdl001[l_lang_cnt]
                        AND gzgg001 = l_gzgg[l_i].gzgg001 
                      IF STATUS THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = STATUS
                         LET g_errparam.extend = 'delete gzgg_t:'
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         
                      END IF 
                     ##刪除多語言 
                     DELETE FROM gzge_t 
                      WHERE gzge000 = l_gzgf000[l_k]     #報表樣板ID
                        AND gzge002 = l_gzgdl001[l_lang_cnt]
                        AND gzge001 = l_gzgg[l_i].gzgg001 
                      IF STATUS THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = STATUS
                         LET g_errparam.extend = 'delete gzge_t:'
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         
                      END IF 
                END IF  
             END IF     
           END FOR  #l_gzgg
        END FOR #l_gzgdl001
    END FOR #l_gzgf000
    ##141127 -(e)
END FUNCTION
##140605 -(s)      


#140710 add -(s)
FUNCTION adzp188_set_usfield()
   DISPLAY "g_dzgd004_1:",g_dzgd004_1
   DISPLAY "g_dzgd004_2:",g_dzgd004_2
   #動態產生欄位頁簽中的-自訂欄位資料表選項 跟第一次的欄位選項
   IF g_dzgd004_1 IS NULL THEN  #141127 add g_dzgd004_1是空值才重整
      CALL adzp188_set_table_comboitems("formonly.dzgd004_1", FALSE) RETURNING g_dzgd004_1
      LET g_dzgd004_1 = "type_t"   #重設預設值
   END IF                       #141127 add  
   IF g_dzgd004_2 IS NULL THEN #141127 add  g_dzgd004_2是空值才重整
      CALL adzp188_set_field_comboitems("formonly.dzgd004_2", g_dzgd004_1, FALSE) RETURNING g_dzgd004_2
      LET g_dzgd004_2 = "chr30"     #重設預設值    ##140513 add
   END IF #141127 add
   IF g_dzgd006_1 IS NULL THEN  #141127 add
      LET g_dzgd006_1 = "1"     #重設預設值
   END IF                     #141127 add
END FUNCTION 
#140710 add -(e)


##141127 add -(s)
##重算插入之後的順序 都各+1
FUNCTION adzp188_reset_gzgg004(ps_gzgf000,ps_gzgg002,ps_gzgg004)
  DEFINE ps_gzgf000     LIKE gzgf_t.gzgf000
  DEFINE ps_gzgg002     LIKE gzgg_t.gzgg002
  DEFINE ps_gzgg004     LIKE gzgg_t.gzgg004 
  DEFINE l_gzgg_t       DYNAMIC ARRAY OF RECORD LIKE gzgg_t.* #報表元件設計-樣板明細檔(XG)
  DEFINE l_ii            LIKE type_t.num5

  CALL l_gzgg_t.clear()
  DECLARE get_gzgg_data_cs SCROLL CURSOR FOR
  SELECT * FROM gzgg_t
   WHERE gzgg000 = ps_gzgf000
     AND gzgg002 = ps_gzgg002
     AND gzgg004 > = ps_gzgg004 
   ORDER BY gzgg004 DESC

  LET l_ii = 1
  FOREACH get_gzgg_data_cs INTO l_gzgg_t[l_ii].*
     LET l_ii = l_ii + 1
  END FOREACH  
  CALL l_gzgg_t.deleteElement(l_ii)

  ##把傳入的順序之後全+1
  FOR l_ii = 1 TO l_gzgg_t.getLength()
      UPDATE gzgg_t SET gzgg004 = l_gzgg_t[l_ii].gzgg004 + 1
       WHERE gzgg000 = ps_gzgf000 
         AND gzgg001 = l_gzgg_t[l_ii].gzgg001
         AND gzgg002 = l_gzgg_t[l_ii].gzgg002
         
  END FOR
END FUNCTION
##141127 add -(e)

##141222 add -(s)
PUBLIC FUNCTION adzp188_unset_dzge005()

    UPDATE adzp188_dzge_tmp SET dzge005 = g_dzge005
     WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
       AND dzge003 = '2'
       AND dzge009 = g_code_ide    
END FUNCTION
##141222 add -(e)

##150120 add -(s)
PUBLIC FUNCTION adzp188_chk_dzgb_cnt()
DEFINE l_cnt          LIKE type_t.num5

    LET l_cnt = 0
    SELECT COUNT(dzgb001) INTO l_cnt FROM adzp188_dzgb_tmp
     WHERE dzgb001 = g_dzga_m.dzga001 AND dzgb002 = g_dzga_m.dzga002
       AND dzgb019 = g_code_ide   

    IF l_cnt = 0 THEN 
       RETURN FALSE
    ELSE
       RETURN TRUE
    END IF   


    
END FUNCTION

##150120 add -(e)


##150126 add -(s)
##判斷是否有卡迪苼效應
PUBLIC FUNCTION adzp188_chk_cartesian(p_sql)
DEFINE p_sql           STRING
DEFINE l_tmp_sql       STRING 
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_replce_str    STRING 



  LET l_tmp_sql = p_sql
  
   LET l_tmp_sql = " EXPLAIN plan FOR ",l_tmp_sql
   PREPARE adzp188_tmp_sql_pre FROM l_tmp_sql
   EXECUTE adzp188_tmp_sql_pre
   COMMIT WORK

   LET l_cnt = 0
   LET l_tmp_sql = ""
   LET l_tmp_sql = " SELECT COUNT(plan_table_output) ", 
                   " FROM TABLE (dbms_xplan.display('plan_table',NULL,'basic')) ",
                   " WHERE plan_table_output LIKE '%MERGE JOIN CARTESIAN%'"
   PREPARE adzp188_chk_cartesian_pre FROM l_tmp_sql                
   DECLARE adzp188_chk_cartesian_curs CURSOR FOR adzp188_chk_cartesian_pre
   OPEN adzp188_chk_cartesian_curs
   FETCH adzp188_chk_cartesian_curs INTO l_cnt   
   IF l_cnt > 0 THEN
      RETURN TRUE  
   ELSE
      RETURN FALSE 
   END IF
    
END FUNCTION
##150126 add -(e)


##150323 add 交叉表時，紙張設定、邊界等資訊設為灰階不可輸入  -(s)
PRIVATE FUNCTION adzp188_set_paper_data(p_visible)
DEFINE p_visible     BOOLEAN 
DEFINE l_color       STRING 

  ##紙張
   CALL cl_set_comp_entry("r_unit",p_visible)  #lbl_paperunit,
   CALL cl_set_comp_entry("r_direction",p_visible)  #lbl_paperdirection,
   CALL cl_set_comp_entry("r_format,c_std,custom",p_visible)  #lbl_papertype,
   CALL cl_set_comp_entry("len,s_len_unit",p_visible)    #lbl_paperlength,
   CALL cl_set_comp_entry("width,s_width_unit",p_visible) #lbl_paperwidth,

   ##邊界
   CALL cl_set_comp_entry("top,s_top_unit",p_visible)  #lbl_paper_top,
   CALL cl_set_comp_entry("left,s_left_unit",p_visible) #lbl_paper_left,
   CALL cl_set_comp_entry("right,s_right_unit",p_visible) #lbl_paper_right,
   CALL cl_set_comp_entry("botton,s_bot_unit",p_visible)    #lbl_paper_button,

   IF p_visible = TRUE THEN
      LET l_color ="black"
   ELSE 
      LET l_color ="gray"
   END IF 
   CALL cl_set_comp_font_color("c_std,custom,len,width,top,left,right,botton",l_color)
END FUNCTION 

##150323 add 交叉表時，紙張設定、邊界等資訊設為灰階不可輸入  -(e)

## 150527 #150525-00029#1 判斷參數頁籤是否有值 -(s)
PRIVATE FUNCTION adzp188_chk_dzgj_exist()
  DEFINE l_cnt           LIKE type_t.num5

  
  LET l_cnt = 0 

  SELECT COUNT(dzgj001) INTO l_cnt 
    #FROM dzgj_t            ##150617-00018 mark
    FROM adzp188_dzgj_tmp   ##150617-00018 add
   WHERE dzgj001 = g_dzga_m.dzga001 AND dzgj002 = g_dzga_m.dzga002
     #AND dzgj007 = g_cust AND dzgj008 = g_code_ide     #151023-00015 mark
     AND dzgj008 = g_code_ide                           #151023-00015 add
  
   
   RETURN l_cnt   

END FUNCTION 
## 150527 #150525-00029#1 判斷參數頁籤是否有值 -(s)


##151023-00015#1 -(s)
PRIVATE FUNCTION adzp188_chk_dzge_exist()
  DEFINE l_cnt           LIKE type_t.num5

  
  IF g_dzga_m.dzga003 = "1" THEN  ##憑證才要判斷
      LET l_cnt = 0 
      SELECT COUNT(dzge003) INTO l_cnt 
        FROM adzp188_dzge_tmp   
       WHERE dzge001 = g_dzga_m.dzga001 AND dzge002 = g_dzga_m.dzga002
         AND dzge003 ='2' AND dzge009 = g_code_ide                          
  ELSE
    LET l_cnt = 1
  END IF
  
   RETURN l_cnt
     
END FUNCTION 

PRIVATE FUNCTION adzp188_chk_gzgg017_hadset_cnt(p_gzgf000,p_gzgg002)
  DEFINE p_gzgf000        LIKE gzgf_t.gzgf000
  DEFINE p_gzgg002        LIKE gzgg_t.gzgg002
  DEFINE l_cnt            LIKE type_t.num5

  LET l_cnt = 0
  SELECT COUNT(gzgg017) INTO l_cnt
    FROM gzgg_t
   WHERE gzgg000 = p_gzgf000 AND gzgg002 = p_gzgg002
     AND gzgg017 = 'Y'                                    #160615-00007#1 add

  RETURN l_cnt 
  
END FUNCTION 
##151023-00015#1 -(s)



