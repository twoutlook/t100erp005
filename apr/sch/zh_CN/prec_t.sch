/* 
================================================================================
檔案代號:prec_t
檔案名稱:促銷談判條件明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prec_t
(
precent       number(5)      ,/* 企業編號 */
precunit       varchar2(10)      ,/* 制定組織 */
precsite       varchar2(10)      ,/* 營運據點 */
precacti       varchar2(10)      ,/* 狀態 */
precdocno       varchar2(20)      ,/* 促銷申請單號 */
precseq       number(10,0)      ,/* 項次 */
prec001       varchar2(20)      ,/* 規則編號 */
prec002       varchar2(10)      ,/* 版本 */
prec003       varchar2(10)      ,/* 庫區編號 */
prec004       varchar2(10)      ,/* 專櫃編號 */
prec005       varchar2(10)      ,/* 部門編號 */
prec006       varchar2(10)      ,/* 品類 */
prec007       varchar2(1)      ,/* 整倍送出否 */
prec008       number(20,6)      ,/* 送出上限金額 */
prec009       number(20,6)      ,/* 非VIP贈送起點 */
prec010       number(20,6)      ,/* 非VIP贈送金額 */
prec011       number(20,6)      ,/* 會員等級一贈送起點 */
prec012       number(20,6)      ,/* 會員等級一贈送金額 */
prec013       number(20,6)      ,/* 會員等級二贈送起點 */
prec014       number(20,6)      ,/* 會員等級二贈送金額 */
prec015       number(20,6)      ,/* 會員等級三贈送起點 */
prec016       number(20,6)      ,/* 會員等級三贈送金額 */
prec017       number(20,6)      ,/* 會員等級四贈送起點 */
prec018       number(20,6)      ,/* 會員等級四贈送金額 */
prec019       number(20,6)      ,/* 會員等級五贈送起點 */
prec020       number(20,6)      ,/* 會員等級五贈送金額 */
prec021       number(20,6)      ,/* 促銷折扣率 */
prec022       varchar2(1)      ,/* 整倍接券否 */
prec023       number(20,6)      ,/* 接券上限金額 */
prec024       varchar2(10)      ,/* 接卡1 */
prec025       varchar2(10)      ,/* 接卡2 */
prec026       varchar2(10)      ,/* 接卡3 */
prec027       varchar2(10)      ,/* 接卡4 */
prec028       varchar2(10)      ,/* 接卡5 */
prec029       varchar2(10)      ,/* 接券1 */
prec030       varchar2(10)      ,/* 接券2 */
prec031       varchar2(10)      ,/* 接券3 */
prec032       varchar2(10)      ,/* 接券4 */
prec033       varchar2(10)      ,/* 接券5 */
prec034       number(20,6)      ,/* 非VIP限接起點 */
prec035       number(20,6)      ,/* 非VIP限接金額 */
prec036       number(20,6)      ,/* 會員等級一限接起點 */
prec037       number(20,6)      ,/* 會員等級一限接金額 */
prec038       number(20,6)      ,/* 會員等級二限接起點 */
prec039       number(20,6)      ,/* 會員等級二限接金額 */
prec040       number(20,6)      ,/* 會員等級三限接起點 */
prec041       number(20,6)      ,/* 會員等級三限接金額 */
prec042       number(20,6)      ,/* 會員等級四限接起點 */
prec043       number(20,6)      ,/* 會員等級四限接金額 */
prec044       number(20,6)      ,/* 會員等級五限接起點 */
prec045       number(20,6)      ,/* 會員等級五限接金額 */
prec046       number(20,6)      ,/* 非VIP價內加扣點 */
prec047       number(20,6)      ,/* 會員等級一價內加扣點 */
prec048       number(20,6)      ,/* 會員等級二價內加扣點 */
prec049       number(20,6)      ,/* 會員等級三價內加扣點 */
prec050       number(20,6)      ,/* 會員等級四價內加扣點 */
prec051       number(20,6)      ,/* 會員等級五價內加扣點 */
prec052       number(20,6)      ,/* 參考價內加扣點 */
prec053       number(20,6)      ,/* 最近價內加扣點 */
prec054       number(20,6)      ,/* 最高價內加扣點 */
prec055       number(20,6)      ,/* 保盈利價內加扣點 */
prec056       number(20,6)      ,/* 保本價內加扣點 */
prec057       number(20,6)      ,/* 合同扣率 */
prec058       number(20,6)      ,/* 執行扣率 */
prec059       varchar2(1)      ,/* 參與合同保底否 */
prec060       varchar2(10)      ,/* 保底方式 */
prec061       varchar2(10)      ,/* 分量扣點方式 */
prec062       varchar2(1)      ,/* POS折扣否 */
prec063       number(20,6)      ,/* 非VIP回款率 */
prec064       number(20,6)      ,/* 會員等級一回款率 */
prec065       number(20,6)      ,/* 會員等級二回款率 */
prec066       number(20,6)      ,/* 會員等級三回款率 */
prec067       number(20,6)      ,/* 會員等級四回款率 */
prec068       number(20,6)      ,/* 會員等級五回款率 */
prec069       number(20,6)      ,/* 參與回款率 */
prec070       number(20,6)      ,/* 保本回款率 */
prec071       number(20,6)      ,/* 保盈利回款率 */
prec072       number(20,6)      ,/* 最近回款率 */
prec073       number(20,6)      ,/* 最低迴款率 */
prec074       varchar2(1)      ,/* 是否參加疊加活動 */
prec075       varchar2(10)      ,/* 評估結果 */
prec076       varchar2(10)      ,/* 備用欄位1 */
prec077       varchar2(10)      ,/* 備用欄位2 */
prec078       number(20,6)      ,/* 固定費用金額 */
prec079       varchar2(255)      ,/* 填寫活動內容 */
prec080       varchar2(1)      ,/* 會員折扣否 */
prec081       varchar2(10)      ,/* 促銷狀態 */
prec082       varchar2(1)      ,/* 會員積分否 */
prec083       number(20,6)      ,/* 促銷會員等級一折率 */
prec084       number(22,2)      ,/* 促銷會員等級一積分 */
prec085       number(20,6)      ,/* 促銷會員等級二折率 */
prec086       number(22,2)      ,/* 促銷會員等級二積分 */
prec087       number(20,6)      ,/* 促銷會員等級三折率 */
prec088       number(22,2)      ,/* 促銷會員等級三積分 */
prec089       number(20,6)      ,/* 促銷會員等級四折率 */
prec090       number(22,2)      ,/* 促銷會員等級四積分 */
prec091       number(20,6)      ,/* 促銷會員等級五折率 */
prec092       number(22,2)      ,/* 促銷會員等級五積分 */
prec093       number(20,6)      ,/* 會員等級一供應商承擔比例 */
prec094       number(20,6)      ,/* 會員等級二供應商承擔比例 */
prec095       number(20,6)      ,/* 會員等級三供應商承擔比例 */
prec096       number(20,6)      ,/* 會員等級四供應商承擔比例 */
prec097       number(20,6)      ,/* 會員等級五供應商承擔比例 */
prec098       varchar2(10)      /* 扣點方式 */
);
alter table prec_t add constraint prec_pk primary key (precent,precdocno,precseq) enable validate;

create unique index prec_pk on prec_t (precent,precdocno,precseq);

grant select on prec_t to tiptop;
grant update on prec_t to tiptop;
grant delete on prec_t to tiptop;
grant insert on prec_t to tiptop;

exit;
