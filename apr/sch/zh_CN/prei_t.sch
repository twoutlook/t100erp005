/* 
================================================================================
檔案代號:prei_t
檔案名稱:促銷談判結果明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prei_t
(
preient       number(5)      ,/* 企業編號 */
preiunit       varchar2(10)      ,/* 制定組織 */
preisite       varchar2(10)      ,/* 營運據點 */
preiacti       varchar2(10)      ,/* 狀態 */
preiseq       number(10,0)      ,/* 項次 */
prei001       varchar2(20)      ,/* 規則編號 */
prei002       varchar2(10)      ,/* 版本 */
prei003       varchar2(10)      ,/* 庫區編號 */
prei004       varchar2(10)      ,/* 專櫃編號 */
prei005       varchar2(10)      ,/* 部門編號 */
prei006       varchar2(10)      ,/* 品類 */
prei007       varchar2(1)      ,/* 整倍送出否 */
prei008       number(20,6)      ,/* 送出上限金額 */
prei009       number(20,6)      ,/* 非VIP贈送起點 */
prei010       number(20,6)      ,/* 非VIP贈送金額 */
prei011       number(20,6)      ,/* 會員等級一贈送起點 */
prei012       number(20,6)      ,/* 會員等級一贈送金額 */
prei013       number(20,6)      ,/* 會員等級二贈送起點 */
prei014       number(20,6)      ,/* 會員等級二贈送金額 */
prei015       number(20,6)      ,/* 會員等級三贈送起點 */
prei016       number(20,6)      ,/* 會員等級三贈送金額 */
prei017       number(20,6)      ,/* 會員等級四贈送起點 */
prei018       number(20,6)      ,/* 會員等級四贈送金額 */
prei019       number(20,6)      ,/* 會員等級五贈送起點 */
prei020       number(20,6)      ,/* 會員等級五贈送金額 */
prei021       number(20,6)      ,/* 促銷折扣率 */
prei022       varchar2(1)      ,/* 整倍接券否 */
prei023       number(20,6)      ,/* 接券上限金額 */
prei024       varchar2(10)      ,/* 接卡1 */
prei025       varchar2(10)      ,/* 接卡2 */
prei026       varchar2(10)      ,/* 接卡3 */
prei027       varchar2(10)      ,/* 接卡4 */
prei028       varchar2(10)      ,/* 接卡5 */
prei029       varchar2(10)      ,/* 接券1 */
prei030       varchar2(10)      ,/* 接券2 */
prei031       varchar2(10)      ,/* 接券3 */
prei032       varchar2(10)      ,/* 接券4 */
prei033       varchar2(10)      ,/* 接券5 */
prei034       number(20,6)      ,/* 非VIP限接起點 */
prei035       number(20,6)      ,/* 非VIP限接金額 */
prei036       number(20,6)      ,/* 會員等級一限接起點 */
prei037       number(20,6)      ,/* 會員等級一限接金額 */
prei038       number(20,6)      ,/* 會員等級二限接起點 */
prei039       number(20,6)      ,/* 會員等級二限接金額 */
prei040       number(20,6)      ,/* 會員等級三限接起點 */
prei041       number(20,6)      ,/* 會員等級三限接金額 */
prei042       number(20,6)      ,/* 會員等級四限接起點 */
prei043       number(20,6)      ,/* 會員等級四限接金額 */
prei044       number(20,6)      ,/* 會員等級五限接起點 */
prei045       number(20,6)      ,/* 會員等級五限接金額 */
prei046       number(20,6)      ,/* 非VIP價內加扣點 */
prei047       number(20,6)      ,/* 會員等級一價內加扣點 */
prei048       number(20,6)      ,/* 會員等級二價內加扣點 */
prei049       number(20,6)      ,/* 會員等級三價內加扣點 */
prei050       number(20,6)      ,/* 會員等級四價內加扣點 */
prei051       number(20,6)      ,/* 會員等級五價內加扣點 */
prei052       number(20,6)      ,/* 參考價內加扣點 */
prei053       number(20,6)      ,/* 最近價內加扣點 */
prei054       number(20,6)      ,/* 最高價內加扣點 */
prei055       number(20,6)      ,/* 保盈利價內加扣點 */
prei056       number(20,6)      ,/* 保本價內加扣點 */
prei057       number(20,6)      ,/* 合同扣率 */
prei058       number(20,6)      ,/* 執行扣率 */
prei059       varchar2(1)      ,/* 參與合同保底否 */
prei060       varchar2(10)      ,/* 保底方式 */
prei061       varchar2(10)      ,/* 分量扣點方式 */
prei062       varchar2(1)      ,/* POS折扣否 */
prei063       number(20,6)      ,/* 非VIP回款率 */
prei064       number(20,6)      ,/* 會員等級一回款率 */
prei065       number(20,6)      ,/* 會員等級二回款率 */
prei066       number(20,6)      ,/* 會員等級三回款率 */
prei067       number(20,6)      ,/* 會員等級四回款率 */
prei068       number(20,6)      ,/* 會員等級五回款率 */
prei069       number(20,6)      ,/* 參與回款率 */
prei070       number(20,6)      ,/* 保本回款率 */
prei071       number(20,6)      ,/* 保盈利回款率 */
prei072       number(20,6)      ,/* 最近回款率 */
prei073       number(20,6)      ,/* 最低迴款率 */
prei074       varchar2(1)      ,/* 是否參加疊加活動 */
prei075       varchar2(10)      ,/* 評估結果 */
prei076       varchar2(10)      ,/* 備用欄位1 */
prei077       varchar2(10)      ,/* 備用欄位2 */
prei078       number(20,6)      ,/* 固定費用金額 */
prei079       varchar2(255)      ,/* 填寫活動內容 */
prei080       varchar2(1)      ,/* 會員折扣否 */
prei081       varchar2(10)      ,/* 促銷狀態 */
prei082       varchar2(1)      ,/* 會員積分否 */
prei083       number(20,6)      ,/* 促銷會員等級一折率 */
prei084       number(22,2)      ,/* 促銷會員等級一積分 */
prei085       number(20,6)      ,/* 促銷會員等級二折率 */
prei086       number(22,2)      ,/* 促銷會員等級二積分 */
prei087       number(20,6)      ,/* 促銷會員等級三折率 */
prei088       number(22,2)      ,/* 促銷會員等級三積分 */
prei089       number(20,6)      ,/* 促銷會員等級四折率 */
prei090       number(22,2)      ,/* 促銷會員等級四積分 */
prei091       number(20,6)      ,/* 促銷會員等級五折率 */
prei092       number(22,2)      ,/* 促銷會員等級五積分 */
prei093       number(20,6)      ,/* 會員等級一供應商承擔比例 */
prei094       number(20,6)      ,/* 會員等級二供應商承擔比例 */
prei095       number(20,6)      ,/* 會員等級三供應商承擔比例 */
prei096       number(20,6)      ,/* 會員等級四供應商承擔比例 */
prei097       number(20,6)      ,/* 會員等級五供應商承擔比例 */
prei098       timestamp(0)      ,/* 終止日期 */
prei099       varchar2(20)      ,/* 終止人員 */
prei100       varchar2(10)      /* 扣點方式 */
);
alter table prei_t add constraint prei_pk primary key (preient,preiseq,prei001) enable validate;

create unique index prei_pk on prei_t (preient,preiseq,prei001);

grant select on prei_t to tiptop;
grant update on prei_t to tiptop;
grant delete on prei_t to tiptop;
grant insert on prei_t to tiptop;

exit;
