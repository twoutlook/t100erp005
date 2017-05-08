/* 
================================================================================
檔案代號:prel_t
檔案名稱:aprt310促銷談判條件申請檔excel匯入使用中間表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prel_t
(
prelent       number(5)      ,/* 企業代碼 */
prelsite       varchar2(10)      ,/* 營運據點 */
prel1000       varchar2(500)      ,/* 門店名稱 */
prel1001       varchar2(500)      ,/* 促銷規則說明 */
prel1003       varchar2(30)      ,/* 促銷方案編號 */
prel1004       varchar2(10)      ,/* 促銷方式 */
prel1005       varchar2(10)      ,/* 換贈對象 */
prel1006       varchar2(10)      ,/* 換贈編號 */
prel2003       date      ,/* 開始日期 */
prel2004       date      ,/* 結束日期 */
prel2005       varchar2(8)      ,/* 開始時間 */
prel2006       varchar2(8)      ,/* 結束時間 */
prel1011       varchar2(20)      ,/* 申請人員 */
prel3003       varchar2(10)      ,/* 庫區編號 */
prel30030       varchar2(500)      ,/* 庫區名稱 */
prel3004       varchar2(10)      ,/* 專櫃編號 */
prel30040       varchar2(500)      ,/* 專櫃名稱 */
prel3007       varchar2(1)      ,/* 整倍送出否 */
prel3008       number(20,6)      ,/* 送出上限金額 */
prel3009       number(20,6)      ,/* 非VIP贈送起點 */
prel3010       number(20,6)      ,/* 非VIP贈送金額 */
prel3011       number(20,6)      ,/* 會員等級一贈送起點 */
prel3012       number(20,6)      ,/* 會員等級一贈送金額 */
prel3013       number(20,6)      ,/* 會員等級二贈送起點 */
prel3014       number(20,6)      ,/* 會員等級二贈送金額 */
prel3015       number(20,6)      ,/* 會員等級三贈送起點 */
prel3016       number(20,6)      ,/* 會員等級三贈送金額 */
prel3017       number(20,6)      ,/* 會員等級四贈送起點 */
prel3018       number(20,6)      ,/* 會員等級四贈送金額 */
prel3019       number(20,6)      ,/* 會員等級五贈送起點 */
prel3020       number(20,6)      ,/* 會員等級五贈送金額 */
prel3022       varchar2(1)      ,/* 整倍接券否 */
prel3023       number(20,6)      ,/* 接券上限金額 */
prel3024       varchar2(10)      ,/* 接卡1 */
prel3025       varchar2(10)      ,/* 接卡2 */
prel3026       varchar2(10)      ,/* 接卡3 */
prel3027       varchar2(10)      ,/* 接卡4 */
prel3028       varchar2(10)      ,/* 接卡5 */
prel3029       varchar2(10)      ,/* 接券1 */
prel3030       varchar2(10)      ,/* 接券2 */
prel3031       varchar2(10)      ,/* 接券3 */
prel3032       varchar2(10)      ,/* 接券4 */
prel3033       varchar2(10)      ,/* 接券5 */
prel3034       number(20,6)      ,/* 非VIP限接起點 */
prel3035       number(20,6)      ,/* 非VIP限接金額 */
prel3036       number(20,6)      ,/* 會員等級一限接起點 */
prel3037       number(20,6)      ,/* 會員等級一限接金額 */
prel3038       number(20,6)      ,/* 會員等級二限接起點 */
prel3039       number(20,6)      ,/* 會員等級二限接金額 */
prel3040       number(20,6)      ,/* 會員等級三限接起點 */
prel3041       number(20,6)      ,/* 會員等級三限接金額 */
prel3042       number(20,6)      ,/* 會員等級四限接起點 */
prel3043       number(20,6)      ,/* 會員等級四限接金額 */
prel3044       number(20,6)      ,/* 會員等級五限接起點 */
prel3045       number(20,6)      ,/* 會員等級五限接金額 */
prel3098       varchar2(10)      ,/* 扣點方式 */
prel3046       number(20,6)      ,/* 非VIP價內加扣點 */
prel3047       number(20,6)      ,/* 會員等級一價內加扣點 */
prel3048       number(20,6)      ,/* 會員等級二價內加扣點 */
prel3049       number(20,6)      ,/* 會員等級三價內加扣點 */
prel3050       number(20,6)      ,/* 會員等級四價內加扣點 */
prel3051       number(20,6)      ,/* 會員等級五價內加扣點 */
prel3058       number(20,6)      ,/* 執行扣率 */
prel3059       varchar2(1)      ,/* 參與合同保底否 */
prel3060       varchar2(10)      ,/* 保底方式 */
prel3061       varchar2(10)      ,/* 分量扣點方式 */
prel3062       varchar2(1)      ,/* POS折扣否 */
prel3074       varchar2(1)      ,/* 是否參加疊加活動 */
prel3079       varchar2(255)      ,/* 填寫活動內容 */
prel3080       varchar2(1)      ,/* 會員折扣否 */
prel3082       varchar2(1)      ,/* 會員積分否 */
prel3083       number(20,6)      ,/* 促銷會員等級一折率 */
prel3084       number(22,2)      ,/* 促銷會員等級一積分 */
prel3085       number(20,6)      ,/* 促銷會員等級二折率 */
prel3086       number(22,2)      ,/* 促銷會員等級二積分 */
prel3087       number(20,6)      ,/* 促銷會員等級三折率 */
prel3088       number(22,2)      ,/* 促銷會員等級三積分 */
prel3089       number(20,6)      ,/* 促銷會員等級四折率 */
prel3090       number(22,2)      ,/* 促銷會員等級四積分 */
prel3091       number(20,6)      ,/* 促銷會員等級五折率 */
prel3092       number(22,2)      ,/* 促銷會員等級五積分 */
prel3093       number(20,6)      ,/* 會員等級一供應商承擔比例 */
prel3094       number(20,6)      ,/* 會員等級二供應商承擔比例 */
prel3095       number(20,6)      ,/* 會員等級三供應商承擔比例 */
prel3096       number(20,6)      ,/* 會員等級四供應商承擔比例 */
prel3097       number(20,6)      ,/* 會員等級五供應商承擔比例 */
prel1051       varchar2(10)      ,/* 主題分類 */
prel1052       varchar2(10)      /* 促銷類型 */
);


grant select on prel_t to tiptop;
grant update on prel_t to tiptop;
grant delete on prel_t to tiptop;
grant insert on prel_t to tiptop;

exit;
